import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  connect() {
    // const user_data = {
    //   "search_radius": null,
    // // }
    // const update = (user_data) => {
    //   const url = "/update_radius"
    //   console.log("j'ai update");
    //   fetch(url, {
    //     method: 'PATCH',
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'X-CSRF-Token': csrf_token,
    //     },
    //     body: JSON.stringify(user_data)
    //   })
    // }
  }

  update() {
    console.log("HEY")
    const csrf_token = document.querySelector('meta[name="csrf-token"]').content
    const inputValue = this.element.querySelector('input').value;
    const user_id = this.element.querySelector('input').dataset.userId
    const url = `/update_radius`
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
        console.log(data)
      })
  }

  // si changement et si update ok
  // je retire du dom les cards
  // je regenere les vinyles dans pages_controller#swipe
  // je remets dans le dom les cards
}
