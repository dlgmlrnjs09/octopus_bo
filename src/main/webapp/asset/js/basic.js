/* Info
   ========================================================================== */
/**
 * 1. Writer: Hyerin Lim. (Weaverloft Corp.)
 * 2. Production Date: 2022-09-08
 * 3. Client: Weaverloft UX
 */

/*========== Basic ==========*/
// Top Btn
$(function () {
	$(window).scroll(function(){
		if ($(this).scrollTop() > 100) {
			$('#top-btn').fadeIn();
		} else {
			$('#top-btn').fadeOut();
		}
	});
	$('#top-btn').click(function(){
		$("html, body").animate({ scrollTop: 0 }, 400);
		return false;
	});
});

// Modal Popup
function modalPopup(target) {
	$("html").css('overflow-y','hidden');
	$(target).addClass('open');
}
function modalPopupClose(target){
	$("html").css('overflow-y','auto');
	$(target).removeClass('open');
}
$(document).mouseup(function (e){
	var modalPop = $(".modal:not(.msg)");
	if(modalPop.has(e.target).length === 0){
		$("html").css('overflow-y','auto');
		modalPop.removeClass("open");
	}
});

// Tab Menu
$(function () {
	if ($(".tab-container").length > 0) {
		$('ul.tab-menu li.tab-link a').click(function (e) {
			e.preventDefault();
			var tab_id = $(this).parent('li').attr('data-tab');
			$(this).parent('li').siblings('li').removeClass('current');
			$(this).parent('li').addClass('current');
			// $(this).parent().parent().find('.tab-content-wrap').children().removeClass('current');
			$("#" + tab_id).addClass('current').siblings().removeClass('current');
		});
		
		$(".tab-menu:not(.tab-menu02) li.tab-link a").click(function () {
			var position = $(this).parent().position();
			$(".tab-menu:not(.tab-menu02) li.slider").css({
				"left": +position.left,
			});
		});
		var actPosition = $(".tab-menu:not(.tab-menu02) .current").position();
		$(".tab-menu:not(.tab-menu02) li.slider").css({
			"left": +actPosition.left,
		});
		$(window).resize(function(){
			$(".tab-menu:not(.tab-menu02) li.tab-link a").click(function () {
				var position = $(this).parent().position();
				$(".tab-menu:not(.tab-menu02) li.slider").css({
					"left": +position.left,
				});
			});
			var actPosition = $(".tab-menu:not(.tab-menu02) .current").position();
			$(".tab-menu:not(.tab-menu02) li.slider").css({
				"left": +actPosition.left,
			});
		});
	};
});

// Input number + comma
$(document).on('keyup', 'input[name=number]', function (event) {
	if(event.keyCode === 65 || event.keyCode === 17) return; //Ctrl + A 시 전체선택 안됨 이슈 해결
	if(this.value == '0') return;
	let cursorIndex = this.selectionStart;
	const before = this.value.substring(0,cursorIndex).match(/,/g)?.length;
	// this.value = this.value.replace(/[^0-9]/g, ''); // 입력값이 숫자가 아니면 공백
	this.value = this.value.replace(/[^-0-9]/g, ''); // 입력값이 숫자가 아니면 공백 (.제외)
	this.value = (this.value.indexOf("-") === 0 ? "-" : "") + this.value.replace(/[-]/gi, ''); //-가 있다면 replace
	this.value = this.value.replace(/(^0+)/g, ''); // 맨 앞이 0이면 공백
	this.value = this.value.replace(/,/g, ''); // ,값 공백처리
	this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가
	const after = this.value.substring(0,cursorIndex).match(/,/g)?.length;
	if(before != after) cursorIndex++; // ',' 추가시 커서 위치 조정
	this.setSelectionRange(cursorIndex,cursorIndex);
});

// Input checkbox All check
$(document).on('click', 'input[name="selectAll"]', function () {
	$('.chkgroup:not(:disabled)').not(this).prop('checked', this.checked);
});

$(document).on('click', '.chkgroup', function () {
	if ($('.chkgroup:not(:disabled)').length == $('.chkgroup:checked').length) {
		$('input[name="selectAll"]').prop('checked', true);
	} else {
		$('input[name="selectAll"]').prop('checked', false);
	}
}); 

