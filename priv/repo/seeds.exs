# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Erga.Repo.insert!(%Erga.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Erga.Research.ExternalLink
alias Erga.Research.LinkedResource
alias Erga.Research.Stakeholder
alias Erga.Staff.Person
alias Erga.Research.Project

Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder
Erga.Repo.delete_all ExternalLink
Erga.Repo.delete_all LinkedResource

Erga.Repo.insert!(%Person{
  firstname: "Theodor",
  lastname: "Wiegand",
  title: "Prof. Dr."
})

Erga.Repo.insert!(%Person{
  firstname: "Hansi",
  lastname: "Flick",
  title: "Cand. phil"
})

Erga.Repo.insert! %Project{
  description: "The SPP 'Entangled Africa' demonstrates how the iDAI.world is able to aid in research and present project data in a digital and modern way.

  The project on research data management (RDM) and the coordination of the priority program “Entangled Africa” (SPP2143) also pursue these questions. In a virtual exchange with specialists from the Department of Scientific Information Technology (Scientific IT) of the German Archaeological Institute (DAI), they create new tools for the scientific discourse of all of the program’s projects on the temporal and spatial networking of the inhabitants of North Africa.

  Developed by DAI’s Scientific IT, iDAI.world offers various web services to publish and link scientific data: iDAI.chronontology collects cultural phases according to different references and puts them in relation to each other in a visually vivid way. In the iDAI.gazetteer , archaeological sites are listed with coordinates or entire regions are displayed as polygons. Both systems can be related to e.g. excavation finds and reference literature stored in iDAI.objects (formerly ARACHNE) and iDAI.bibliography (Zenon), the library catalogue of the institute. The cooperation between the SPP and the DAI aims to enable online queries to answer comprehensive questions and to present the results visually.
  Through this modern political boundaries are removed from the historical picture and the networking mechanisms in ancient time are revealed. ",
  project_code: "SPP2143",
  title: "SPP “Entangled Africa” and iDAI.world - A digital connection of time and space",
  external_links: [%ExternalLink{
    label: "google",
    url: "www.google.com"}],
  stakeholders: [
    %Stakeholder{
      role: "chef role",
      external_id: "DOI:123XABC123",
      person_id: 1
  },
    %Stakeholder{
      role: "intern",
      external_id: "PERSID:34578",
      person_id: 2
    }],
  linked_resources: [
    %LinkedResource{
      label: "Rom",
      description: "Der Ort über den geschrieben wird.",
      linked_id: "2078206",
      linked_system: "Gazetteer"
    }
  ]
}
