defmodule ArachneService do
  use StandardServiceBehaivour

  @base_url "https://arachne.dainst.org/data/search"


  def get_list(val) do
    HTTPoison.start
    case HTTPoison.get(@base_url <> "?q=" <> val <> "*" ) do
      {:ok, response} -> list = response.body
                        |> Poison.decode!
                        |> Map.get("results")
                        |> get_result_list
                        {:ok, list}
      {:error, reason} -> {:error, "Error during search: " <> Atom.to_string(reason.reason)}
    end
  end

  def get_by_id(id) do
    HTTPoison.start
    res =
      HTTPoison.get!(@base_url <> id).body
      |> Poison.decode!
    IO.puts(inspect(res))

    get_result_list([res])
    |> List.first
  end

  def get_result_list(res) do
    if is_list(res) do
      for  n <- res do
        names = if n["resource"]["names"]["de"], do: Enum.join( n["resource"]["names"]["de"], ", "), else: ""
        %{name: names, resId: n["resource"]["id"]}
      end
    else
      []
    end

  end


end
