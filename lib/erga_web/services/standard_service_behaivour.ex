defmodule StandardServiceBehaivour do
  @callback get_result_list(term) :: [term]

  defmacro __using__(_) do
    quote do
      @behaviour StandardServiceBehaivour

      def get_list_request(url) do
        HTTPoison.start
        case HTTPoison.get(url) do
          {:ok, response} -> list = response.body
                            |> Poison.decode!
                            |> Map.get("results")
                            |> get_result_list
                            {:ok, list}
          {:error, reason} -> {:error, "Error during search: " <> Atom.to_string(reason.reason)}
        end
      end

    end
  end
end
