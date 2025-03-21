import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="splash-screen"
export default class extends Controller {
  static targets = ["loading"]
  connect() {
    let element = this.loadingTarget.innerText
    const animation = (secondes) => {
      const loop = setInterval(() => {

        const addPoints = setInterval(() => {
          this.loadingTarget.innerText += "."
        }, 280);

        setTimeout(() => {
          clearInterval(addPoints)
          this.loadingTarget.innerText = element
        }, 1000);

      }, 1000);

      setTimeout(() => {
        clearInterval(loop)
        this.element.classList.add("splash-screen-hidden")
        setTimeout(() => {
          this.element.remove()
        }, 1500);
      }, secondes * 1000);
    }
    animation(2.5)
  }
}
