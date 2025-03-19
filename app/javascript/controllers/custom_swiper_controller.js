import { Controller } from "@hotwired/stimulus"
import Hammer from "hammerjs";
// Connects to data-controller="custom-swiper"
export default class extends Controller {
  static targets = [ "flipper" ]

  connect() {

    const csrf_token = document.querySelector('meta[name="csrf-token"]').content

    const dislike = (user_data) => {
      const url = "/user_dislikes/"
      console.log("j'ai pô liké");
      fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrf_token,
        },
        body: JSON.stringify(user_data)
      })
    }

    const like = (user_data) => {
      const url = "/user_likes/"
      console.log("j'ai liké")
      fetch(url, {
        method: "POST",
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrf_token,
        },
        body: JSON.stringify(user_data)
      })
      console.log(user_data)
    }

    var tinderContainer = document.querySelector('.tinder');
    var allCards = document.querySelectorAll('.tinder--card');
    const cards = this.flipperTargets
    var nope = document.getElementById('nope');
    var love = document.getElementById('love');

    function initCards(card) {
      var newCards = document.querySelectorAll('.tinder--card:not(.removed)');

      newCards.forEach(function (card, index) {
        card.style.zIndex = allCards.length - index;
        card.style.transform = 'scale(' + (20 - index) / 20 + ') translateY(-' + 30 * index + 'px)';
        card.style.opacity = (10 - index) / 10;
      });

      tinderContainer.classList.add('loaded');
    }

    initCards();

    cards.forEach(function (el) {
      var hammertime = new Hammer(el);

      hammertime.on('pan', function (event) {
        el.classList.add('moving');
      });

      hammertime.on('pan', function (event) {
        if (event.deltaX === 0) return;
        if (event.center.x === 0 && event.center.y === 0) return;

        tinderContainer.classList.toggle('tinder_love', event.deltaX > 0);
        tinderContainer.classList.toggle('tinder_nope', event.deltaX < 0);

        var xMulti = event.deltaX * 0.03;
        var yMulti = event.deltaY / 80;
        var rotate = xMulti * yMulti;

        event.target.style.transform = 'translate(' + event.deltaX + 'px, ' + event.deltaY + 'px) rotate(' + rotate + 'deg)';
      });

      hammertime.on('panend', function (event) {
        el.classList.remove('moving');
        tinderContainer.classList.remove('tinder_love');
        tinderContainer.classList.remove('tinder_nope');

        var moveOutWidth = document.body.clientWidth;
        var keep = Math.abs(event.deltaX) < 80 || Math.abs(event.velocityX) < 0.5;

        event.target.classList.toggle('removed', !keep);

        if (keep) {
          event.target.style.transform = '';
        } else {
          var endX = Math.max(Math.abs(event.velocityX) * moveOutWidth, moveOutWidth);
          var toX = event.deltaX > 0 ? endX : -endX;
          var endY = Math.abs(event.velocityY) * moveOutWidth;
          var toY = event.deltaY > 0 ? endY : -endY;
          var xMulti = event.deltaX * 0.03;
          var yMulti = event.deltaY / 80;
          var rotate = xMulti * yMulti;

          event.target.style.transform = 'translate(' + toX + 'px, ' + (toY + event.deltaY) + 'px) rotate(' + rotate + 'deg)';

          // Appeler like ou dislike en fonction de la direction finale
          const user_data = {
            user_id: el.dataset.userId,
            vinyl_id: el.dataset.vinylId
          };
          if (event.deltaX > 80) {
            like(user_data);
          } else if (event.deltaX < -80) {
            dislike(user_data);
          }

          initCards();

          // hammertime.on("panleft", function(e) {
          //   const user_data = {
          //     user_id: el.dataset.userId,
          //     vinyl_id: el.dataset.vinylId
          //   }
          //   dislike(user_data);
          // })

          // hammertime.on("panright", function(e) {
          //   const user_data = {
          //     user_id: el.dataset.userId,
          //     vinyl_id: el.dataset.vinylId
          //   }
          //   like(user_data);
          // })
        }
      });

    });

    function createButtonListener(love) {
      return function (event) {
        var cards = document.querySelectorAll('.tinder--card:not(.removed)');
        var moveOutWidth = document.body.clientWidth * 1.5;

        if (!cards.length) return false;

        var card = cards[0];

        card.classList.add('removed');

        if (love) {
          card.style.transform = 'translate(' + moveOutWidth + 'px, -100px) rotate(-30deg)';
          const user_data = {
            user_id: card.dataset.userId,
            vinyl_id: card.dataset.vinylId
          };
          like(user_data);
        } else {
          card.style.transform = 'translate(-' + moveOutWidth + 'px, -100px) rotate(30deg)';
          const user_data = {
            user_id: card.dataset.userId,
            vinyl_id: card.dataset.vinylId
          };
          dislike(user_data);
        }

        initCards();

        event.preventDefault();
      };
    }

    var nopeListener = createButtonListener(false);
    var loveListener = createButtonListener(true);

    nope.addEventListener('click', nopeListener);
    love.addEventListener('click', loveListener);

  }


  // flip() {
  //   this.flipperTarget.classList.toggle("flip");
  // }

}
