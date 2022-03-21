defmodule Lynx.Repo.Migrations.CreateUris do
  use Ecto.Migration

  def change do
    create table(:uris) do
      add :uri, :string
      add :slug, :string

      timestamps()
    end
  end
end
