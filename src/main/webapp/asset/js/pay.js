$(function(){
    var cardSwiper = new Swiper(".pay-card-swiper", {
        slidesPerView: "auto",
        spaceBetween: 0,
        speed: 0,
        keyboard: true,
        navigation: {
            nextEl: ".pay-card-swiper .swiper-button-next",
            prevEl: ".pay-card-swiper .swiper-button-prev",
        },
    });
})

$(function(){
    $(".pay-schedule-more-btn").on("click", function(){
        $(".pay-schedule-info-tl tbody tr").show();
        $(this).hide();
    })
})