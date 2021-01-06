defmodule ErgaWeb.LinkedResourceView do
  use ErgaWeb, :view

  @doc """
  Get description text and language code based on changeset changes (used for newly added translations)
  or based on changeset data (used for loaded translations).
  """


  def get_description_content(%{data: %{}, changes: %{text: text, language_code: language_code}} = changeset) do

    errors =
      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    Map.merge(%{text: text, language_code: language_code}, errors)
  end

  def get_description_content(%{data: data}) do
    Map.put(data, :error, [])
  end
end
