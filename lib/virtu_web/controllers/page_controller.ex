defmodule VirtuWeb.PageController do
  use VirtuWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
