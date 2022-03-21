defmodule LynxWeb.ShortenedURIControllerTest do
  use LynxWeb.ConnCase

  import Lynx.ShortcutsFixtures

  alias Lynx.Shortcuts.ShortenedURI

  @create_attrs %{
    slug: "some slug",
    uri: "some uri"
  }
  @update_attrs %{
    slug: "some updated slug",
    uri: "some updated uri"
  }
  @invalid_attrs %{slug: nil, uri: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all uris", %{conn: conn} do
      conn = get(conn, Routes.shortened_uri_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create shortened_uri" do
    test "renders shortened_uri when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shortened_uri_path(conn, :create), shortened_uri: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.shortened_uri_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "slug" => "some slug",
               "uri" => "some uri"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shortened_uri_path(conn, :create), shortened_uri: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update shortened_uri" do
    setup [:create_shortened_uri]

    test "renders shortened_uri when data is valid", %{conn: conn, shortened_uri: %ShortenedURI{id: id} = shortened_uri} do
      conn = put(conn, Routes.shortened_uri_path(conn, :update, shortened_uri), shortened_uri: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.shortened_uri_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "slug" => "some updated slug",
               "uri" => "some updated uri"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, shortened_uri: shortened_uri} do
      conn = put(conn, Routes.shortened_uri_path(conn, :update, shortened_uri), shortened_uri: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete shortened_uri" do
    setup [:create_shortened_uri]

    test "deletes chosen shortened_uri", %{conn: conn, shortened_uri: shortened_uri} do
      conn = delete(conn, Routes.shortened_uri_path(conn, :delete, shortened_uri))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.shortened_uri_path(conn, :show, shortened_uri))
      end
    end
  end

  defp create_shortened_uri(_) do
    shortened_uri = shortened_uri_fixture()
    %{shortened_uri: shortened_uri}
  end
end
