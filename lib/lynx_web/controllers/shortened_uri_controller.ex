defmodule LynxWeb.ShortenedURIController do
  use LynxWeb, :controller

  alias Lynx.Shortcuts
  alias Lynx.Shortcuts.ShortenedURI

  action_fallback LynxWeb.FallbackController

  def create(conn, %{"shortened_uri" => shortened_uri_params}) do
    with {:ok, %ShortenedURI{} = shortened_uri} <- Shortcuts.create_shortened_uri(shortened_uri_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shortened_uri_path(conn, :show, shortened_uri))
      |> render("show.json", shortened_uri: shortened_uri)
    end
  end

  def show(conn, %{"id" => slug}) do
    shortened_uri = Shortcuts.get_shortened_uri!(slug)
    render(conn, "show.json", shortened_uri: shortened_uri)
  end

  def go(conn, %{"slug" => slug}) do
    shortened_uri = Shortcuts.get_shortened_uri!(slug)
    redirect(conn, external: shortened_uri.uri)
  end
end
