import { Controller } from '@hotwired/stimulus';
import Swiper from 'swiper';
// import { Navigation, Pagination } from 'swiper/modules';
// import Swiper and modules styles
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';


export default class extends Controller {
  connect() {
    console.log("oui")
    this.swiper = new Swiper('.swiper-container', {
      // modules: [Navigation, Pagination],
      // Swiper configuration options
      pagination: {
        el: ".swiper-pagination",
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
  }
}
