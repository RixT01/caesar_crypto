defmodule CaesarCrypto do
  @moduledoc """
  Documentation for CaesarCrypto.
  """

  def ux do
    choice = IO.gets "Encriptar[E], Desencriptar[D] o BruteForce[B]?\n"
    
    case choice do
      "E\n" ->
        plain_text = (IO.gets "Texto a encriptar:\n")
        |> String.replace("\n", "")

        key = (IO.gets "Llave a usar:\n")
        |> String.replace("\n", "")
        |> String.to_integer

        encrypt(key, plain_text)
        |> IO.inspect

      "D\n" ->
        cipher_text = (IO.gets "Texto a desencriptar:\n")
        |> String.replace("\n", "")

        key = (IO.gets "Llave a usar:\n")
        |> String.replace("\n", "")
        |> String.to_integer

        decrypt(key, cipher_text)
        |> IO.inspect
      "B\n" ->
        plain_text = (IO.gets "Plain text:\n")
        |> String.replace("\n", "")
        #|> IO.inspect

        cipher_text = (IO.gets "Cipher text:\n")
        |> String.replace("\n", "")
        #|> IO.inspect


        brute_force(plain_text, cipher_text)
        |> IO.inspect
      _ ->
        IO.puts "Opcion invalida."
    end

    ux()

  end

  def decrypt key, cipher_text do
    convert(cipher_text)
    |> Enum.map(fn (num) -> loop_around(num, key) end) 
    |> convert()
  end

  def encrypt key, plain_text do
    convert(plain_text)
    |> Enum.map(fn (num) -> rem((num + key), 26) end)
    |> convert()
  end

  #si no encuentra la llave, tomar ciphoer_text como base e imprimir todos los plain_text
  def brute_force plain_text, cipher_text do
    Enum.to_list(1..26)
    |> brute_force(plain_text, cipher_text)
  end

  #will turn string to a num list
  defp convert(my_text) when is_binary(my_text) do
    dictionary = %{:a => 1, :b => 2, :c => 3, :d => 4, :e => 5, :f => 6, :g => 7, :h => 8, :i => 9, :j => 10, :k => 11, :l => 12, :m => 13, :n => 14, :o => 15, :p => 16, :q => 17, :r => 18, :s => 19, :t => 20, :u => 21, :v => 22, :w => 23, :x => 24, :y => 25, :z => 26 }
    String.downcase(my_text)
    |> String.graphemes()
    |> Enum.map(fn(char) -> String.to_atom(char)   end)
    |> Enum.map(fn(char) -> dictionary[char]   end)
    
  end

  # #will turn a num list into a string
  defp convert num_list do
    dictionary = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    Enum.map(num_list, fn(num) -> Enum.at(dictionary, num-1) end)
    |> Enum.join("")
  end

  defp loop_around num, key do
    new_index = num - key
    if new_index <=0 do
      26 + new_index
    else
      new_index
    end
  end

  defp brute_force([], _, cipher_text) do
    IO.puts("No se encontro una llave satisfactoria, estos fueron los resultados:\n")
    Enum.to_list(1..26)
    |> Enum.map(fn (i) -> [i, decrypt(i, cipher_text)] end )
  end

  defp brute_force([head | tail], plain_text, cipher_text) do
    if decrypt(head, cipher_text) == plain_text do
      head
    else
      brute_force(tail, plain_text, cipher_text)
    end
  end

end
