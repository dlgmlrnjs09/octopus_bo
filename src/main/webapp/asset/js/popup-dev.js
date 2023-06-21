/* info
   ========================================================================== */
/**
 * 1. Writer: Ajin Lee (Weaverloft Corp.)
 * 2. Production Date: 2022-03-24
 * 3. Client: AmorePacific Management System
 */

/* 리얼팝업
   ========================================================================== */

function PopupReg1(href, w, h , target) {
    if (w == null) {
        w = 1440;
    }
    if (h == null) {
        h = 810;
    }
	var xPos = (document.body.offsetWidth/2) - (w/2) - 7; // 가운데 정렬
	xPos += window.screenLeft; // 듀얼 모니터일 때
	var yPos = (document.body.offsetHeight/2) - h + 50;

	window.open(href, target, "width="+w+", height="+h+", left="+xPos+", top="+yPos+", menubar=no, status=no, titlebar=no, resizable=no, location=no, toolbar=no, scrollbars=yes");
}

/* 모달 팝업
   ========================================================================== */
/**
 *  alert, confirm 대용 팝업 메소드 정의 <br/>
 *  timer : 애니메이션 동작 속도 <br/>
 *  alert : 경고창 <br/>
 *  confirm : 확인창 <br/>
 *  open : 팝업 열기 <br/>
 *  close : 팝업 닫기 <br/>
 */
 var action_popup = {
    confirm: function (txt, isShowInput, callback) {

        $("#confirm-input-wrap").find('input').val('');
        if (!isShowInput) {
            $("#confirm-input-wrap").addClass('hidden');
        } else {
            $("#confirm-input-wrap").removeClass('hidden');
        }

      if (txt == null || txt.trim() == "") {
        console.warn("confirm message is empty.");
      } else if (callback == null || typeof callback != 'function') {
        console.warn("callback is null or not function.");
      } else {
        $("#common_confirmPop .btn_ok").on("click", function () {
          $(this).unbind("click");
          callback(true);
          action_popup.close("common_confirmPop");
        });
        $("#common_confirmPop .btn_cancel").on("click", function () {
          $(this).unbind("click");
          callback(false);
          action_popup.close("common_confirmPop");
        });
        this.open("common_confirmPop", txt);
      }
    },

    alert: function (txt) {
        this.open("common_alertPop", txt);
    },

    alert2: function (txt, callback) {
      $("#common_alertPop2 .btn_ok").on("click", function () {
          $(this).unbind("click");
          callback(true);
          action_popup.close("common_alertPop2");
      });
      this.open("common_alertPop2", txt);
    },

    noti: function (txt, timeout) {
        this.open("common_notiPop", txt);
        setTimeout(function() {
            action_popup.close("common_notiPop");
        }, timeout ? timeout : 1000);
    },

    open: function (id, txt) {
      const popup = $("#" + id);
      popup.find(".msg-tit").text(txt);
      popup.addClass('open');
    },

    close: function (id) {
      $("#" + id + " .btn_ok").unbind("click");
      $("#" + id).removeClass('open');
    }
};


// 취소 클릭 시 팝업
function cancelPop() {
  action_popup.confirm('입력한 정보를 취소 하시겠습니까?', function (res) {
    if (res) {
      location.reload();
    }
  });
}

// 취소 클릭 시 팝업2 (창 닫기 메세지 추가)
function cancelPop2() {
  action_popup.confirm('입력한 정보를 취소하고\n팝업창을 닫으시겠습니까?', function (res) {
    if (res) {
      window.close();
    }
  });
}
