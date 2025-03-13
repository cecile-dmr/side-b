# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "swiper" # @2.1.0
pin "swiper/modules", to: "swiper--modules.js" # @2.1.0
pin "swiper/css", to: "swiper--css.js" # @2.1.0
pin "swiper/css/navigation", to: "swiper--css--navigation.js" # @2.1.0
pin "swiper/css/pagination", to: "swiper--css--pagination.js" # @2.1.0
