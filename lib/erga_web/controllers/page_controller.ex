defmodule ErgaWeb.PageController do
  use ErgaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
