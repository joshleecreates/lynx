defmodule LynxWeb.ShortenedURIControllerTest do
  use LynxWeb.ConnCase

  @create_attrs %{
    uri: "https://www.stord.com"
  }
  @invalid_attrs %{uri: "www.stord.com"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create shortened_uri" do
    test "renders shortened_uri when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shortened_uri_path(conn, :create), shortened_uri: @create_attrs)
      assert %{"slug" => slug, "id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.shortened_uri_path(conn, :show, slug))

      assert %{
               "id" => ^id,
               "slug" => ^slug,
               "uri" => "https://www.stord.com"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shortened_uri_path(conn, :create), shortened_uri: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "redirects to correct url when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shortened_uri_path(conn, :create), shortened_uri: @create_attrs)
      assert %{"uri" => uri, "slug" => slug, "id" => id} = json_response(conn, 201)["data"]
      conn = get(build_conn(), "/" <> slug)
      assert uri = redirected_to(conn)
    end
  end
end
