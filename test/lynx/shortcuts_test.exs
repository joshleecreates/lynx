defmodule Lynx.ShortcutsTest do
  use Lynx.DataCase

  alias Lynx.Shortcuts

  describe "uris" do
    alias Lynx.Shortcuts.ShortenedURI

    import Lynx.ShortcutsFixtures

    @invalid_attrs %{uri: nil}

    test "get_shortened_uri!/1 returns the shortened_uri with given id" do
      shortened_uri = shortened_uri_fixture()
      assert Shortcuts.get_shortened_uri!(shortened_uri.slug) == shortened_uri
    end

    test "create_shortened_uri/1 with valid data creates a shortened_uri" do
      valid_attrs = %{uri: "https://www.stord.com"}

      assert {:ok, %ShortenedURI{} = shortened_uri} = Shortcuts.create_shortened_uri(valid_attrs)
      assert shortened_uri.uri == "https://www.stord.com"
    end

    test "create_shortened_uri/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortcuts.create_shortened_uri(@invalid_attrs)
    end
  end
end
