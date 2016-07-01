defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  alias KV.Bucket, as: KVB

  setup do
    {:ok, bucket} = KVB.start_link
    {:ok, bucket: bucket} # put it into the test context
  end

  test "stores values by key", %{bucket: bucket} do # match it from the test context
    assert KVB.get(bucket, "milk") == nil

    KVB.put(bucket, "milk", 3)
    assert KVB.get(bucket, "milk") == 3
  end

  test "deletes keys and returns their current values", %{bucket: bucket} do
    assert KVB.get(bucket, "milk") == nil
    assert KVB.delete(bucket, "milk") == nil

    KVB.put(bucket, "milk", 33)
    assert KVB.get(bucket, "milk") == 33
    assert KVB.delete(bucket, "milk") == 33
    assert KVB.get(bucket, "milk") == nil
  end
end
