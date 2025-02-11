defmodule PetalCache.Utils do

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
end