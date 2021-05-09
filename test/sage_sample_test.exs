defmodule SageSampleTest do
  use ExUnit.Case
  doctest SageSample

  test "greets the world" do
    assert SageSample.hello() == :world
  end
end
