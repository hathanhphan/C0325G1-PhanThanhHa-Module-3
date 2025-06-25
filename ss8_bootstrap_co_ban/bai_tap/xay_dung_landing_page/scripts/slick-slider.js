$(document).ready(function(){
    $('.surface-slider .slider').slick({
        slidesToShow: 2.2,
        slidesToScroll: 1,
        centerPadding: '0px',
        infinite: false,
        speed: 500,
        dots: true,
        arrows: true,
        appendDots: $('.mod-slider > .surface-navigation > .progress-bar'),
        appendArrows: $('.mod-slider > .surface-navigation > .arrows'),
        prevArrow: '<button class="slick-prev"><i class="bi bi-chevron-left"></i></button>',
        nextArrow: '<button class="slick-next"><i class="bi bi-chevron-right"></i></button>',
        customPaging: function(slider, i) {
            return '<button class="dot-segment"></button>';
        },
        responsive: [
            {
                breakpoint: 560,
                settings: {
                    slidesToShow: 1.2,
                    centerPadding: '0px',
                    appendDots: $('.surface-slider > .progress-bar'),
                    appendArrows: $('.surface-slider > .arrows'),
                }
            },
            {
                breakpoint: 769,
                settings: {
                    slidesToShow: 2.2,
                    centerPadding: '0px',
                    appendDots: $('.surface-slider > .progress-bar'),
                    appendArrows: $('.surface-slider > .arrows'),
                }
            },
            {
                breakpoint: 1084,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    centerPadding: '0px',
                    appendDots: $('.surface-slider > .progress-bar'),
                    appendArrows: $('.surface-slider > .arrows'),
                }

            }
        ]
    });
    $('.mod-cards-slider .cards-slider-inner').slick({
        infinite: true,
        speed: 500,
        dots: true,
        arrows: true,
        appendDots: $('.cards-slider .slider-dots'),
        appendArrows: $('.cards-slider .slider-navigation'),
        prevArrow: '<button class="slick-prev"><i class="bi bi-chevron-left"></i></button>',
        nextArrow: '<button class="slick-next"><i class="bi bi-chevron-right"></i></button>',
        customPaging: function(slider, i) {
            return '<button class="dot-segment"></button>';
        },
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 1,
                    centerPadding: '0px',
                    centerMode: true
                }
            }
        ]
    });
});