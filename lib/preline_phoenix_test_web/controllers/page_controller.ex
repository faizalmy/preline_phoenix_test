defmodule PrelinePhoenixTestWeb.PageController do
  use PrelinePhoenixTestWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def preline_test(conn, _params) do
    render(conn, :preline_test)
  end
end