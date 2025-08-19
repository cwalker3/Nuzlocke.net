import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select"
export default class extends Controller {
  connect() {

  }
  update_selected(e){
    const target = e.target
    const list_item = target.parentElement
    const list = list_item.parentElement
    list.querySelectorAll('.selected').forEach ( selected => {
      selected.classList.remove('selected')
    })

    target.classList.add('selected')
  }

}
