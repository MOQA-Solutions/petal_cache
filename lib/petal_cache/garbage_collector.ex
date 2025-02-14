defmodule PetalCache.GarbageCollector do 

  use GenServer

  alias PetalCache.Utils

  def start_link(args), do: 
    GenServer.start_link(__MODULE__, args, name: Utils.get_garbage_collector())

  def init(args) do 
    _ = PetalCache.init_table()
    Process.flag(:trap_exit, true)
    {:ok, %{parent: args[:parent]}}
  end

  def handle_call(_call, _from, state), do: {:noreply, state}

  def handle_cast(_cast, state), do: {:noreply, state}

  def handle_info({:"EXIT", parent, reason}, %{parent: parent}) do 
    exit("Parent exit: #{reason}")
  end

  def handle_info({:"EXIT", pid, _reason}, state) do
    :ok = clear_tmp_data(pid)
    {:noreply, state}
  end

  def handle_info(_info, state), do: {:noreply, state}

############################################################################################### 

  defp clear_tmp_data(pid) do
    pid
    |> Utils.pid_to_string()
    |> PetalCache.delete()
    :ok
  end
end

  