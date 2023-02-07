defmodule ApiWeb.Plugs.HealthCheck do
  @moduledoc """
  Plug to handle API health check.
  """
  import Plug.Conn

  alias Api.Repo
  alias Ecto.Adapters.SQL

  def init(options), do: options

  def call(%Plug.Conn{request_path: "/health-check"} = conn, _opts) do
    case SQL.query(Repo, "SELECT 1") do
      {:ok, _} ->
        conn
        |> send_resp(200, "")
        |> halt()

      _ ->
        conn
        |> send_resp(503, "service unavaliable")
        |> halt()
    end
  end

  def call(conn, _opts), do: conn
end
