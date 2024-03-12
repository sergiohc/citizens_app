import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="components--flash"
export default class extends Controller {
  connect() {
    console.log('connecting to data-controller="components--flash"');
    this.show();
    // setTimeout(() => {
    //   this.hide();
    // }, 3000);
  }

  show() {
    this.element.classList.remove("hidden");
    this.element.classList.add("flex");
  }

  hide() {
    this.element.classList.add("hidden");
    this.element.classList.remove("flex");
  }
}

