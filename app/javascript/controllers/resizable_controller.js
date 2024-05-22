import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["resizable", "handle"]

  connect() {
    this.boundResize = this.resize.bind(this);
    this.boundStopResize = this.stopResize.bind(this);

    const savedWidth = this.getCookie('resizableWidth');
    if (savedWidth) {
      this.resizableTarget.style.width = savedWidth;
    }

    this.handleTarget.addEventListener('mousedown', (e) => {
      e.preventDefault();

      document.addEventListener('mousemove', this.boundResize);
      document.addEventListener('mouseup', this.boundStopResize);
    });
  }

  resize(e) {
    const newWidth = (e.clientX - this.resizableTarget.offsetLeft) + 'px';
    this.resizableTarget.style.width = newWidth;
    this.setCookie('resizableWidth', newWidth);
  }

  stopResize() {
    document.removeEventListener('mousemove', this.boundResize);
    document.removeEventListener('mouseup', this.boundStopResize);
  }

  setCookie(name, value) {
    const date = new Date();
    date.setFullYear(date.getFullYear() + 10); // Set the date 10 years in the future
    const expires = "; expires=" + date.toUTCString();
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
  }

  getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
      let c = ca[i];
      while (c.charAt(0) == ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }
}
