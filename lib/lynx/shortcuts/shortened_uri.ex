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
    |> validate_format(:uri, ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/ )
    |> unique_constraint(:slug)
  end
end
