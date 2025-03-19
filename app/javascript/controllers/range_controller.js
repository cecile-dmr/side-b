import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  connect() {
  }

  update() {
    const csrf_token = document.querySelector('meta[name="csrf-token"]').content
    const inputValue = this.element.querySelector('input').value;
    const user_id = this.element.querySelector('input').dataset.userId
    const url = `/update_radius`
    const container_cards = document.querySelector(".tinder--cards")
    const custom_swiper = this.application.getControllerForElementAndIdentifier(  document.querySelector('[data-controller="custom-swiper"]'),  'custom-swiper'  )
    const user_data = {
      "user_id": user_id,
      "radius": inputValue
    }

    fetch(url, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrf_token,
      },
      body: JSON.stringify(user_data)
    }).then(response => response.json())
      .then(data => {
        container_cards.innerHTML = `${data.cards}`
        custom_swiper.connect()
      })
  }

  count() {
    const inputValue = this.element.querySelector('input').value;
    const countElement = this.element.querySelector('[data-range-target="count"]');

    if (countElement) {
      countElement.textContent = inputValue;
    }
  }
}
