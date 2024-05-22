import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["resizable", "handle"]

  connect() {
    this.boundResize = this.resize.bind(this);
    this.boundStopResize = this.stopResize.bind(this);
    
    this.handleTarget.addEventListener('mousedown', (e) => {
      e.preventDefault();

      document.addEventListener('mousemove', this.boundResize);
      document.addEventListener('mouseup', this.boundStopResize);
    });
  }

  resize(e) {
    this.resizableTarget.style.width = (e.clientX - this.resizableTarget.offsetLeft) + 'px';
  }

  stopResize() {
    document.removeEventListener('mousemove', this.boundResize);
    document.removeEventListener('mouseup', this.boundStopResize);
  }

}
