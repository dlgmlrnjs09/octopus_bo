/* mileage-wrap */
$(function(){
  $(".info-notice-guide .guide-desc").on("click", function(){
    $(".info-notice-guide .mileage").toggleClass("active");
    $(".info-notice-guide .guide-item.benefit").toggleClass("active");
  })
});

/* sns-wrap */
$(function(){
  var target = $(".info-notice-sns");

  $(".info-notice-sns-btn").on("click", function(){
    target.toggleClass("active")
  });
  // 외부를 클릭하면 박스 닫힘
  $(document).mouseup(function (e){
    if(target.has(e.target).length==0) {
        target.removeClass('active');
    } 
  });
  
});

/* 옵션 선택시 옵션박스 활성화 */
$(function(){
  const option = $(".custom-select-box.detail-product-select-box li:not(.init)")
  const optionArea = $(".option-select-active-area") 
  const optionList = $(".option-select-active-area .selected-item-list")
  const optionBox = $(".option-select-active-area .selected-item")

  option.on("click", function(){
    optionArea.addClass("active");
    optionBox.clone().appendTo(optionList).addClass("active").find(".selected-item-tit").text($(this).text())
  });

  //옵션 박스 닫기
  $(document).on("click", optionBox, function(){
    $(".buy-item-close").on("click", function(){
      $(this).parent("li.selected-item").remove();
    });
  })

  
  // 정기배송 체크박스 활성화
  if($(".option-select-active-area").length > 0){
    $(".option-select-active-area .regular-delivery-check").show()
  } else {
    $(".option-select-active-area .regular-delivery-check").hide()
  } 
});

/* swiper */
$(function(){
    //상세사진 썸네일 슬라이드
    var prdThumbSwiper = new Swiper(".prd-info-swiper-thumb", {
        spaceBetween: 0,
        slidesPerView: "auto",
        freeMode: true,
        slideToClickedSlide: true,
        watchSlidesProgress: true,
      });
    var prdTopSwiper = new Swiper(".prd-info-swiper-top", {
      spaceBetween: 0,
      keyboard: true,
      grabCursor: true,
      slidesPerView: "auto",
      navigation: {
        nextEl: ".prd-info-swiper-thumb .swiper-button-next",
        prevEl: ".prd-info-swiper-thumb .swiper-button-prev",
      },
      thumbs: {
        swiper: prdThumbSwiper,
      },
    });

    //최다판매상품, 신상품, 최대조회상품 스와이퍼
    $(function(){
        var swiperRecommends = {};
        $(".prd-detail-recommend-swiper").each(function(index, element){
            var $this = $(this);
            $this.addClass("recommend-" + index);
            $this.siblings(".prd-detail-recommend-swiper-btn-wrap").find(".swiper-button-prev").addClass("btn-prev-" + index);
            $this.siblings(".prd-detail-recommend-swiper-btn-wrap").find(".swiper-button-next").addClass("btn-next-" + index);
            swiperRecommends[index] = new Swiper(".recommend-" + index, {
              spaceBetween: 0,
              slidesPerView: 3,
              keyboard: true,
              loop: false,
                navigation: {
                    nextEl: ".prd-detail-recommend-swiper-btn-wrap .btn-next-" + index,
                    prevEl: ".prd-detail-recommend-swiper-btn-wrap .btn-prev-" + index,
                },
            });
        });
    });
});

