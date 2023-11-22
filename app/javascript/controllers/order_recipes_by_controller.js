import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-recipes-by"
export default class extends Controller {
  static targets = [ "cards" ]
  connect() {
  }

  orderRecipes(event) {
    let url = ""
    const selectElementValue = event.target.value;
    console.log(window.location.search);
    if (window.location.search === "") {
      url = `/recipes?rating=${selectElementValue}`
    } else {
      url = `/recipes${window.location.search}&rating=${selectElementValue}`
    }
    fetch(url)
      .then(response => response.text())
      .then((data) => {
        const parser = new DOMParser();
        const htmlDocument = parser.parseFromString(data, "text/html");
        const orderedCards = htmlDocument.body.querySelector(".cards");
        this.cardsTarget.innerHTML = orderedCards.innerHTML;
      })
  }
}
