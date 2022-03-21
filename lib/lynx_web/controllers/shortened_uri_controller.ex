defmodule LynxWeb.ShortenedURIController do
  use LynxWeb, :controller

  alias Lynx.Shortcuts
  alias Lynx.Shortcuts.ShortenedURI

  action_fallback LynxWeb.FallbackController

  def index(conn, _params) do
    uris = Shortcuts.list_uris()
    render(conn, "index.json", uris: uris)
  end

  def create(conn, %{"shortened_uri" => shortened_uri_params}) do
    with {:ok, %ShortenedURI{} = shortened_uri} <- Shortcuts.create_shortened_uri(shortened_uri_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shortened_uri_path(conn, :show, shortened_uri))
      |> render("show.json", shortened_uri: shortened_uri)
    end
  end

  def show(conn, %{"id" => id}) do
    shortened_uri = Shortcuts.get_shortened_uri!(id)
    render(conn, "show.json", shortened_uri: shortened_uri)
  end

  def update(conn, %{"id" => id, "shortened_uri" => shortened_uri_params}) do
    shortened_uri = Shortcuts.get_shortened_uri!(id)

    with {:ok, %ShortenedURI{} = shortened_uri} <- Shortcuts.update_shortened_uri(shortened_uri, shortened_uri_params) do
      render(conn, "show.json", shortened_uri: shortened_uri)
    end
  end

  def delete(conn, %{"id" => id}) do
    shortened_uri = Shortcuts.get_shortened_uri!(id)

    with {:ok, %ShortenedURI{}} <- Shortcuts.delete_shortened_uri(shortened_uri) do
      send_resp(conn, :no_content, "")
    end
  end
end
