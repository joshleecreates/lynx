defmodule Lynx.Shortcuts do
  @moduledoc """
  The Shortcuts context.
  """

  import Ecto.Query, warn: false
  alias Lynx.Repo

  alias Lynx.Shortcuts.ShortenedURI

  @doc """
  Returns the list of uris.

  ## Examples

      iex> list_uris()
      [%ShortenedURI{}, ...]

  """
  def list_uris do
    Repo.all(ShortenedURI)
  end

  @doc """
  Gets a single shortened_uri.

  Raises `Ecto.NoResultsError` if the Shortened uri does not exist.

  ## Examples

      iex> get_shortened_uri!(123)
      %ShortenedURI{}

      iex> get_shortened_uri!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shortened_uri!(id), do: Repo.get!(ShortenedURI, id)

  @doc """
  Creates a shortened_uri.

  ## Examples

      iex> create_shortened_uri(%{field: value})
      {:ok, %ShortenedURI{}}

      iex> create_shortened_uri(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shortened_uri(attrs \\ %{}) do
    %ShortenedURI{}
    |> ShortenedURI.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shortened_uri.

  ## Examples

      iex> update_shortened_uri(shortened_uri, %{field: new_value})
      {:ok, %ShortenedURI{}}

      iex> update_shortened_uri(shortened_uri, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shortened_uri(%ShortenedURI{} = shortened_uri, attrs) do
    shortened_uri
    |> ShortenedURI.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shortened_uri.

  ## Examples

      iex> delete_shortened_uri(shortened_uri)
      {:ok, %ShortenedURI{}}

      iex> delete_shortened_uri(shortened_uri)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shortened_uri(%ShortenedURI{} = shortened_uri) do
    Repo.delete(shortened_uri)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shortened_uri changes.

  ## Examples

      iex> change_shortened_uri(shortened_uri)
      %Ecto.Changeset{data: %ShortenedURI{}}

  """
  def change_shortened_uri(%ShortenedURI{} = shortened_uri, attrs \\ %{}) do
    ShortenedURI.changeset(shortened_uri, attrs)
  end
end
