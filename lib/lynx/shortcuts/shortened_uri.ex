defmodule Lynx.Shortcuts.ShortenedURI do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uris" do
    field :slug, :string
    field :uri, :string

    timestamps()
  end

  @doc false
  def changeset(shortened_uri, attrs) do
    shortened_uri
    |> cast(attrs, [:uri, :slug])
    |> validate_required([:uri, :slug])
  end
end
