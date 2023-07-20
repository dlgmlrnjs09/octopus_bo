/* Info
   ========================================================================== */
/**
 * 1. Writer: Jinsong Kim. (Weaverloft Corp.)
 * 2. Production Date: 2023-06-01
 * 3. Client: Weaverloft UX
 */

/* =========== prd-box =========== */
$(function(){
   //coupon-modal
   $(".coupon-down-btn").on("click", function(){
      $(this).next().addClass("active")
   });
   $(".coupon-down-confirm-btn").on("click", function(){
      $(this).parents(".coupon-down-wrap").removeClass("active")
   });
   // 외부를 클릭하면 박스 닫힘
   var target = $(".coupon-down-wrap");
   $(document).mouseup(function (e){
      if(target.has(e.target).length==0) {
          target.removeClass('active');
      } 
    });

   //option-btn
   $(".prd-box .option-change-btn").on("click", function(){
      $(this).parents(".prd-box").toggleClass("active")
   });

   //close-btn
   $(".prd-box .prd-box-close-btn").on("click", function(){
      $(this).parents(".prd-box").hide()
   })
});

/* =========== cart-precautions =========== */
$(function(){
   $(".cart-precautions-tit").on("click", function(){
      $(this).toggleClass("active")
      $(this).next().slideToggle();
   });
});

/* =========== cart-prd-total-price-wrap =========== */
$(function(){
   function totalPriceWrap () {
     if($(window).width() > 1280){
       const priceWrap = $(".cart-prd-total-price-wrap")
       let headerHeight = $("#header").outerHeight();
       let nowTop = $(window).scrollTop() + headerHeight;
       let orderWrapTop = $(".cart-contents-sec").offset().top;
       let payboxOffset = nowTop - orderWrapTop;
       let orderWrapHeight = $(".cart-contents-sec").outerHeight();
       let orderwrapBottom = orderWrapTop + orderWrapHeight;
 
       if ( nowTop > orderWrapTop - 20 && nowTop < orderwrapBottom - priceWrap.outerHeight() - 20 ){ //20은 margin-top값(조정값) 
         priceWrap.css({
             "top" : payboxOffset, "bottom" : "auto",
             "margin-top" : "20px"
         });
       } else if( nowTop <= orderWrapTop ){
         priceWrap.css({
               "top" : "0", "bottom" : "auto",
               "margin-top" : "0"
           });
       } else if( nowTop >= orderwrapBottom - priceWrap.outerHeight() ){
         priceWrap.css({
             "top" : "auto", "bottom" : "0",
             "margin-top" : "0"
         });
       } 
     } else{
      priceWrap.css({
         "top" : "auto", "bottom" : "0",
         "margin-top" : "0"
       });
     }
   }
 
   $(window).scroll(totalPriceWrap);
   $(window).resize(totalPriceWrap);
   $(window).on("load", totalPriceWrap);
 });

 $(function(){
  function totalPriceWrap2 () {
    if($(window).width() > 1280){
      const priceWrap = $(".cart-prd-total-price-wrap.regular-delivery")
      let headerHeight = $("#header").outerHeight();
      let nowTop = $(window).scrollTop() + headerHeight;
      let orderWrapTop = $(".cart-contents-sec").offset().top;
      let payboxOffset = nowTop - orderWrapTop;
      let orderWrapHeight = $(".cart-contents-sec").outerHeight();
      let orderwrapBottom = orderWrapTop + orderWrapHeight;

      if ( nowTop > orderWrapTop - 20 && nowTop < orderwrapBottom - priceWrap.outerHeight() - 20 ){ //20은 margin-top값(조정값) 
        priceWrap.css({
            "top" : payboxOffset, "bottom" : "auto",
            "margin-top" : "20px"
        });
      } else if( nowTop <= orderWrapTop ){
        priceWrap.css({
              "top" : "0", "bottom" : "auto",
              "margin-top" : "0"
          });
      } else if( nowTop >= orderwrapBottom - priceWrap.outerHeight() ){
        priceWrap.css({
            "top" : "auto", "bottom" : "0",
            "margin-top" : "0"
        });
      } 
    } else{
     priceWrap.css({
        "top" : "auto", "bottom" : "0",
        "margin-top" : "0"
      });
    }
  }

  $(window).scroll(totalPriceWrap2);
  $(window).resize(totalPriceWrap2);
  $(window).on("load", totalPriceWrap2);
});

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

/* =========== datepicker =========== */
$(function(){
  $('.datepicker').datepicker();

   /* 한국씩 달력 표기법으로 변경 */
   $.datepicker.setDefaults({
      dateFormat: 'yy년 mm월 dd일 (D)',
      monthNames: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
      monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
      dayNames: ['일', '월', '화', '수', '목', '금', '토'],
      dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
      dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
      showMonthAfterYear: true,
      showOtherMonths: true,
      yearSuffix: '.',
      minDate: 0,  // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
      beforeShow: function(input) {
        var i_offset= $(input).offset(); //클릭된 input의 위치값 체크
        $('#ui-datepicker-div').css({
          'top':i_offset.top + 42 //42는 input 높이값
        });
        $(window).scroll(function(){
          var i_offset= $(input).offset(); //클릭된 input의 위치값 체크
          $('#ui-datepicker-div').css({
            'top':i_offset.top + 42
          });
        });
		  } 
  });
    
  /* 오늘 날짜 기본 날짜로 지정 */
  $(function() {   
      var today = $.datepicker.formatDate('yy년 mm월 dd일 (D)', new Date());
      $( ".datepicker" ).datepicker( "setDate", today );
  }); 


});
