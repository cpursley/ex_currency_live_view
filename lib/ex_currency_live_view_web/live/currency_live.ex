defmodule ExCurrencyLiveViewWeb.CurrencyLive do
  use Phoenix.LiveView

   # TODO:
   # - Write helper for watching diffs (so that we can track increase or decrease!)
   # - CSS / styles
   def render(assigns) do
     ~L"""
     <div>
       <h1>Exchange rates:</h1>
       <%= for currency <- @currencies do %>
         <h2>1 <%= currency.from %> to <%= currency.to %> = <%= currency.rate %></h2>
       <% end %>
     </div>
     """
   end

   # Initial state
   def mount(_session, socket) do
     if connected?(socket), do: :timer.send_interval(1000, self(), :update_rates)

     {:ok, put_currency(socket)}
   end

   def handle_params(params, _uri, socket), do: {:noreply, assign(socket, :params, params)}

   def handle_info(:update_rates, socket), do: {:noreply, put_currency(socket)}

   # TODO:
   # Instead of a "default" usd to eur, render empty view
   # Split into two put_currency functions (to pattern match if params present)
   defp put_currency(%{assigns: assigns} = socket) do
     if Map.has_key?(assigns, :params) do
       params = assigns.params
       from = if Map.has_key?(params, "from"), do: params["from"],                    else: "usd"
       to =   if Map.has_key?(params, "to"),   do: params["to"] |> String.split(","), else: ["eur"]

       assign(socket, currencies: fetch_rates(from, to))
     else
       assign(socket, currencies: fetch_rates("usd", ["eur"]))
     end
   end

   defp fetch_rates(from, to) do
     # Kick off worker
     Enum.map(to, fn (t) -> ExCurrencyLive.exchange_rates_worker(from, t) end)

     # Fetch rates from cache
     Enum.map(to, fn (t) -> ExCurrencyLive.exchange_rates_fetcher(from, t) end)
   end
end
