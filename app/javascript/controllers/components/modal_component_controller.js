import { Controller } from "@hotwired/stimulus"
import { Modal } from 'flowbite';

// Connects to data-controller="components--modal-component"
export default class extends Controller {
  connect() {
    console.log("connecting");
    this.options = {
      backdrop: true,
      backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30',
      closable: false,
      placement: 'center',
      onHide: () => {
        console.log('modal is hidden');
      },
      onShow: () => {
        console.log('modal is shown');
      },
      onToggle: () => {
        console.log('modal has been toggled');
      },
    };

    this.instanceOptions = {
      id: 'modal',
      override: true
    };

    this.modal = new Modal(this.element, this.options, this.instanceOptions);
    this.modal.show()
  }

  toogle() {
    this.modal.toggle()
  }

  open() {
    this.modal.show();
  }

  disconnect() {
    this.modal.hide();
  }
}
