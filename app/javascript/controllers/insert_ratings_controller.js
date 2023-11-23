import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-ratings"
export default class extends Controller {
  static targets = ["items", "form"]

  connect() {
  }

  send(event) {
    event.preventDefault()
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
          this.itemsTarget.scrollIntoView({ behavior: "smooth", block: "end", inline: "nearest" });
        }
        this.formTarget.outerHTML = data.form
      })
  }
}
