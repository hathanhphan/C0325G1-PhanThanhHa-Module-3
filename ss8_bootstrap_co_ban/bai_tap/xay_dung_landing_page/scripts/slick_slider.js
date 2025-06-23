$(document).ready(function(){
    $('.surface-slider .slider').slick({
        slidesToShow: 1, // hiển thị 1 card, bạn có thể thay bằng 2–3 tuỳ thiết kế
        infinite: false,
        speed: 500,
        dots: true,
        arrows: true,
        centerPadding: '0px',
        appendDots: $('.surface-slider .progress-bar'),    // đưa dot vào đây
        appendArrows: $('.surface-slider .arrows'),        // đưa arrows vào đây
        prevArrow: '<button class="slick-prev">‹</button>',
        nextArrow: '<button class="slick-next">›</button>',
        customPaging: function(slider, i) {
            // trả về một thanh nhỏ, Slick sẽ render ra <li>…</li> cho mỗi slide
            return '<button class="dot-segment"></button>';
        },
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 1.2, // hiển thị 1 slide đầy đủ + 0.2 preview slide kế
                    slidesToScroll: 1.2,
                    centerPadding: '0px',
                    centerMode: true      // căn giữa slide chính
                }
            }
        ]
    });
});