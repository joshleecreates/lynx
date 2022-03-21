defmodule LynxWeb.PageController do
  use LynxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
