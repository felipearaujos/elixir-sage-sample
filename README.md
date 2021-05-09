# SageSample



# Sample working

With god error

```elixir

iex(11)> SageSample.do_something

15:38:29.193 [info]  [first_step] effects_so_far -> %{}

15:38:29.193 [info]  [first_step] params -> []

15:38:29.193 [info]  [second_step] {:error, :god_error}

15:38:29.193 [info]  [compensate_second_step] -> %{first: :success_first_step}

15:38:29.215 [info]  [second_step] {:ok, :working}

15:38:29.215 [info]  [acknowledge_job] successfully

```

Success 

```elixir

iex(12)> SageSample.do_something

15:40:33.296 [info]  [first_step] params -> []

15:40:33.296 [info]  [second_step] {:ok, :working}

15:40:33.296 [info]  [acknowledge_job] successfully

```