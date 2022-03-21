defmodule LynxWeb.ShortenedURIView do
  use LynxWeb, :view
  alias LynxWeb.ShortenedURIView

  def render("index.json", %{uris: uris}) do
    %{data: render_many(uris, ShortenedURIView, "shortened_uri.json")}
  end

  def render("show.json", %{shortened_uri: shortened_uri}) do
    %{data: render_one(shortened_uri, ShortenedURIView, "shortened_uri.json")}
  end

  def render("shortened_uri.json", %{shortened_uri: shortened_uri}) do
    %{
      id: shortened_uri.id,
      uri: shortened_uri.uri,
      slug: shortened_uri.slug
    }
  end
end
