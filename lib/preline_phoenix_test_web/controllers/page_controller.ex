defmodule PrelinePhoenixTestWeb.PageController do
  use PrelinePhoenixTestWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
