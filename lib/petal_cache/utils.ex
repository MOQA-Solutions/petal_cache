defmodule PetalCache.Utils do

  @garbage_collector :garbage_collector

  def pid_to_string(pid) do 
    pid
    |> :erlang.pid_to_list()
    |> to_string()
  end

  def string_to_pid(str) do
    str
    |> String.to_charlist() 
    |> :erlang.list_to_pid()
  end

  def get_garbage_collector(), do: 
    @garbage_collector
end