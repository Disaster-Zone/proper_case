defmodule ProperCase.Plug.SnakeCaseParams do
  @moduledoc """
   A helpful plug that converts your incoming parameters to
   Elixir's `snake_case`

   Plug it into your `router.ex` connection pipeline like so:

    pipeline :api do
      plug :accepts, ["json"]
      plug ProperCase.Plug.SnakeCaseParams
    end

  Enjoy :)
   """

  def init(opts), do: opts

  def call(%{params: %{"file" => upload, "params" => params}} = conn, _opts) do
    params = Poison.decode!(params, [])
              |> ProperCase.to_snake_case()
              |> Poison.encode!([])
    %{conn | params: %{"file" => upload, "params" => params}}
  end

  def call(%{params: params} = conn, _opts) do
    %{conn | params: ProperCase.to_snake_case(params)}
  end
end
