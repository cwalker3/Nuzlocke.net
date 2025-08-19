import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {

  }
    open() {
      this.element.style.display = 'flex'
    }

    close() {
      this.element.style.display = 'none'
    }

    maybeClose(event) {
      if (this.element === event.target ) {
        this.close()
      }
    }
}
