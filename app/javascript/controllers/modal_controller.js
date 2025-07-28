import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  show() {
    const dialog = document.querySelector('dialog[open]') || document.querySelector('dialog');
    dialog?.showModal();
  }

  close() {
    const dialog = document.getElementById('close_modal');
    dialog?.close();

    const frame = document.getElementById('modal');
    if (frame) {
      frame.innerHTML = "<div style='display: none;'></div>";
    }
  }
}
