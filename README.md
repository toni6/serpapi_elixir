# SerpElixir

A small Elixir wrapper test for the SERPAPI Google Finance API that allows you to fetch stock quotes and financial data.

## Setup with mise

This project uses [mise](https://mise.jdx.dev/) for managing Elixir and Erlang versions.

### Install mise

```bash
# On macOS
brew install mise

# On Linux
curl https://mise.jdx.dev/install.sh | sh

# Or see https://mise.jdx.dev/getting-started.html for other options
```

### Install Elixir and Erlang

The project includes a `mise.toml` file that specifies the required Elixir and Erlang versions:

```toml
[tools]
elixir = "1.18.4-otp-28"
erlang = "28.0.2"
```

Install the specified versions:

```bash
mise install
```

## Configuration

### 1. Get a SERPAPI Key

Sign up at [https://serpapi.com](https://serpapi.com) to get your API key.

### 2. Set Environment Variable

Create a `.envrc` file in your project root (if using direnv):

```bash
export SERPAPI_KEY=your_serpapi_key_here
```

Or create a `.env` file:

```bash
SERPAPI_KEY=your_serpapi_key_here
```

### 3. Load direnv (if using .envrc)

```bash
direnv allow
```

### 4. Configure the Application

The API key is automatically loaded from the `SERPAPI_KEY` environment variable via the configuration in `config/config.exs`:

```elixir
config :serp_elixir, :api_key, System.get_env("SERPAPI_KEY")
```

## Usage

### Start an Interactive Session

```bash
iex -S mix
```

### Basic Stock Quote

```elixir
# Get full quote data
iex> SerpElixir.quote("NVDA:NASDAQ")
%{
  "summary" => %{
    "currency" => "$",
    "exchange" => "NASDAQ",
    "extensions" => ["Closed: Sep 3, 4:42:12 AM GMT-4", "USD", "NASDAQ"],
    "extracted_price" => 170.78,
    "market" => %{
      "currency" => "$",
      "extracted_price" => 170.95,
      "price" => "$170.95",
      "price_movement" => %{
        "movement" => "Up",
        "percentage" => 0.1,
        "value" => 0.17
      },
      "trading" => "Pre-market"
    },
    "price" => "$170.78",
    "stock" => "NVDA",
    "title" => "NVIDIA Corp"
  }
}

# Get simple quote as map
iex> SerpElixir.simple_quote("GOOGL:NASDAQ")
%{stock: "GOOGL", price: "$176.77"}
```

## API Functions

- `SerpElixir.quote/1` - Returns full quote data with summary information
- `SerpElixir.simple_quote/1` - Returns a simple map with stock and price keys

## Testing

Run the tests with:

```bash
mix test
```
