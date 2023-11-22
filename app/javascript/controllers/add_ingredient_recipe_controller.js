import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-ingredient-recipe"
export default class extends Controller {
  static targets = ['list']

  connect() {
  }
  add(event) {
    event.preventDefault()
    const template = document.querySelector("template")
    const clone = template.content.cloneNode(true)
    this.listTarget.appendChild(clone)
  }
}
