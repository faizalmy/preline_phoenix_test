defmodule PrelinePhoenixTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PrelinePhoenixTestWeb.Telemetry,
      PrelinePhoenixTest.Repo,
      {DNSCluster, query: Application.get_env(:preline_phoenix_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PrelinePhoenixTest.PubSub},
      # Start a worker by calling: PrelinePhoenixTest.Worker.start_link(arg)
      # {PrelinePhoenixTest.Worker, arg},
      # Start to serve requests, typically the last entry
      PrelinePhoenixTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PrelinePhoenixTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PrelinePhoenixTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
