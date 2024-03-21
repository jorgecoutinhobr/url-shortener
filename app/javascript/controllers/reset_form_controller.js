import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 connect() {
    console.log("Reset Form Controller Connected");
 }

 reset() {
    this.element.reset();
    this.element.querySelector("[autofocus='autofocus']")?.focus();
 }
}
