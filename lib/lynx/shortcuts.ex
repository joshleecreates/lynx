defmodule Lynx.Shortcuts do
  @moduledoc """
  The Shortcuts context.
  """

  import Ecto.Query, warn: false
  alias Lynx.Repo

  alias Lynx.Shortcuts.ShortenedURI

  alias Lynx.Utils

  @doc """
  Gets a single shortened_uri.

  Raises `Ecto.NoResultsError` if the Shortened uri does not exist.

  ## Examples

      iex> get_shortened_uri!(123)
      %ShortenedURI{}

      iex> get_shortened_uri!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shortened_uri!(slug), do: Repo.get_by!(ShortenedURI, slug: slug)

  @doc """
  Creates a shortened_uri.

  ## Examples

      iex> create_shortened_uri(%{field: value})
      {:ok, %ShortenedURI{}}

      iex> create_shortened_uri(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shortened_uri(attrs \\ %{}) do
    attrs = for {k, v} <- attrs,
               do: {to_string(k), v}, into: %{}
    attrs = Map.put(attrs, "slug", String.downcase(Utils.random_string(6)))

    %ShortenedURI{}
    |> ShortenedURI.changeset(attrs)
    |> Repo.insert()
    |> maybe_retry_uri_insertion(attrs)
  end

  defp maybe_retry_uri_insertion({:ok, uri}, _), do: {:ok, uri}

  # retry on slug collision
  defp maybe_retry_uri_insertion({:error, %{errors: %{slug: _}}}, attrs) do
    create_shortened_uri(attrs)
  end

  defp maybe_retry_uri_insertion(error, _), do: error
end
