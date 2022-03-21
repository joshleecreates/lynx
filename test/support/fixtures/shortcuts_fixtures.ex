defmodule Lynx.ShortcutsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lynx.Shortcuts` context.
  """

  @doc """
  Generate a shortened_uri.
  """
  def shortened_uri_fixture(attrs \\ %{}) do
    {:ok, shortened_uri} =
      attrs
      |> Enum.into(%{
        slug: "some slug",
        uri: "some uri"
      })
      |> Lynx.Shortcuts.create_shortened_uri()

    shortened_uri
  end
end
