defmodule ErgaWeb.LinkedResourceLive do
  use ErgaWeb, :live_view

  alias Erga.Research
  alias Erga.Research.LinkedResource

  def handle_params(_unsigned_params, uri, socket) do
    {:noreply, assign(socket, request_path: URI.parse(uri).path)}
  end

  defp apply_default_assigns(socket) do
    socket
    |> assign(:search_result, [])
    |> assign(:search_string, "")
    |> assign(:linked_id, nil)
    |> assign(:search_filter, "")
    |> assign(:lang_codes, Application.get_env(:gettext, :locales))
  end

  def mount(%{"project_id" => project_id}, _session, socket) do
    # new case
    changeset =
      Research.change_linked_resource(%LinkedResource{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    socket =
      socket
      |> assign(page_title: "New Linked Resource")
      |> apply_default_assigns()
      |> assign(project_id: project_id)
      |> assign(descriptions: [])
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:uri, "")
      |> assign(:name, "")

    {:ok, socket}
  end

  def mount(%{"id" => id}, _session, socket) do
    # edit case
    linked_resource = Research.get_linked_resource!(id)
    changeset = Research.change_linked_resource(linked_resource)
    socket =
      socket
      |> assign(page_title: "Edit Linked Resource")
      |> apply_default_assigns()
      |> assign(linked_resource: linked_resource)
      |> assign(project_id: linked_resource.project_id)
      |> assign(descriptions: linked_resource.descriptions)
      |> assign(changeset: changeset)
      |> assign(:linked_system, linked_resource.linked_system)
      |> assign(:labels, linked_resource.labels)
      |> assign(:uri, linked_resource.uri)

    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "form.html", assigns)

  def handle_event("form_change", %{"_target" => ["linked_resource", target]} = params, socket) do
    {:noreply, form_change(target, params, socket)}
  end

  def handle_event("form_change", %{"_target" => [target]} = params, socket) do
    {:noreply, form_change(target, params, socket)}
  end

  def handle_event("form_change", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("choose_resource", params, socket) do
    {:noreply, choose_resource(params, socket)}
  end

  # new case
  def handle_event(
    "save",
    %{"linked_resource" => linked_resource_params},
    %{assigns: %{live_action: :new}} = socket
    ) do
    case Research.create_linked_resource(linked_resource_params) do
      {:ok, linked_resource} ->
        create_label_translation(linked_resource, socket)

      {:error, changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # edit case
  def handle_event(
    "save",
    %{"linked_resource" => linked_resource_params},
    %{assigns: %{live_action: :edit}} = socket
    ) do
    case Research.update_linked_resource(socket.assigns.linked_resource, linked_resource_params) do
      {:ok, linked_resource} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Linked resource updated successfully.")
          |> redirect(to: Routes.project_path(ErgaWeb.Endpoint, :edit, linked_resource.project_id))
        }
      {:error, changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp create_label_translation(linked_resource, %{assigns: %{name: text}} = socket) do

    label_params =
      %{
        "target_table" => linked_resource.__meta__.source,
        "target_table_primary_key" => linked_resource.id,
        "target_id" => linked_resource.label_translation_target_id,
        "target_field" => "label_translation_target_id",
        "text" => text,
        "language_code" => Gettext.get_locale()
      }

    case Erga.Research.create_translated_content(label_params) do
      {:ok, _translated_content} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Linked resource created successfully. You may add descriptions.")
          |> redirect(to: Routes.linked_resource_path(ErgaWeb.Endpoint, :edit, linked_resource.id))
        }
      {:error, _translated_content_changeset } ->
        {
          :noreply,
          socket
          |> put_flash(:error, "Failed to set initial label for selected linked resource, please check below.")
          |> redirect(to: Routes.linked_resource_path(ErgaWeb.Endpoint, :edit, linked_resource.id))
        }
    end
  end

  def form_change(target, %{"linked_resource" => params}, socket) do
    case target do
      "linked_system" ->
        update(socket, :uri, fn _ -> "" end)
        |> update(:search_result, fn _ -> [] end)
        |> update(:linked_system, fn _ -> params["linked_system"] end)
      "search_string" ->
        search(socket, params["search_string"])
      target ->
        update(socket, String.to_existing_atom(target), fn _ -> params[target] end)
    end
  end

  def choose_resource( %{"id" => id, "name" => name, "uri" => uri}, socket) do
    socket
      |> update(:name, fn _ -> name end)
      |> update(:linked_id, fn _ -> id end)
      |> update(:uri, fn _ -> uri end)
      |> update(:search_string, fn _ -> "" end)
      |> update(:search_result, fn _ -> [] end)
  end

  defp search(socket, search_string) do
    service = ErgaWeb.Services.get_system_service(socket.assigns.linked_system)
    filter = socket.assigns.search_filter
    # just for testing set the filter permanently to hierarchy
    filter = if socket.assigns.linked_system == "thesaurus", do: %{use_hierarchy: true}, else: filter
    # permit users to use wildcard on thier own
    search_string = String.replace_trailing(search_string, "*", "")

    # perform a search or return empty list
    if String.length(search_string) > 1 do
      case service.get_list(search_string, filter) do
        {:ok, list} -> update(socket, :search_result, fn _old_search_string -> list end)
        {:error, reason} -> assign(socket, :search_error, reason)
      end
    else
      update(socket, :search_result, fn _l -> [] end)
    end
  end

end
