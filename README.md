# Lynx

## System Requirements

This code was tested with the following dependencies. Older or newer versions may work but are not guaranteed.

 - Erlang/OTP 24
 - Elixir 1.13.3
 - Node.js v12.22.7


## Database

This application assumes that you have a postgres database running and available on the default port, matching the connection info in `config/dev.exs`:

```
config :lynx, Lynx.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "lynx_dev",
```

You can use the included docker-compose file to start a postgres server:

```
docker-compose up -d &
```

When finished working, you can stop the docker container and free up your ports with:

```
docker-compose stop
```

## NPM

Ensure your node_modules are installed: `cd assets && npm install`

## Start

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.

## Tests

You can run tests with `MIX_ENV=test mix test`
