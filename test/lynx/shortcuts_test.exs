defmodule Lynx.ShortcutsTest do
  use Lynx.DataCase

  alias Lynx.Shortcuts

  describe "uris" do
    alias Lynx.Shortcuts.ShortenedURI

    import Lynx.ShortcutsFixtures

    @invalid_attrs %{slug: nil, uri: nil}

    test "list_uris/0 returns all uris" do
      shortened_uri = shortened_uri_fixture()
      assert Shortcuts.list_uris() == [shortened_uri]
    end

    test "get_shortened_uri!/1 returns the shortened_uri with given id" do
      shortened_uri = shortened_uri_fixture()
      assert Shortcuts.get_shortened_uri!(shortened_uri.id) == shortened_uri
    end

    test "create_shortened_uri/1 with valid data creates a shortened_uri" do
      valid_attrs = %{slug: "some slug", uri: "some uri"}

      assert {:ok, %ShortenedURI{} = shortened_uri} = Shortcuts.create_shortened_uri(valid_attrs)
      assert shortened_uri.slug == "some slug"
      assert shortened_uri.uri == "some uri"
    end

    test "create_shortened_uri/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortcuts.create_shortened_uri(@invalid_attrs)
    end

    test "update_shortened_uri/2 with valid data updates the shortened_uri" do
      shortened_uri = shortened_uri_fixture()
      update_attrs = %{slug: "some updated slug", uri: "some updated uri"}

      assert {:ok, %ShortenedURI{} = shortened_uri} = Shortcuts.update_shortened_uri(shortened_uri, update_attrs)
      assert shortened_uri.slug == "some updated slug"
      assert shortened_uri.uri == "some updated uri"
    end

    test "update_shortened_uri/2 with invalid data returns error changeset" do
      shortened_uri = shortened_uri_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortcuts.update_shortened_uri(shortened_uri, @invalid_attrs)
      assert shortened_uri == Shortcuts.get_shortened_uri!(shortened_uri.id)
    end

    test "delete_shortened_uri/1 deletes the shortened_uri" do
      shortened_uri = shortened_uri_fixture()
      assert {:ok, %ShortenedURI{}} = Shortcuts.delete_shortened_uri(shortened_uri)
      assert_raise Ecto.NoResultsError, fn -> Shortcuts.get_shortened_uri!(shortened_uri.id) end
    end

    test "change_shortened_uri/1 returns a shortened_uri changeset" do
      shortened_uri = shortened_uri_fixture()
      assert %Ecto.Changeset{} = Shortcuts.change_shortened_uri(shortened_uri)
    end
  end
end
