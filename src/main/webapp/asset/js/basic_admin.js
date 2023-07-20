/* Info
   ========================================================================== */
/**
 * 1. Writer: Hyerin Lim. (Weaverloft Corp.)
 * 2. Production Date: 2023-05-01
 * 3. Client: Weaverloft UX
 */

/*========== Basic ==========*/

/*========== Notice ==========*/
$(function () {

})

/*========== Main - Review list ==========*/
$(function () {
    if ($(".page-home-admin .review-list").length > 0) {
        var reviewSwiper = new Swiper(".review-list", {
            slidesPerView: 2,
            slidesPerColumn: 2,
            slidesPerGroup: 1,
            spaceBetween: 30,
            keyboard: true,
            pagination: {
                el: '.review-pagination',
                clickable: true,
            },
            breakpoints: {
                768: {
                    slidesPerView: 'auto',
                    slidesPerColumn: 1,
                    spaceBetween: 16,
                },
                1024: {
                    slidesPerView: 2,
                    slidesPerColumn: 2,
                    spaceBetween: 30,
                },
            },
            updateOnWindowResize: true
        });
        window.addEventListener('resize', function() {
            reviewSwiper.update();
        });
    };
})
/*========== Main - Chart ==========*/
$(function () {
    if ($(".page-home-admin .main-chart-menu-list").length > 0) {
        var accordion_nav = $('.main-chart-menu-list .menu > a'), accordion_nav_con = $('.main-chart-menu-list .sub-menu');
        accordion_nav.on('click', function (e) {
            accordion_nav.removeClass('active');
            accordion_nav_con.slideUp('normal');
            if ($(this).next().is(':hidden') == true) {
                $(this).addClass('active');
                $(this).next().slideDown('normal');
            }
        });
    }
})

/*========== Calendar ==========*/
if ($(".calendar").length > 0) {
    const daysTag = document.querySelector(".days");
    const currentDate = document.querySelector(".current-date");
    const prevNextIcon = document.querySelectorAll(".month-btn-wrap .btn");

    let currYear = new Date().getFullYear();
    let currMonth = new Date().getMonth();

    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    const renderCalendar = () => {
        const date = new Date(currYear, currMonth, 1);
        let firstDayofMonth = date.getDay();
        let lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate();
        let lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay();
        let lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate();

        let liTag = "";

        for (let i = firstDayofMonth; i > 0; i--) {
            liTag += `<li class="inactive">${lastDateofLastMonth - i + 1}</li>`;
        }

        for (let i = 1; i <= lastDateofMonth; i++) {
            let isToday = i === new Date().getDate() && currMonth === new Date().getMonth() && currYear === new Date().getFullYear() ? "active" : "";
            liTag += `<li class="${isToday}">${i}</li>`;
        }

        for (let i = lastDayofMonth; i < 6; i++) {
            liTag += `<li class="inactive">${i - lastDayofMonth + 1}</li>`
        }

        currentDate.innerText = `${months[currMonth]}, ${currYear}`;
        daysTag.innerHTML = liTag;
    };

    renderCalendar();

    prevNextIcon.forEach(icon => {
        icon.addEventListener("click", () => {
            currMonth = icon.id === "prev" ? currMonth - 1 : currMonth + 1;

            if (currMonth < 0 || currMonth > 11) {
                currYear = icon.id === "prev" ? currYear - 1 : currYear + 1;
                currMonth = currMonth < 0 ? 11 : 0;
            }

            renderCalendar();
        });
    });
}

/*========== Datepicker ==========*/
$(function(){
	if($(".datepicker-box").length > 0) {
		$('.datepicker').datepicker({
            closeText: "닫기",
            prevText: "이전달",
            nextText: "다음달",
            currentText: "오늘",
			dateFormat: 'yy-mm-dd',
			inline: true,
			showOtherMonths: true,
			showMonthAfterYear: true,
			monthNames: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
            dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
            dayNamesMin: ["S", "M", "T", "W", "T", "F", "S"],
            firstDay: 0,
            isRTL: false,
            yearSuffix: "년",
			constrainInput: false,
			changeMonth: true,
			changeYear: true,
			yearRange: "-10:+10",
		});
		$('.datepicker').not('.not').datepicker('setDate', 'today');
	}
});

/*========== Event ==========*/
$(function () {
    if ($(".event-swiper").length > 0) {
        var eventSwiper = new Swiper(".event-swiper", {
            loop: true,
            keyboard: {
                enabled: true,
            },
            slidesPerView: "auto",
            spaceBetween: 12,
            navigation: {
                nextEl: ".event-sec .swiper-button-next",
                prevEl: ".event-sec .swiper-button-prev",
            },
            pagination: {
                el: ".event-sec .swiper-pagination",
                type: 'custom',
                renderCustom: function (swiper, current, total) {
                    return '<span class="active">' + current + '</span><span class="mid-line">/</span><span class="total">' + (total) + '</span>';
                }
            },
            breakpoints: {
                768: {
                    spaceBetween: 10,
                },
                1024: {
                    spaceBetween: 12,
                },
            },
            updateOnWindowResize: true
        });
        window.addEventListener('resize', function() {
            eventSwiper.update();
        });
        $('.event-slide.swiper-slide-duplicate div').removeClass('skeleton-box').removeClass('skeleton-loading');
    };
})

/*========== Tooltip ==========*/
$(function () {
    if ($(".tooltip").length > 0) {
        $(".tooltip img").click(function () {
            // $(this).toggleClass('on');
            $(this).next('.tooltip-con').toggleClass('on');
        });
        $(document).mouseup(function (e) {
            if ($(".tooltip-con, .tooltip.on").has(e.target).length === 0) {
                $(".tooltip").removeClass('on');
                $(".tooltip-con").removeClass('on');
            }
        });
    }
});

/*========== Radio ~ Div show/hide ==========*/
$(document).ready(function () {
    function addChangeListener(element, callback) {
        $(element).on("change", callback);
    }

    function setupShowHideElements(group) {
        const triggerElements = $(`.show-hide-radio[data-group='${group}'] .basic-radio-box input[type='radio']`);
        const targets = $(`.show-hide-radio[data-group='${group}'] .show-hide-div`);

        $(triggerElements).each(function () {
            addChangeListener(this, function () {
                const otherTargets = $(`.show-hide-radio[data-group='${group}'] .show-hide-div:not([data-target='${$(this).attr("data-target")}'])`);
                targets.hide();
                $(this.getAttribute("data-target")).show();
            });
        });

        // 초기 상태 설정 - 첫 번째로 checked 되어 있는 요소의 대상 요소 보여주기
        const checkedElement = triggerElements.filter(":checked");
        if (checkedElement.length > 0) {
            targets.hide();
            $(checkedElement.attr("data-target")).show();
            console.log(triggerElements);
            console.log(checkedElement);
        }
    }

    setupShowHideElements("form-radio-group");
    setupShowHideElements(".");
    setupShowHideElements(".");
    // 필요한 만큼 더 그룹에 대해 호출할 수 있습니다.
});