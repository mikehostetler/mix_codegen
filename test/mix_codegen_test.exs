defmodule MixCodegenTest do
  use ExUnit.Case
  doctest MixCodegen

  test "greets the world" do
    assert MixCodegen.hello() == :world
  end
end
