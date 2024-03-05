import { Controller } from "@hotwired/stimulus"
import { Drawer } from 'flowbite';

export default class extends Controller {
  connect() {
    console.log("connecting");
    this.options = {
      placement: 'right',
      backdrop: true,
      bodyScrolling: false,
      edge: false,
      edgeOffset: '',
      backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-30',
      onHide: () => {
        console.log('drawer is hidden');
      },
      onShow: () => {
        console.log('drawer is shown');
      },
      onToggle: () => {
        console.log('drawer has been toggled');
      },
    };

    this.instanceOptions = {
      id: 'drawer-right',
      override: true
    };
    this.drawer = new Drawer(this.element, this.options, this.instanceOptions);
    this.drawer.show()
  }

  toggle() {
    this.drawer.toggle()
  }

  open() {
    this.drawer.show();
  }

  disconnect() {
    this.drawer.hide();
  }
}