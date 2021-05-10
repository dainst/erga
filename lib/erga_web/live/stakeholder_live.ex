defmodule ErgaWeb.StakeholderLive do
  use ErgaWeb, :live_view

  alias Erga.Staff
  alias Erga.Staff.Stakeholder

  def handle_params(_unsigned_params, uri, socket) do
    {:noreply, assign(socket, redirect: _unsigned_params["redirect"])}
  end

  def mount(%{"id"=> id}, _session, socket) do
    # edit case
    stakeholder =
      Staff.get_stakeholder!(id)
    changeset = Staff.change_stakeholder(stakeholder)
    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:stakeholder, stakeholder)
      |> assign(:type, Map.get(stakeholder,:type))

    {:ok, socket}
  end

  def mount(_,_session, socket) do
    # new case
    stakeholder = %Stakeholder{type: "person"}
    changeset =
      Staff.change_stakeholder(stakeholder)

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:type, Map.get(stakeholder,:type))
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.StakeholderView, "form.html", assigns)

  def handle_event("form_change", %{"_target" => ["stakeholder", target]} = params, socket) do
    socket = socket
             |>update(:type, fn _ -> params["stakeholder"]["type"] end)
    {:noreply, socket}
  end
  def handle_event("form_change", _ , socket) do
    {:noreply, socket}
  end


  # new case
  def handle_event(
    "save",
    %{"stakeholder" => stakeholder_params},
    %{assigns: %{live_action: :new}} = socket
    ) do
    case Staff.create_stakeholder(stakeholder_params) do
      {:ok, changeset} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Stakeholder Saved successfully.")
          |> redirect(to: socket.assigns.redirect)
        }
      {:error, changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # edit case
  def handle_event(
    "save",
    %{"stakeholder" => stakeholder_params},
    %{assigns: %{live_action: :edit}} = socket
    ) do
    case Staff.update_stakeholder(socket.assigns.stakeholder, stakeholder_params) do
      {:ok, changeset} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Stakeholder updated successfully.")
          |> redirect(to: socket.assigns.redirect)
        }
      {:error, changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end


end
