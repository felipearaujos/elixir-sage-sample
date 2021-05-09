defmodule SageSample do
  require Sage
  require Logger

  def do_something do
    Sage.new()
    |> Sage.run(:first, &first_step/2)
    |> Sage.run(:second, &second_step/2, &compensate_second_step/3)
    |> Sage.finally(&acknowledge_job/2)
    |> Sage.execute()
  end

  defp first_step(effects_so_far, params) do
    Logger.info("[first_step] effects_so_far -> #{inspect(effects_so_far)}")
    Logger.info("[first_step] params -> #{inspect(params)}")
    {:ok, :success_first_step}
  end

  defp second_step(_effects_so_far, _attrs) do
    :rand.uniform(2)
    |> case do
      1 ->
        Logger.info("[second_step] {:error, :god_error}")
        {:error, :god_error}

      2 ->
        Logger.info("[second_step] {:ok, :working}")
        {:ok, :working}
    end
  end

  def acknowledge_job(:ok, _attrs) do
    Logger.info("[acknowledge_job] successfully")
  end

  def acknowledge_job(_error, _attrs) do
    Logger.warn("[acknowledge_job] failed ")
  end

  def compensate_second_step(_effect_to_compensate, params, _attrs) do
    # We want to apply forward compensation from :subscription stage for 5 times
    Logger.info("[compensate_second_step] -> #{inspect(params)}")
    {:retry, retry_limit: 5, base_backoff: 10, max_backoff: 30_000}
  end
end
