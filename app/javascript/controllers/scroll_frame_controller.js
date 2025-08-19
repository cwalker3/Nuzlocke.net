import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:frame-render", this.resetScroll)
  }

  disconnect() {
    this.element.removeEventListener("turbo:frame-render", this.resetScroll)
  }

  resetScroll = () => {
    this.element.scrollTop = 0
  }
}
