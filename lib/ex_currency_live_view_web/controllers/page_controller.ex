defmodule ExCurrencyLiveViewWeb.PageController do
  use ExCurrencyLiveViewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
