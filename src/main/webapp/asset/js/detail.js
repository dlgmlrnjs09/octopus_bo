/* Info
   ========================================================================== */
/**
 * 1. Writer: Jinsong Kim. (Weaverloft Corp.)
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

/* ======== swiper ======== */
$(function(){
    //상세사진 썸네일 슬라이드
    var prdThumbSwiper = new Swiper(".prd-info-swiper-thumb", {
        freeMode: true,
        slideToClickedSlide: true,
        watchSlidesProgress: true,
        breakpoints: {
          720: {
            slidesPerView: 3,  //브라우저가 1080보다 클 때
            spaceBetween: 8,
          },
          980: {
            slidesPerView: 4,  //브라우저가 1080보다 클 때
            spaceBetween: 10,
          },
          1280: {
            slidesPerView: 5,  //브라우저가 1280보다 클 때
            spaceBetween: 14,
          },
        },
      });
    var prdTopSwiper = new Swiper(".prd-info-swiper-top", {
      spaceBetween: 0,
      keyboard: true,
      grabCursor: true,
      slidesPerView: "auto",
      navigation: {
        nextEl: ".prd-info-swiper-thumb-button-wrap .swiper-button-next",
        prevEl: ".prd-info-swiper-thumb-button-wrap .swiper-button-prev",
      },
      pagination: {
        el: ".prd-info-swiper-top .swiper-pagination",
        type: "fraction",
      },
      thumbs: {
        swiper: prdThumbSwiper,
      },
    });

    //최다판매상품, 신상품, 최대조회상품 스와이퍼 .prd-detail-recommend-swiper-normal
    $(function(){
        var swiperRecommends = {};
        $(".prd-detail-recommend-swiper-normal").each(function(index, element){
            var $this = $(this);
            $this.addClass("recommend-" + index);
            $this.siblings(".prd-detail-recommend-swiper-btn-wrap").find(".swiper-button-prev").addClass("btn-prev-" + index);
            $this.siblings(".prd-detail-recommend-swiper-btn-wrap").find(".swiper-button-next").addClass("btn-next-" + index);
            swiperRecommends[index] = new Swiper(".recommend-" + index, {
              breakpoints: {
                0: {
                  spaceBetween: 14,  //브라우저가 0보다 클 때
                },
                720: {
                  spaceBetween: 20,  //브라우저가 720보다 클 때
                },
              },
              slidesPerView: "auto",
              keyboard: true,
              loop: false,
              navigation: {
                  nextEl: ".prd-detail-recommend-swiper-normal + .prd-detail-recommend-swiper-btn-wrap .btn-next-" + index,
                  prevEl: ".prd-detail-recommend-swiper-normal + .prd-detail-recommend-swiper-btn-wrap .btn-prev-" + index,
              },
            });
        });
    });

    //.prd-detail-recommend-swiper-transform
    $(function(){
      var swiperRecommend02 = new Swiper(".prd-detail-recommend-swiper-transform", {
        keyboard: true,
        loop: false,
        spaceBetween: 20,  
        breakpoints: {
          0: {//브라우저가 0보다 클 때
            slidesPerView: 1,
            grid: {
              rows: 3,
            },
          },
          421: {//브라우저가 361보다 클 때
            slidesPerView: "auto",
          },
        },
        navigation: {
          nextEl: ".prd-detail-recommend-swiper-transform + .prd-detail-recommend-swiper-btn-wrap .swiper-button-next",
          prevEl: ".prd-detail-recommend-swiper-transform + .prd-detail-recommend-swiper-btn-wrap .swiper-button-prev",
        },
        pagination: {
            el: ".prd-detail-recommend-swiper-transform + .prd-detail-recommend-swiper-btn-wrap .swiper-pagination",
            type: "fraction",
          },
      });
    })
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

      if($(window).width() > 720){
        tabConOffset = tabCon.eq(liIndex).offset().top - headerHeight - 30;
      } else{ 
        tabConOffset = tabCon.eq(liIndex).offset().top - headerHeight - 10;
      }

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
    if($(window).width() > 1280){
      let headerHeight = $("#header").outerHeight();
      let nowTop = $(window).scrollTop() + headerHeight;
      let orderWrapTop = $(".prd-detail-contents-tab").offset().top;
      let payboxOffset = nowTop - orderWrapTop;
      let orderWrapHeight = $(".prd-detail-contents-tab").outerHeight();
      let orderwrapBottom = orderWrapTop + orderWrapHeight;

      if ( nowTop > orderWrapTop + 65 && nowTop < orderwrapBottom - $(".prd-detail-contents-purchase-bar").outerHeight() - 65 ){ //65는 margin-top값
        $(".prd-detail-contents-purchase-bar").css({
            "top" : payboxOffset, "bottom" : "auto",
            "margin-top" : "65px"
        });
      } else if( nowTop <= orderWrapTop ){
          $(".prd-detail-contents-purchase-bar").css({
              "top" : "107px", "bottom" : "auto",
              "margin-top" : "0"
          });
      } else if( nowTop >= orderwrapBottom - $(".prd-detail-contents-purchase-bar").outerHeight() - 200 ){ //200은 .prd-detail-contents-tab 패딩 + prd-detail-sec 마진
        $(".prd-detail-contents-purchase-bar").css({
            "top" : "auto", "bottom" : "0",
            "margin-top" : "0"
        });
      } 
    } else{
      $(".prd-detail-contents-purchase-bar").css({
        "top" : "auto", "bottom" : "0",
        "margin-top" : "0"
      });
    }
  }

  $(window).scroll(purchaseBar);
  $(window).resize(purchaseBar);
  $(window).on("load", purchaseBar);
});

