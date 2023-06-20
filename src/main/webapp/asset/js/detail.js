/* Info
   ========================================================================== */
/**
 * 1. Writer: Hyerin Lim. (Weaverloft Corp.)
 * 2. Production Date: 2023-06-01
 * 3. Client: Weaverloft UX
 */

/* ======== mileage-wrap ======== */
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

/* ======== 옵션 선택시 옵션박스 활성화 ======== */
// $(function(){
//   const option = $(".custom-select-box.detail-product-select-box li:not(.init)")
//   const optionArea = $(".option-select-active-area") 
//   const optionList = $(".option-select-active-area .selected-item-list")
//   const optionBox = $(".option-select-active-area .selected-item")

//   option.on("click", function(){
//     optionArea.addClass("active");
//     optionBox.clone().appendTo(optionList).addClass("active").find(".selected-item-tit").text($(this).text())
//   });

//   //옵션 박스 닫기
//   $(document).on("click", optionBox, function(){
//     $(".buy-item-close").on("click", function(){
//       $(this).parent("li.selected-item").remove();
//     });
//   })

  
//   // 정기배송 체크박스 활성화
//   if($(".option-select-active-area").length > 0){
//     $(".option-select-active-area .regular-delivery-check").show()
//   } else {
//     $(".option-select-active-area .regular-delivery-check").hide()
//   } 
// });

/* ======== swiper ======== */
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

/* ======== tab-menu ======== */
$(function () {
	if ($(".tab-menu").length > 0) {
		$('.tab-menu  ul > li > a').click(function (e) {
			e.preventDefault();
			$(this).parent().addClass('active');
			$(this).parent().siblings().removeClass('active');
			$(this).parents(".tab-menu-wrap").find('.tab-con').removeClass('active');
			$(this).parents(".tab-menu-wrap").find('.tab-con').eq($(this).parent().index()).addClass('active');
		});
	}
});

$(function(){
  const tabMenu = $(".prd-detail-contents-tab-menu li a");
  const tabCon = $(".prd-detail-contents-tab .tab-con");
  const tabMenuAll = $(".prd-detail-contents-tab-menu");
  let liIndex = '';
  let tabConOffset = '';
  let headerHeight = '';
 
  /* tab메뉴 누르면 그 위치로 이동 */
  tabMenu.on("click", function(){

      tabMenu.parent().removeClass("active");

      liIndex = $(this).parent().index();
      headerHeight = $("#header").outerHeight() + $(".prd-detail-contents-tab .tab-menu").outerHeight();

      tabConOffset = tabCon.eq(liIndex).offset().top - headerHeight - 30;
      $('html,body').animate({
              scrollTop : tabConOffset,
          }, 200
      );
  });

 /* 그 위치에 가면 tab.active 활성화시키기 */
 function tabScrollTopActive () {
  let nowTop = $(window).scrollTop();
    headerHeight = $("#header").outerHeight();

    let tabConOffset2 = tabCon.eq(1).offset().top - headerHeight - 125;
    let tabConOffset3 = tabCon.eq(2).offset().top - headerHeight - 125;
    let tabConOffset4 = tabCon.eq(3).offset().top - headerHeight - 125;

    tabMenu.parent().removeClass("active");

    if ( nowTop >= 0 && nowTop < tabConOffset2 ){
        tabMenu.parent().eq(0).addClass("active");     
    } else if( nowTop >= tabConOffset2 && nowTop < tabConOffset3 ){
        tabMenu.parent().eq(1).addClass("active");     
    } else if ( nowTop >= tabConOffset3 && nowTop < tabConOffset4 ){
        tabMenu.parent().eq(2).addClass("active");     
    } else if ( nowTop >= tabConOffset4 ){
        tabMenu.parent().eq(3).addClass("active");     
    }
}
tabMenu.on("click", tabScrollTopActive);
$(window).scroll(tabScrollTopActive);
$(window).on("load", tabScrollTopActive);
$(window).on("resize", tabScrollTopActive);

  /* tab메뉴 sticky top값 */
  function tabmenuStickyTop () {
    headerHeight = $("#header").outerHeight()
        tabMenuAll.css({
            "top" : headerHeight,
        });
  }
  $(window).scroll(tabmenuStickyTop);
  $(window).on("load", tabmenuStickyTop);
  $(window).on("resize", tabmenuStickyTop);
});

/* ======== purchase-bar 스크롤 ======== */
$(function(){
  function purchaseBar () {
      let headerHeight = $("#header").outerHeight();
      let nowTop = $(window).scrollTop() + headerHeight;
      let orderWrapTop = $(".prd-detail-contents-tab").offset().top;
      let payboxOffset = nowTop - orderWrapTop;
      let orderWrapHeight = $(".prd-detail-contents-tab").outerHeight();
      let orderwrapBottom = orderWrapTop + orderWrapHeight;

      if ( nowTop > orderWrapTop + 65 && nowTop < orderwrapBottom - $(".prd-detail-contents-purchase-bar").outerHeight() ){
          $(".prd-detail-contents-purchase-bar").css({
              "top" : payboxOffset, "bottom" : "auto",
              "margin-top" : "65px"
          });
      } else if( nowTop <= orderWrapTop ){
          $(".prd-detail-contents-purchase-bar").css({
              "top" : "107px", "bottom" : "auto",
              "margin-top" : "0"
          });
      } else if( nowTop >= orderwrapBottom - $(".prd-detail-contents-purchase-bar").outerHeight() ){
          $(".prd-detail-contents-purchase-bar").css({
              "top" : "auto", "bottom" : "0",
              "margin-top" : "0"
          });
      } 
  }

  $(window).scroll(purchaseBar);
  $(window).on("load", purchaseBar);
});



/* ======== img-more-btn ======== */
$(function(){
  $(".tab-con-detail-more-btn").on("click", function(){
    $(".tab-con-detail-img-wrap").toggleClass("active")
  })
});

/* ======== folded-menu ======== */
$(function(){
  if ($(".tab-con-detail-supply-box").length > 0) {
		$('.tab-con-detail-supply-box-tit').click(function () {
			$(this).next().slideToggle();
			$(this).toggleClass("active");
		});
	}
});


// /* review-more 무한 더보기*/
// $(function(){
    
//   const reviewTab = $(".review-contents-body-list");
//   const reviewLi = $(".review-contents-body-list li");
//   const reviewMoreBtn = $(".tab-review-more");
//   const reviewTabBtn = $(".review-tab-menu > ul > li > a");

//   //첫번째 group 나와있기
//   reviewLi.slice(0, 1).show();
//   reviewTabBtn.on("click", function(){
//       $('.review-tab-con').eq($(this).parent().index()).find(reviewLi).slice(0, 1).show();
//   });
  
//   //더보기 버튼 누르면 다음 group 나오기
//   reviewMoreBtn.on("click", function(){
//       $(this).parent(".tab-more-wrap").siblings(reviewTab).find(".review-contents-body:hidden").slice(0, 1).show();
//   });
// })