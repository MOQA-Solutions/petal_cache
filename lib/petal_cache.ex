defmodule PetalCache do

  @table :petal_cache

  alias PetalCache.Utils

  def init_table(), do: 
    :ets.new(@table, [:public, :named_table])

  def get(key) do
    case :ets.lookup(@table, key) do 
      [{_key, value}] -> 
        {:ok, value}
      [] -> 
        :error 
    end 
  end 

  def put(key, value), do: 
    :ets.insert(@table, {key, value}) 

  def delete(key), do: 
    :ets.delete(@table, key)

  def get_cache(), do: 
    self()
    |> Utils.pid_to_string() 
    |> get()
    |> elem(1) 

  def put_cache(messages), do: 
    self()
    |> Utils.pid_to_string()
    |> put(messages)

end


