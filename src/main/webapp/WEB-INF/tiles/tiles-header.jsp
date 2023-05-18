<%--
  Created by IntelliJ IDEA.
  User: note-gram-015
  Date: 2023-05-16
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--========== HEADER ==========-->
<header id="header">
    <div class="header-wrap">
        <div class="header-left">
            <div class="search-area">
                <div class="input-box text">
                    <input type="text" placeholder="검색어를 입력하세요.">
                    <span class="border-focus"><i></i></span>
                    <button type="button" class="search-btn" onclick="" aria-label="검색하기"><img src="../../asset/img/admin/icon-search.svg" alt="검색하기"></button>
                </div>
            </div>
        </div>
        <div class="header-right">
            <ul>
                <li class="alarm-area">
                    <button type="button" class="bubble-btn alarm" aria-label="알림창 보기">
                        <img src="../../asset/img/admin/icon-alarm.svg" alt="알림">
                        <!-- .new 새로운 알림 있을 경우 show 없을 경우 hide -->
                        <span class="new"></span>
                    </button>
                    <div class="bubble-box alarm-bubble-box">
                        <div class="alarm-head">
                            <strong class="title">새로운 알림 <span class="count">7건</span></strong>
                            <div class="all-btn-wrap">
                                <button type="button" class="all-read-btn" aria-label="모두 읽음">모두 읽음 표시</button> <span class="mid-line"></span>
                                <button type="button" class="all-delet-btn" aria-label="모두 삭제">모두 삭제</button>
                            </div>
                        </div>
                        <div class="alarm-contents">
                            <ul class="alarm-contents-list">
                                <!-- 새로운 알림일때 li 클래스 new 추가 -->
                                <li class="new">
                                    <span class="dot"></span>
                                    <div class="alarm-content">
                                        <strong class="tit">카페24 페이먼츠 정산 한도 상향 요청 기능 업데이트 안내</strong>
                                        <p class="txt">카페24 페이먼츠 정산 한도 상향이 필요한 경우 카페24 페이먼츠 정산관리 화면에서 요청할 수 있어요.</p>
                                        <span class="date">23.03.29 09:00</span>
                                    </div>
                                    <button type="button" class="all-read-btn" aria-label="알림 삭제"><img src="../../asset/img/icon-close-g.svg" alt="삭제"></button>
                                </li>
                                <li>
                                    <span class="dot"></span>
                                    <div class="alarm-content">
                                        <strong class="tit">카페24 페이먼츠 정산 한도 상향 요청 기능 업데이트 안내</strong>
                                        <p class="txt">카페24 페이먼츠 정산 한도 상향이 필요한 경우 카페24 페이먼츠 정산관리 화면에서 요청할 수 있어요.</p>
                                        <span class="date">23.03.29 09:00</span>
                                    </div>
                                    <button type="button" class="all-read-btn" aria-label="알림 삭제"><img src="../../asset/img/icon-close-g.svg" alt="삭제"></button>
                                </li>
                                <li class="new">
                                    <span class="dot"></span>
                                    <div class="alarm-content">
                                        <strong class="tit">카페24 페이먼츠 정산 한도 상향 요청 기능 업데이트 안내</strong>
                                        <p class="txt">카페24 페이먼츠 정산 한도 상향이 필요한 경우 카페24 페이먼츠 정산관리 화면에서 요청할 수 있어요.</p>
                                        <span class="date">23.03.29 09:00</span>
                                    </div>
                                    <button type="button" class="all-read-btn" aria-label="알림 삭제"><img src="../../asset/img/icon-close-g.svg" alt="삭제"></button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="mid-line"><span></span></li>
                <li class="user-area">
                    <a href="javascript:;" class="bubble-btn user" aria-label="내정보 보기">
                        <figure class="profile"><img src="../../asset/img/admin/icon-my.svg" alt="user"></figure>
                        <div class="name-box">
                            <p class="name">이무너 님</p>
                            <p class="grading">admin</p>
                        </div>
                        <figure class="arrow"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></figure>
                    </a>
                    <div class="bubble-box user-bubble-box">
                        <div class="user-head">
                            <div class="user-info">
                                <p class="name">이무너 님</p>
                                <p class="grading">admin 대표운영자</p>
                            </div>
                            <button type="button" class="logout-btn" aria-label="로그아웃"><img src="../../asset/img/admin/icon-logout.svg" alt="로그아웃"></button>
                        </div>
                        <ul class="user-menu">
                            <li><a href="#none">내 쇼핑몰 정보 확인</a></li>
                            <li><a href="#none">사업자 정보 확인</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</header>