// Input
$(function () {
	// border animation
	$(".input-box input").focusin(function () {
		$(this).next().addClass('on');
	});
	$(".input-box input").focusout(function () {
		$(this).next().removeClass('on');
	});
	// input password eye-btn
	$(".input-box.password .eye-btn").click(function() {
		$(this).toggleClass("open");
		var input = $($(this).parent().find('input'));
		if (input.attr("type") == "password") {
			input.attr("type", "text");
		} else {
			input.attr("type", "password");
		}
	});
	// input password animation
	$(".input-box.password").focusin(function () {
		$(this).find('span').addClass('on');
	});
	$(".input-box.password").focusout(function () {
		$(this).find('span').removeClass('on');
	});
	// signup input check
	$(".signup-wrap .input-box").focusin(function () {
		$(this).next('.check-text-wrap').addClass('on');
	});
	$(".signup-wrap .input-box").focusout(function () {
		$(this).next('.check-text-wrap').removeClass('on');
	});
	// signup email input check
	$('.email-input-box .input-box-wrap *').focusin(function(){
		$('.email-input-box .input-box-wrap ~ .check-text-wrap').show();
	});
	$('.email-input-box .input-box-wrap *').focusout(function(){
		$('.email-input-box .input-box-wrap ~ .check-text-wrap:not(.on)').hide();
	});
});

// flie Upload 
var fileArr = [], fileArr2 = [];
var fileIndex = 0, fileIndex2 = 0;

$(function () {
	if ($(".upload-file").length > 0) {
		const handler = {
			init() {
				const fileInput = document.querySelector('.upload-file input[type="file"]');
				const preview = document.querySelector('.file-list');
				fileInput.addEventListener('change', () => {
					const files = Array.from(fileInput.files)
					files.forEach(file => {
						fileArr.push(file);
						preview.innerHTML += `
						<div class="file">
							<p id="${fileIndex}">${file.name}</p>
							<button data-index="${fileIndex}" class='file-remove'>X</button>
						</div>`;
						fileIndex++;
					});
					fileInput.value = "";
				});
			},
			removeFile: () => {
				document.addEventListener('click', (e) => {
					if (e.target.className !== 'file-remove') return;
					const removeTargetId = e.target.dataset.index;
					const removeTarget = document.getElementById(removeTargetId).parentElement;
					const files = document.querySelector('.upload-file input[type="file"]').files;
					const dataTranster = new DataTransfer();

					Array.from(files)
						.filter(file => file.lastModified != removeTargetId)
						.forEach(file => {
							dataTranster.items.add(file);
						});
					if (fileArr.length > 0 && removeTargetId !== undefined && !isNaN(removeTargetId)) {
						fileArr[removeTargetId].is_delete = true;
					}
					document.querySelector('.upload-file input').files = dataTranster.files;
					removeTarget.remove();
				})
			}
		}
		handler.init()
		handler.removeFile()
	}
});

// custom select
$(".custom-select-box ul").on("click", ".init", function() {
    $(this).closest(".custom-select-box ul").children('li:not(.init)').toggle();
    $(this).closest(".custom-select-box ul").toggleClass('open');
});

$(".custom-select-box ul").each(function() {
    var selectBox = $(this);
    var allOptions = selectBox.children('li:not(.init)');

    selectBox.on("click", "li:not(.init)", function() {
        allOptions.removeClass('selected');
        $(this).addClass('selected');
        selectBox.children('.init').html($(this).html());
        allOptions.toggle();
        selectBox.removeClass('open').addClass('sel');
    });
});
$(document).on("click", function(event) {
    var target = $(event.target);
    var selectBox = $(".custom-select-box ul");
    
    if (!target.closest(".custom-select-box").length) {
        // 클릭된 요소가 셀렉트 박스 외부이면
        selectBox.children('li:not(.init)').hide();
        selectBox.removeClass('open');
    } else {
        // 클릭된 요소가 셀렉트 박스 내부이면
        if (!target.hasClass("init")) {
            selectBox.children('li:not(.init)').hide();
            selectBox.removeClass('open');
        }
    }
});