defmodule ServiceHelpers do

  def get_system_service(system_name) do
    case String.downcase(system_name) do
      "gazetteer" -> GazetteerService
      "chrontology" -> ChrontologyService
      _ -> raise "no matching service"
    end
end

end