<div class="nav">
    <div class="top">
        <div class="logo-wrap">
            <h1 class="logo"><a href="#"><img src="../../asset/img/admin/logo-admin-w.svg" alt="admin-logo"></a></h1>
        </div>
        <div class="nav-btn-wrap">
            <button type="button" class="nav-btn nav-close-btn" aria-label="닫기"><img src="../../asset/img/admin/icon-nav-close-w.svg" alt="admin-logo"></button>
            <button type="button" class="nav-btn nav-open-btn" aria-label="열기"><img src="../../asset/img/admin/icon-nav-open-w.svg" alt="admin-logo"></button>
        </div>
    </div>
    <div class="bottom">
        <div class="main-menu-area">
            <nav class="main-menu">
                <ul class="menu-list">
                    <li class="menu menu01 home"><a href="#none"><span>홈</span></a></li>
                    <li class="menu menu02"><a href="#none"><span>기본설정</span></a></li>
                    <li class="menu menu03"><a href="#none"><span>사이트관리</span></a></li>
                    <li class="menu menu04"><a href="#none"><span>상품관리</span></a></li>
                    <li class="menu menu05"><a href="#none"><span>주문/배송관리</span></a></li>
                    <li class="menu menu06"><a href="#none"><span>회원관리</span></a></li>
                    <li class="menu menu07"><a href="#none"><span>프로모션관리</span></a></li>
                    <li class="menu menu08"><a href="#none"><span>부가서비스</span></a></li>
                    <li class="menu menu09"><a href="#none"><span>마케팅</span></a></li>
                    <li class="menu menu10"><a href="#none"><span>통계</span></a></li>
                </ul>
            </nav>
        </div>
        <div class="sub-menu-area">
            <nav class="sub-menu sub-menu01"></nav>
            <nav class="sub-menu sub-menu02">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>기본 설정</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>기본 설정01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>기본 설정02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>기본 설정03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>기본 설정04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>기본 설정05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>기본 설정06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu03">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>사이트 관리</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>사이트 관리01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>사이트 관리02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>사이트 관리03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>사이트 관리04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>사이트 관리05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>사이트 관리06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu04">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>상품 관리</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>상품 관리01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>상품 관리02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>상품 관리03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>상품 관리04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>상품 관리05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>상품 관리06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu05">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>주문/배송 관리</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>주문/배송 관리01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>주문/배송 관리02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>주문/배송 관리03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>주문/배송 관리04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>주문/배송 관리05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>주문/배송 관리06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu06">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>회원 관리</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="/member/main"><span>회원 조회</span></a>
<%--                        <ul class="menu-3depth">--%>
<%--                            <li><a href="#none"><span>sub-menu</span></a></li>--%>
<%--                            <li><a href="#none"><span>sub-menu</span></a></li>--%>
<%--                            <li><a href="#none"><span>sub-menu</span></a></li>--%>
<%--                            <li><a href="#none"><span>sub-menu</span></a></li>--%>
<%--                        </ul>--%>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu07">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>프로모션 관리</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>프로모션 관리01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>프로모션 관리02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>프로모션 관리03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>프로모션 관리04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>프로모션 관리05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>프로모션 관리06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu07">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>부가서비스</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>부가서비스01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>부가서비스02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>부가서비스03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>부가서비스04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>부가서비스05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>부가서비스06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu07">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>마케팅</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>마케팅01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>마케팅02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>마케팅03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>마케팅04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>마케팅05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>마케팅06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <nav class="sub-menu sub-menu07">
                <div class="sub-menu-title">
                    <a href="#none"><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"><span>통계</span></a>
                </div>
                <ul class="menu-list">
                    <li class="menu menu01"><a href="#none"><span>통계01</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu02"><a href="#none"><span>통계02</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu03"><a href="#none"><span>통계03</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu04"><a href="#none"><span>통계04</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu05"><a href="#none"><span>통계05</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                    <li class="menu menu06"><a href="#none"><span>통계06</span><img src="../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                        <ul class="menu-3depth">
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                            <li><a href="#none"><span>sub-menu</span></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<script>
    // bubble
    $(".bubble-btn").click(function () {
        $(this).toggleClass('on');
        $(this).next('.bubble-box').toggleClass('on');
    });
    $(document).mouseup(function (e) {
        if ($(".bubble-box, .bubble-btn.on").has(e.target).length === 0) {
            $(".bubble-btn").removeClass('on');
            $(".bubble-box").removeClass('on');
        }
    });

    // Nav slide
    $(".nav .top .nav-btn-wrap .nav-close-btn").click(function () {
        $('#container').addClass('navHidden');
        $('.sub-menu-area').fadeOut(200);
        $('#container').animate({paddingLeft: "56px"}, 400 );
    });
    $(".nav .top .nav-btn-wrap .nav-open-btn").click(function () {
        $('#container').removeClass('navHidden');
        $('.sub-menu-area').fadeIn(300);
        $('#container').animate({paddingLeft: "256px"}, 400 );
    });

    // menu
    $('.main-menu .menu:not(.home) a').click(function () {
        $(this).addClass('active').parent().siblings().children().removeClass('active');
        number = $(this).parent().index();
        $('.sub-menu').eq(number).show().animate({marginLeft: "0"}, 300 ).addClass('on').siblings().hide().css({marginLeft: "0"}).removeClass('on');
    });
    $('.sub-menu-title > a').click(function () {
        $(this).parent().parent().animate({marginLeft: "200px"}, 300 ).removeClass('on').siblings().css({marginLeft: "200px"});
        $('.main-menu .menu a').removeClass('active');
    });
    $('.main-menu .menu.home a').click(function () {
        $('.sub-menu').animate({marginLeft: "200px"}, 300 ).removeClass('on');
    });
    // $(document).on('mouseenter', '.nav .bottom', function(){
    //     if($('#container').hasClass('navHidden')){
    //         $('#container').addClass('over');
    //     };
    // });
    // $(document).on('mouseleave', '.nav .bottom', function(){
    //     if($('#container').hasClass('navHidden')){
    //         $('#container').removeClass('over');
    //     }
    // });

    // menu 3depth
    var accordion_nav = $('.sub-menu .menu > a'), accordion_nav_con = $('.menu-3depth');
    accordion_nav.on('click', function (e) {
        accordion_nav.removeClass('active');
        accordion_nav_con.slideUp('normal');
        if ($(this).next().is(':hidden') == true) {
            $(this).addClass('active');
            $(this).next().slideDown('normal');
        }
    });
</script>