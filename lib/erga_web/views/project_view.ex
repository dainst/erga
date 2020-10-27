defmodule ErgaWeb.ProjectView do
  use ErgaWeb, :view

def get_title(project, lang) do
  Enum.find(project.title, List.first(project.title), fn map -> map.language_code == lang end)
end

def get_description(project, lang) do
  Enum.find(project.description, List.first(project.description),fn map -> map.language_code == lang end)
end

end
