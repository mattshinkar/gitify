defmodule GitifyTest do
  use ExUnit.Case
  doctest Gitify

  test "greets the world" do
    assert Gitify.hello() == :world
  end
end
