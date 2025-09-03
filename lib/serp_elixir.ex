defmodule SerpElixir do
  @moduledoc """
  Documentation for `SerpElixir`.
  """

  @doc """
  Fetches a complete stock quote from SERPAPI Google Finance.

  ## Parameters
  - `ticker` - Stock ticker symbol (e.g., "NVDA:NASDAQ", "KGC:NYSE")

  ## Returns
  A map containing the full summary data including price, market info, and extensions.

  ## Examples
      SerpElixir.quote("NVDA:NASDAQ")
      #=> %{"summary" => %{"stock" => "NVDA", "price" => "$170.78"}}
  """
  def quote(ticker) do
    api_key = Application.get_env(:serp_elixir, :api_key)

    {result, _globals} =
      Pythonx.eval(
        """
        import serpapi

        client = serpapi.Client(api_key=api_key)
        result = client.search(
          engine="google_finance",
          q=ticker,
          json_restrictor="summary"
        )

        result = dict(result)
        result
        """,
        %{"api_key" => api_key, "ticker" => ticker}
      )

    Pythonx.decode(result)
  end

  @doc """
  Fetches a simplified stock quote with just the stock symbol and price.

  ## Parameters
  - `ticker` - Stock ticker symbol (e.g., "DIS:NYSE", "AAPL:NASDAQ")

  ## Returns
  A simple map with `:stock` and `:price` keys.

  ## Examples
      iex> SerpElixir.simple_quote("DIS:NYSE")
      %{stock: "DIS", price: "$118.27"}
  """
  def simple_quote(ticker) do
    %{"summary" => %{"stock" => stock, "price" => price}} = SerpElixir.quote(ticker)
    %{stock: stock, price: price}
  end
end
