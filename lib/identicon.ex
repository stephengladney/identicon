defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    len = hex |> length
    if rem(len,3) != 0 do
      Enum.drop(hex, rem(len,3) * -1)
      else
      hex
    end
    |> Enum.chunk_every(3)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def mirror_row([first, second | _third] = row) do
    row ++ [second, first]
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    
    %Identicon.Image{hex: hex}
  end
end
