<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--========== POP UP ==========-->
<%--
컨펌얼럿
- 버튼 : 확인, 취소
- 콜백 : O
- 사용방법
action_popup.confirm("보여줄 메세지", function (res) {
      if (res) {
         //발생시킬 이벤트
      }
    });
--%>
<div id="common_confirmPop" class="modal msg confirmPop">
    <div class="modal-wrap">
        <section class="modal-content">
            <div class="modal-msg-wrap">
                <p class="msg-tit"></p>
                <div id="confirm-input-wrap" class="input-box-wrap" style="padding-top: 10px">
                    <div class="input-box text">
                        <input type="text" id="confirm-popup-input">
                        <span class="border-focus"><i></i></span>
                    </div>
                </div>
            </div>
            <div class="modal-msg-btn-wrap select">
                <a href="javascript:;" class="common-btn white btn_cancel">취소</a>
                <a href="javascript:;" class="common-btn blue btn_ok">확인</a>
            </div>
        </section>
    </div>
</div>

<%--
얼럿
- 버튼 : 확인
- 콜백 : X
- 사용방법
action_popup.alert("보여줄 메세지");
--%>
<div id="common_alertPop" class="modal msg confirmPop">
    <div class="modal-wrap">
        <section class="modal-content">
            <div class="modal-msg-wrap">
                <p class="msg-tit"></p>
            </div>
            <div class="modal-msg-btn-wrap">
                <a href="javascript:;" onclick="action_popup.close('common_alertPop');" class="common-btn blue">확인</a>
            </div>
        </section>
    </div>
</div>

<%--
얼럿 ver2
- 버튼 : 확인
- 콜백 : O
- 사용방법
action_popup.alert2("보여줄 메세지", function (res) {
        if (res) {
           //발생시킬 이벤트
        }
    });
--%>
<div id="common_alertPop2" class="modal msg confirmPop">
    <div class="modal-wrap">
        <section class="modal-content">
            <div class="modal-msg-wrap">
                <p class="msg-tit"></p>
            </div>
            <div class="modal-msg-btn-wrap">
                <a href="javascript:;" class="common-btn blue btn_ok">확인</a>
            </div>
        </section>
    </div>
</div>

<%--
유효성 검사 등 noti 형식의 얼럿
- 버튼 : 없음
- 콜백 : X
- 사용방법
action_popup.noti("보여줄 메세지"); 또는 action_popup.noti("보여줄 메세지", 2000);
일정 시간 후 사라지는 팝업으로, 타이머 미 설정 시 기본 타이머 값 : 1000
--%>
<div id="common_notiPop" class="modal msg confirmPop">
    <div class="modal-wrap">
        <section class="modal-content">
            <div class="modal-msg-wrap">
                <p class="msg-tit"></p>
            </div>
        </section>
    </div>
</div>
