defmodule CaesarCryptoTest do
  use ExUnit.Case
  doctest CaesarCrypto

  test "greets the world" do
    assert CaesarCrypto.hello() == :world
  end
end
