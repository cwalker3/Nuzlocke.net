import { Controller } from "@hotwired/stimulus"

let isDragging = false

// Cancel any Turbo prefetch while dragging
document.addEventListener("turbo:before-prefetch", event => {
  if (isDragging) {
    event.preventDefault()
  }
})

// Connects to data-controller="party"
export default class extends Controller {

  dragStart(e) {
    isDragging = true
    const payload = JSON.stringify({ id: e.currentTarget.dataset.pokemonId })
    e.dataTransfer.clearData()
    e.dataTransfer.setData("text/plain", payload)
    e.dataTransfer.effectAllowed = "move"
  }

  async dragEnd(event) {
    await new Promise(r => setTimeout(r, 300))
    isDragging = false
  }

  allowDrop(e) {
    e.preventDefault()
    e.dataTransfer.dropEffect = "move"
  }

  drop(e) {
    e.preventDefault()
    e.stopPropagation()

    // Try the JSON channel first, then text/plain, then the legacy text
    const raw = e.dataTransfer.getData("text/plain")
    if (!raw) return console.error("No drag data available")
    let { id: fromPokemon } = JSON.parse(raw)

    const data = e.currentTarget.dataset
    const toPokemon     = data.pokemonId
    const partyPosition = data.partyPosition
    const csrfToken     = document.querySelector('meta[name="csrf-token"]').content
    const trainerPokemonId = data.trainerPokemonId

    let url, body, method

    if (trainerPokemonId !== undefined) {
      url = "/kill_events"
      body = { attempt_pokemon_id: fromPokemon, trainer_pokemon_id: trainerPokemonId }
      method = 'POST'
    } else if  (partyPosition && !toPokemon) {
      url  = "/attempt_pokemon/add_to_party"
      body = { fromPokemon, partyPosition }
      method = 'PATCH'
    } else if (!partyPosition && !toPokemon) {
      url  = `/attempt_pokemon/${fromPokemon}/remove_from_party`
      body = {}
      method = 'PATCH'
    } else {
      url  = "/attempt_pokemon/swap_pokemon"
      body = { fromPokemon, toPokemon }
      method = 'PATCH'
    }

    fetch(url, {
      method:  method,
      headers: {
        "Content-Type":   "application/json",
        "Accept":         "text/vnd.turbo-stream.html",
        "X-CSRF-Token":   csrfToken
      },
      body: JSON.stringify(body)
    })
    .then(r => r.text())
    .then(html => {
      const doc = new DOMParser().parseFromString(html, "text/html")
      doc.querySelectorAll("turbo-stream")
         .forEach(s => Turbo.renderStreamMessage(s.outerHTML))
    })
    .catch(console.error)
  }
}