/* ======== purchase-bar active ======== */
$(function(){
  const purchaseBar = $(".prd-detail-contents-purchase-bar")
  const purchaseBtn = $(".prd-detail-contents-purchase-bar .txt-btn")
  const purchaseCloseBtn = $(".prd-detail-contents-purchase-bar .close-btn")

  if( $(window).width() < 1280 ) {
    purchaseBtn.on("click", function(){
      purchaseBar.addClass("active")
    });
    purchaseCloseBtn.on("click", function(){
      purchaseBar.removeClass("active")
    })
  }

});

/* ======== img-more-btn ======== */
$(function(){
  const moreBtn = $(".tab-con-detail-more-btn")

  moreBtn.on("click", function(){
    $(".tab-con-detail-img-wrap").toggleClass("active");
    $(this).hide()
  })

  //버튼 텍스트 내용 바꾸기
  // $(document).on("click", moreBtn, function(){
  //   if($(".tab-con-detail-img-wrap").is(".active") === true){
  //     $(".tab-con-detail-more-btn span").text("상품정보 접기")
  //   } else {
  //     $(".tab-con-detail-more-btn span").text("상품정보 더보기")
  //   }
  // });
})

/* ======== folded-menu ======== */
$(function(){
  if ($(".tab-con-detail-supply-box").length > 0) {
		$('.tab-con-detail-supply-box-tit').click(function () {
			$(this).next().slideToggle();
			$(this).toggleClass("active");
		});
	}
});

/* ======== tab-con-review ======== */
$(function(){
  const reviewMoreBtn = $(".review-contents-box-more-btn")

  //자세히보기 버튼 
  reviewMoreBtn.on("click", function(){
    $(this).parents(".review-contents-box").toggleClass("active");

    const reviewImg = $(this).parents(".review-contents-box").find(".review-contents-img");
    //사진 펼치기
    
    function boxOpen() {
      function adjustImagePosition() {
        reviewImg.each(function (i) {
          $(this).css({
            left: i * reviewImg.width() + i * 10,
          });
        });
      }
    
      $(window).resize(adjustImagePosition);
      adjustImagePosition();
    }

    if( $(this).parents(".review-contents-box").is(".active") === true){
      $(this).text("접기")  //버튼 텍스트 내용 바꾸기
      boxOpen();
    } else{
      $(this).text("자세히"); //버튼 텍스트 내용 바꾸기
      reviewImg.css({
        left: 0
      })
    }    
  });

  //추천 버튼
  $(".review-contents-box-thumbs-up").on("click", function(){
    $(this).parent(".review-contents-box-thumbs-up-wrap").toggleClass("active")
  })
})

/* ======== review-filter-modal ======== */
$(function(){
  $(".review-contents-sorting-btn").on("click", function(){
    $(".tab-con-review-filter-modal").addClass("active")
  })
  $(".review-filter-modal-close").on("click", function(){
    $(".tab-con-review-filter-modal").removeClass("active")
  })
  
  // 외부를 클릭하면 박스 닫힘
  var target = $(".tab-con-review-filter-modal-box");
  $(document).mouseup(function (e){
    if(target.has(e.target).length==0) {
        target.parent().removeClass('active');
    } 
  });

  //li 누르면 active
  $(".review-filter-modal-list li a").on("click", function(){
    $(this).toggleClass("active")
  })
})
