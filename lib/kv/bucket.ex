defmodule KV.Bucket do
  @doc "Starts a new bucket."
  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  @doc "Get a value from the `bucket` by `key`."
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
    # Agent.get(bucket, fn x -> Map.get(x, key) end)
  end

  @doc "Puts the `value` for the given `key` in the `bucket`."
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
    # Agent.update(bucket, fn x -> Map.put(x, key, value) end)
  end

  @doc """
  Deletes `key` from `bucket`.

  Returns the current value of `key`, if `key` exists.
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
