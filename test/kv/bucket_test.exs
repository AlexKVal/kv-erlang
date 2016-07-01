defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket} # put it into the test context
  end

  test "stores values by key", %{bucket: bucket} do # match it from the test context
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes keys and returns their current values", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
    assert KV.Bucket.delete(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 33)
    assert KV.Bucket.get(bucket, "milk") == 33
    assert KV.Bucket.delete(bucket, "milk") == 33
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
