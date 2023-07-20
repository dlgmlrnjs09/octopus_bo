<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../../asset/css/admin/common.css">
    <link rel="stylesheet" href="../../asset/css/admin/access.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
</head>
<script>
    let idCookie = $.cookie('userId');

    $(document).ready(function() {
        var form = $('#loginForm')[0];

        if(idCookie) {
            $('#userId').val(idCookie);
            $('#id-save').prop('checked',true);
        } else {
            $('#id-save').prop('checked',false);
        }

        $('#loginForm').bind('submit', function () {

            if($('#id-save').is(':checked')) {
                $.cookie('userId', $("#userId").val(), {expires:30});
            } else {
                $.removeCookie('userId');
            }
        });
    });
</script>
<body>
    <div id="container" class="admin access login">
        <!--========== CONTENTS ==========-->
        <main id="main">
            <section class="section access-sec login-sec">
                <h2 class="sec-title hidden">OCTOPUS 관리자 로그인</h2>
                <div class="login-logo-box">
                    <figure class="logo"><img src="../../asset/img/admin/logo-admin-symbol-p.svg" alt="symbol"></figure>
                    <figure class="logo-tit"><img src="../../asset/img/admin/logo-admin-title-p.svg" alt="logo-title"></figure>
                </div>
                <div class="login-txt">
                    <p>안녕하세요! OCTOPUS 관리자만 로그인이 가능합니다. <br> 아이디와 비밀번호를 입력해주세요.</p>
                </div>
                <div class="login-form-wrap">
                    <form method="post" action="/authenticate" id="loginForm">
                        <fieldset>
                            <legend class="hidden">관리자 로그인 - 정보입력</legend>
                            <div class="input-box-wrap">
                                <div class="input-box text">
                                    <input type="text" name="userId" id="userId" class="id" placeholder="아이디">
                                    <span class="border-focus"><i></i></span>
                                </div>
                                <div class="input-box password">
                                    <input type="password" name="password" class="pw" placeholder="비밀번호">
                                    <span class="border-focus"><i></i></span>
                                    <button type="button" class="eye-btn" aria-label="비밀번호 보이기/숨기기"></button>
                                </div>
                            </div>
                            <div class="error-wrap">
                                <!-- .error는 에러 발생 시 보이기 -->
                                <p class="error" style="display: block;">${msg != null ? msg : ''}</p>
                                <p class="error login-error id">아이디를 입력해주세요.</p>
                                <p class="error login-error pw">비밀번호를 입력해주세요.</p>
                                <p class="error login-error wrong">아이디 또는 비밀번호를 잘못 입력하셨습니다.</p>
                            </div>
                            <div class="login-middle-wrap">
                                <div class="basic-check-box id-save">
                                    <input type="checkbox" id="id-save" tabindex="-1">
                                    <label for="id-save" tabindex="0">아이디 저장</label>
                                </div>
                            </div>
                            <div class="input-box submit login">
                                <input type="submit" onclick="" value="로그인" tabindex="0" class="common-btn">
                            </div>
                            <div class="login-bottom-wrap">
                                <ul class="find-wrap">
                                    <li class="find-id">
                                        <a href="#none" tabindex="0">아이디 찾기</a>
                                    </li>
                                    <li class="mid-circle"><span></span></li>
                                    <li class="find-password">
                                        <a href="#none" tabindex="0">비밀번호 찾기</a>
                                    </li>
                                </ul>
                            </div>
                        </fieldset>
                    </form>

                </div>
            </section>
        </main>
    </div>
  </body>
</html>
