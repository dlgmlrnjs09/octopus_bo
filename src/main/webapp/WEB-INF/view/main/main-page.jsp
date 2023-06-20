<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="/WEB-INF/include/common_taglib.jsp" %>--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <script>
        // $(function(){
        //     $('.head-area').load("header.html");
        // });
    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="home-section-wrap">
            <div class="left-sec-wrap">
                <!-- notice-sec -->
                <section class="section home-sec notice-sec">
                    <h2 class="sec-title">Notice</h2>
                    <ul cla ss="notice">
                        <li class="new"><a href="#none"><p>4월 30일 부로 리페어로션 단종 처리 됩니다.</p><span class="date">2023.05.12</a></li>
                        <li class="mid-line"></li>
                        <li><a href="#none"><span>리페어로션 단종 처리 됩니다.</span><span class="date">2023.05.14</a></li>
                    </ul>
                    <div class="btn-wrap">
                        <button type="button" aria-label="이전 공지사항" class="btn prev-month"><img src="../../asset/img/admin/icon-arrow-prev.svg" alt="이전 공지사항"></button>
                        <span class="mid-line"></span>
                        <button type="button" aria-label="다음 공지사항" class="btn next-month"><img src="../../asset/img/admin/icon-arrow-next.svg" alt="다음 공지사항"></button>
                    </div>
                </section>

                <div class="half-sec-wrap">
                    <!-- order-sec -->
                    <section class="section home-sec situation-sec order-sec">
                        <div class="sec-title-wrap">
                            <h2 class="sec-title">주문</h2>
                            <div class="view-btn-wrap">
                                <button type="button" aria-label="일별로 보기" class="btn view-day active">일 D</button>
                                <button type="button" aria-label="주별로 보기" class="btn view-week">주 W</button>
                                <button type="button" aria-label="월별로 보기" class="btn view-month">월 M</button>
                            </div>
                        </div>
                    </section>

                    <!-- delivery-sec -->
                    <section class="section home-sec situation-sec delivery-sec">
                        <div class="sec-title-wrap">
                            <h2 class="sec-title">배송</h2>
                            <div class="btn-wrap">
                                <button type="button" aria-label="일별로 보기" class="btn view-day">일 D</button>
                                <button type="button" aria-label="주별로 보기" class="btn view-week active">주 W</button>
                                <button type="button" aria-label="월별로 보기" class="btn view-month">월 M</button>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <div class="right-sec-wrap">
                <!-- goto-product-sec -->
                <section class="section home-sec goto-product-sec">
                    <ul class="goto-product">
                        <li><a href="#none"><span>상품전시관리</span><span class="goto-btn"></a></li>
                        <li class="mid-line"></li>
                        <li><a href="#none"><span>상품 등록</span><span class="goto-btn"></a></li>
                    </ul>
                </section>

                <!-- sales-sec -->
                <section class="section home-sec sales-sec">

                </section>

                <!-- inventory-sec -->
                <section class="section home-sec inventory-sec">
                    <div class="sec-title-wrap">
                        <h2 class="sec-title">재고관리</h2>
                        <button type="button" aria-label="옵션보기" class="schedule-add-btn"><img src="../../asset/img/admin/icon-more-opt.svg" alt="옵션보기"></button>
                    </div>
                    <div class="inventory-contents">
                        <div class="restock-req">
                            <strong class="inventory-tit">재입고 요청</strong>
                            <div class="inventory-con">
                                <figure class="inventory-img">
                                    <!-- <img src="" alt=""> -->
                                </figure>
                                <ul class="inventory-detail">
                                    <li><span class="sub-tit"><i>상</i><i>품</i><i>명</i></span><p>리페어 크림리페어 크림</p></li>
                                    <li><span class="sub-tit"><i>요</i><i>청</i></span><p>4건</p></li>
                                </ul>
                            </div>
                        </div>
                        <div class="sold-out-soon">
                            <strong class="inventory-tit">품절 임박</strong>
                            <div class="inventory-con">
                                <figure class="inventory-img">
                                    <!-- <img src="" alt=""> -->
                                </figure>
                                <ul class="inventory-detail">
                                    <li><span class="sub-tit"><i>상</i><i>품</i><i>명</i></span><p>리페어 크림리페어 크림</p></li>
                                    <li><span class="sub-tit"><i>요</i><i>청</i></span><p>4건</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- calendar-sec -->
                <section class="section home-sec calendar-sec">
                    <div class="calendar-wrap">
                        <div class="calendar-head">
                            <h2 class="sec-title"><p class="current-date"></p><span class="hidden">주요 일정</span></h2>
                            <div class="month-btn-wrap">
                                <button type="button" aria-label="이전 달" class="btn prev-month"><img src="../../asset/img/admin/icon-arrow-prev.svg" alt="이전 달"></button>
                                <button type="button" aria-label="다음 달" class="btn next-month"><img src="../../asset/img/admin/icon-arrow-next.svg" alt="다음 달"></button>
                            </div>
                        </div>
                        <div class="calendar">
                            <ul class="weeks">
                                <li>S <span class="hidden">일요일</span></li>
                                <li>M <span class="hidden">월요일</span></li>
                                <li>T <span class="hidden">화요일</span></li>
                                <li>W <span class="hidden">수요일</span></li>
                                <li>T <span class="hidden">목요일</span></li>
                                <li>F <span class="hidden">금요일</span></li>
                                <li>S <span class="hidden">토요일</span></li>
                            </ul>
                            <ul class="days"></ul>
                        </div>
                    </div>
                    <div class="schedule-wrap">
                        <div class="schedule-head">
                            <strong class="title">주요 일정</strong>
                            <div class="schedule-add">
                                <button type="button" aria-label="일정 등록" class="schedule-add-btn"><img src="../../asset/img/admin/icon-add-p.svg" alt="일정 등록"> 등록</button>
                            </div>
                        </div>
                        <ul class="schedule">
                            <li>
                                <span class="date">05.12</span>
                                <p class="detail">룰렛 이벤트 종료</p>
                                <button type="button" aria-label="옵션보기" class="schedule-add-btn"><img src="../../asset/img/admin/icon-more-opt.svg" alt="옵션보기"></button>
                            </li>
                            <li>
                                <span class="date">05.12</span>
                                <p class="detail">출석체크 이벤트</p>
                                <button type="button" aria-label="옵션보기" class="schedule-add-btn"><img src="../../asset/img/admin/icon-more-opt.svg" alt="옵션보기"></button>
                            </li>
                        </ul>
                    </div>
                </section>

                <!-- event-sec -->
                <section class="section home-sec event-sec">
                    <div class="sec-title-wrap">
                        <h2 class="sec-title">이벤트</h2>
                        <div class="slide-control">
                            <div class="swiper-pagination"></div>
                            <div class="btn-wrap">
                                <div class="swiper-button-prev"><img src="../../asset/img/admin/icon-arrow-prev.svg" alt="이전 이벤트"></div>
                                <div class="swiper-button-next"><img src="../../asset/img/admin/icon-arrow-next.svg" alt="다음 이벤트"></div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper event-swiper">
                        <div class="swiper-wrapper event-slide-wrapper">
                            <div class="swiper-slide event-slide">
                                <div class="event-content-wrap">
                                    <figure class="event-img">
                                        <span class="state ing">진행중</span>
                                        <img src="../../asset/img/temp/temp-event01.jpg" alt="이벤트 이미지">
                                    </figure>
                                    <strong class="event-tit">2023 룰렛 이벤트</strong>
                                    <ul class="event-content">
                                        <li>
                                            <span class="sub-tit">기간</span><span class="mid-line"></span><p class="detail">23.01.01~23.05.12</p>
                                        </li>
                                        <li>
                                            <span class="sub-tit">참여자수</span><span class="mid-line"></span><p class="detail">34,000명</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="swiper-slide event-slide">
                                <div class="event-content-wrap">
                                    <figure class="event-img">
                                        <span class="state ing">진행중</span>
                                        <img src="../../asset/img/temp/temp-event02.jpg" alt="이벤트 이미지">
                                    </figure>
                                    <strong class="event-tit">출석체크 이벤트</strong>
                                    <ul class="event-content">
                                        <li>
                                            <span class="sub-tit">기간</span><span class="mid-line"></span><p class="detail">23.01.01~23.05.12</p>
                                        </li>
                                        <li>
                                            <span class="sub-tit">참여자수</span><span class="mid-line"></span><p class="detail">34,000명</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="swiper-slide event-slide">
                                <div class="event-content-wrap">
                                    <figure class="event-img">
                                        <span class="state end">종료</span>
                                        <img src="../../asset/img/temp/temp-event01.jpg" alt="이벤트 이미지">
                                    </figure>
                                    <strong class="event-tit">2023 룰렛 이벤트</strong>
                                    <ul class="event-content">
                                        <li>
                                            <span class="sub-tit">기간</span><span class="mid-line"></span><p class="detail">23.01.01~23.05.12</p>
                                        </li>
                                        <li>
                                            <span class="sub-tit">참여자수</span><span class="mid-line"></span><p class="detail">34,000명</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="swiper-slide event-slide">
                                <div class="event-content-wrap">
                                    <figure class="event-img">
                                        <span class="state end">종료</span>
                                        <img src="../../asset/img/temp/temp-event02.jpg" alt="이벤트 이미지">
                                    </figure>
                                    <strong class="event-tit">출석체크 이벤트</strong>
                                    <ul class="event-content">
                                        <li>
                                            <span class="sub-tit">기간</span><span class="mid-line"></span><p class="detail">23.01.01~23.05.12</p>
                                        </li>
                                        <li>
                                            <span class="sub-tit">참여자수</span><span class="mid-line"></span><p class="detail">34,000명</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>
    <!--========== FOOTER ==========-->
    <footer id="footer">
        <div class="copyright">
            &copy; company. ALL RIGHTS RESERVED.
        </div>
    </footer>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
