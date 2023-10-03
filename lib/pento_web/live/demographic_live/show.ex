defmodule PentoWeb.DemographicLive.Show do
  @moduledoc false

  use Phoenix.Component
  use Phoenix.HTML

  alias Pento.Survey.Demographic

  attr(:demographic, Demographic, required: true)

  def details(assigns) do
    ~H"""
    <div>
      <h2 class="text-2xl font-medium">Demographics <%= raw("&#x2713;") %></h2>

      <PentoWeb.CoreComponents.table id="demographic" rows={[@demographic]}>
        <:col :let={demographic} label="Gender">
          <%= demographic.gender %>
        </:col>

        <:col :let={demographic} label="Year of Birth">
          <%= demographic.year_of_birth %>
        </:col>
      </PentoWeb.CoreComponents.table>
    </div>
    """
  end
end
