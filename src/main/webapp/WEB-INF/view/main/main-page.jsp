<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!--========== CONTENTS ==========-->
<main id="main" class="page-home-admin">
    <div class="admin-section-wrap">
        <div class="home-section-wrap">
            <div class="left-sec-wrap">
                <!-- notice-sec -->
                <section class="section home-sec notice-sec">
                    <h2 class="sec-title">Notice</h2>
                    <input type="hidden" id="noticeOffsetNum" value="${noticeMap['offsetNum']}">
                    <ul class="notice-list">
                        <li class="new">
                            <a href="/notice/detail?seq=${noticeMap['notice_seq']}">
                                <p>${noticeMap['notice_title']}
                                    <fmt:parseNumber var="diff_days" value="${noticeMap['diff_days']}" type="number"/>
                                    <c:if test="${diff_days <= 7}">
                                        <span class="new">new</span>
                                    </c:if>
                                </p>
                                <span class="date">${noticeMap['reg_dt_str']}</span>
                            </a>
                        </li>
                        <%--<li class="new"><a href="#none"><p>4월 30일 부로 리페어로션 단종 처리 됩니다. <span class="new">new</span></p><span class="date">2023.05.12</span></a></li>
                        <li class="mid-line"></li>
                        <li><a href="#none"><span>리페어로션 단종 처리 됩니다.</span><span class="date">2023.05.14</span></a></li>--%>
                    </ul>
                    <div class="btn-wrap">
                        <button type="button" aria-label="이전 공지사항" class="btn prev" onclick="selectNoticeDetail('prev')"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 공지사항"></button>
                        <span class="mid-line"></span>
                        <button type="button" aria-label="다음 공지사항" class="btn next" onclick="selectNoticeDetail('next')"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 공지사항"></button>
                    </div>
                </section>

                <!-- sales-sec -->
                <section class="section home-sec sales-sec mo">
                    <div class="today">
                        <figure class="today-sales-img">
                            <img src="/asset/img/admin/icon-calendar-w.svg" alt="달력">
                        </figure>
                        <div class="title">
                            <p class="tit">오늘의 매출</p><p class="date">05.12 금요일</p>
                        </div>
                    </div>
                    <div class="sales">1,897,400<span>원</span></div>
                    <div class="total-sales"><div class="compared up">전날 대비 3% <span>3%</span></div><p>당월 누적 매출</p></div>
                </section>

                <div class="half-sec-wrap">
                    <!-- order-sec -->
                    <section class="section home-sec situation-sec order-sec">
                        <div class="sec-title-wrap">
                            <h2 class="sec-title">주문</h2>
                            <ul class="tab-menu view-tab-menu">
                                <li class="tab-link current" data-tab="tab-order-day"><a href="javascript:void(0);" onclick="dayOrderBtn(0);"><span>일 D</span></a></li>
                                <li class="tab-link" data-tab="tab-order-week"><a href="javascript:void(0);" onclick="weekOrderBtn(0);"><span>주 W</span></a></li>
                                <li class="tab-link" data-tab="tab-order-month"><a href="javascript:void(0);" onclick="monthOrderBtn(0);"><span>월 M</span></a></li>
                            </ul>
                        </div>
                        <div class="tab-container">
                            <div class="tab-content-wrap situation-content-wrap order">
                                <div id="tab-order-day" class="tab-content current">
                                    <div class="situation-content order">
                                        <div class="situation-con">
                                            <div class="date-wrap">
                                                <button type="button" aria-label="이전" class="btn prev" onclick="dayOrderBtn(-1);"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 날"></button>
                                                <p class="date" id="dayOrderText">${orderCountMap['now']}</p>
                                                <button type="button" aria-label="다음" class="btn next" onclick="dayOrderBtn(1);"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 날"></button>
                                            </div>
                                            <div class="total"><p style="display: inline-block; cursor:pointer;" onclick="goToOrderList('day')" id="dayOrderTotal">${orderCountMap['curr_count']} <span>건</span></p></div>
                                            <div class="compared <c:choose><c:when test="${orderCountMap['compare'] > 0}">up</c:when><c:otherwise>down</c:otherwise></c:choose>" id="dayOrderCompared">전날 대비 <fmt:formatNumber value="${orderCountMap['compare'] < 0 ? -orderCountMap['compare'] : orderCountMap['compare']}" pattern="#,###" />건 <c:choose><c:when test="${orderCountMap['compare'] > 0}">많음</c:when><c:otherwise>적음</c:otherwise></c:choose> <span>3%</span></div>
                                        </div>
                                        <div class="situation-info">
                                            <div><p class="tit">신규 주문</p><p class="num">400<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">결제 완료</p><p class="num">20<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">입금 대기</p><p class="num">3<span>건</span></p></div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-order-week" class="tab-content">
                                    <div class="situation-content order">
                                        <div class="situation-con">
                                            <div class="date-wrap">
                                                <button type="button" aria-label="이전" class="btn prev" onclick="weekOrderBtn(-7);"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 주"></button>
                                                <p class="date" id="weekOrderText">23.05.12 ~ 23.05.18</p>
                                                <button type="button" aria-label="다음" class="btn next" onclick="weekOrderBtn(7);"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 주"></button>
                                            </div>
                                            <div class="total"><p style="display: inline-block; cursor:pointer;" onclick="goToOrderList('week')" id="weekOrderTotal">0 <span>건</span></p></div>
                                            <div class="compared up" id="weekOrderCompared">전날 대비 00건 많음 <span>3%</span></div>
                                        </div>
                                        <div class="situation-info">
                                            <div><p class="tit">신규 주문</p><p class="num">724<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">결제 완료</p><p class="num">56<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">입금 대기</p><p class="num">6<span>건</span></p></div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-order-month" class="tab-content">
                                    <div class="situation-content order">
                                        <div class="situation-con">
                                            <div class="date-wrap">
                                                <button type="button" aria-label="이전" class="btn prev" onclick="monthOrderBtn(-1);"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 월"></button>
                                                <p class="date" id="monthOrderText">2023.05</p>
                                                <button type="button" aria-label="다음" class="btn next" onclick="monthOrderBtn(1);"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 월"></button>
                                            </div>
                                            <div class="total"><p style="display: inline-block; cursor:pointer;" onclick="goToOrderList('month')" id="monthOrderTotal">2,950 <span>건</span></p></div>
                                            <div class="compared up" id="monthOrderCompared">전날 대비 00건 많음 <span>3%</span></div>
                                        </div>
                                        <div class="situation-info">
                                            <div><p class="tit">신규 주문</p><p class="num">1050<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">결제 완료</p><p class="num">90<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">입금 대기</p><p class="num">2<span>건</span></p></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- delivery-sec -->
                    <section class="section home-sec situation-sec delivery-sec">
                        <div class="sec-title-wrap">
                            <h2 class="sec-title">배송</h2>
                            <ul class="tab-menu view-tab-menu">
                                <li class="tab-link current" data-tab="tab-delivery-day"><a href="javascript:;"><span>일 D</span></a></li>
                                <li class="tab-link" data-tab="tab-delivery-week"><a href="javascript:;"><span>주 W</span></a></li>
                                <li class="tab-link" data-tab="tab-delivery-month"><a href="javascript:;"><span>월 M</span></a></li>
                            </ul>
                        </div>
                        <div class="tab-container">
                            <div class="tab-content-wrap situation-content-wrap delivery">
                                <div id="tab-delivery-day" class="tab-content current">
                                    <div class="situation-content delivery">
                                        <div class="situation-con">
                                            <div class="date-wrap">
                                                <button type="button" aria-label="이전" class="btn prev"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 날"></button>
                                                <p class="date">23.05.12</p>
                                                <button type="button" aria-label="다음" class="btn next"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 날"></button>
                                            </div>
                                            <div class="total">1,897 <span>건</span></div>
                                            <div class="compared down">전날 대비 00건 적음 <span>3%</span></div>
                                        </div>
                                        <div class="situation-info">
                                            <div><p class="tit">상품 준비</p><p class="num">400<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">배송중</p><p class="num">20<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">배송 지연</p><p class="num">3<span>건</span></p></div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-delivery-week" class="tab-content">
                                    <div class="situation-content delivery">
                                        <div class="situation-con">
                                            <div class="date-wrap">
                                                <button type="button" aria-label="이전" class="btn prev"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 주"></button>
                                                <p class="date">23.05.12 ~ 23.05.18</p>
                                                <button type="button" aria-label="다음" class="btn next"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 주"></button>
                                            </div>
                                            <div class="total">2,245 <span>건</span></div>
                                            <div class="compared down">전날 대비 00건 적음 <span>3%</span></div>
                                        </div>
                                        <div class="situation-info">
                                            <div><p class="tit">상품 준비</p><p class="num">724<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">배송중</p><p class="num">56<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">배송 지연</p><p class="num">6<span>건</span></p></div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-delivery-month" class="tab-content">
                                    <div class="situation-content delivery">
                                        <div class="situation-con">
                                            <div class="date-wrap">
                                                <button type="button" aria-label="이전" class="btn prev"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 월"></button>
                                                <p class="date">2023.05</p>
                                                <button type="button" aria-label="다음" class="btn next"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 월"></button>
                                            </div>
                                            <div class="total">2,950 <span>건</span></div>
                                            <div class="compared down">전날 대비 00건 적음 <span>3%</span></div>
                                        </div>
                                        <div class="situation-info">
                                            <div><p class="tit">상품 준비</p><p class="num">1050<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">배송중</p><p class="num">90<span>건</span></p></div>
                                            <span class="mid-line"></span>
                                            <div><p class="tit">배송 지연</p><p class="num">2<span>건</span></p></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- case-num-sec -->
                <section class="section home-sec case-num-sec">
                    <h2 class="hidden">세금계산서, 문의 건수 확인</h2>
                    <div class="tax-invoice-cont">
                        <div>
                            <figure class="case-num-img">
                                <img src="/asset/img/admin/icon-tax-invoice.svg" alt="세금계산서 아이콘">
                            </figure>
                            <p class="case-num-txt">세금계산서 신청</p>
                        </div>
                        <div class="case-num">3<span>건</span></div>
                    </div>
                    <span class="mid-line"></span>
                    <div class="inquiry-cont">
                        <div>
                            <figure class="case-num-img">
                                <img src="/asset/img/admin/icon-prd-inquiry.svg" alt="상품 문의 아이콘">
                            </figure>
                            <p class="case-num-txt">상품 문의</p>
                        </div>
                        <div class="case-num">160<span>건</span></div>
                    </div>
                    <span class="mid-line"></span>
                    <div class="inquiry-cont">
                        <div>
                            <figure class="case-num-img">
                                <img src="/asset/img/admin/icon-inquiry.svg" alt="1:1 문의 아이콘">
                            </figure>
                            <p class="case-num-txt">1:1 문의</p>
                        </div>
                        <div class="case-num">110<span>건</span></div>
                    </div>
                </section>

                <!-- review-sec -->
                <section class="section home-sec review-sec">
                    <div class="sec-title-wrap">
                        <h2 class="sec-title">상품 리뷰</h2>
                        <div class="select-box-wrap nowrap">
                            <div class="basic-select-box highest-star">
                                <select id="orderType" name="orderType">
                                    <option value="regDt_DESC">등록일순</option>
                                    <option value="starPoint_DESC">별점 높은순</option>
                                    <option value="starPoint_ASC">별점 낮은순</option>
                                    <option value="likeCount_DESC">추천 높은순</option>
                                    <option value="likeCount_ASC">추천 낮은순</option>
                                </select>
                                <span class="border-focus"><i></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="review-content-wrap">
                        <div class="review-info">
                            <div class="new"><p class="tit">신규등록</p><span class="num" style="cursor: pointer;" onclick="goToTodayReview();">${reviewCountMap['todayCount']}건</span></div>
                            <span class="mid-line"></span>
                            <div class="total"><p class="tit">총 누적건수</p><span class="num"><a href="/product/review/main">${reviewCountMap['totalCount']}건</a></span></div>
                        </div>
                        <div class="review-list-wrap">
                            <div class="swiper review-list">
                                <div id="reviewDiv" class="swiper-wrapper review-wrapper">
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product01.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요. 이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star three"></div><span class="rating">3.5</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product02.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star four"></div><span class="rating">4</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product03.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요. 이 문어는 정말 싱싱합니다.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star three"></div><span class="rating">3</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product04.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star five"></div><span class="rating">5</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product01.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요. 이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star three"></div><span class="rating">3</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product02.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요. </p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star four"></div><span class="rating">4.5</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product03.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star three"></div><span class="rating">3.5</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product04.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요. 이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star five"></div><span class="rating">5</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide review-content skeleton-box">
                                        <div class="skeleton-loading"></div>
                                        <figure class="review-prd-img">
                                            <img src="/asset/img/temp/temp-product03.jpg" alt="자연산 돌문어">
                                        </figure>
                                        <div class="review-prd-con">
                                            <p class="prd-tit">자연산 돌문어 2kg</p>
                                            <p class="review-txt">이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요. 이 문어는 정말 싱싱합니다. 자연산 돌문어라 아주 쫄깃쫄깃하고 맛이 좋아요.</p>
                                            <div class="star-wrap review-star">
                                                <div class="star-box">
                                                    <div class="star three"></div><span class="rating">3.5</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-pagination review-pagination"></div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- main-chart-sec -->
                <section class="section home-sec main-chart-sec pc">
                    <div class="sec-title-wrap">
                        <h2 class="sec-title">통계</h2>
                        <ul class="tab-menu chart-tab-menu">
                            <li class="slider"></li>
                            <li class="tab-link current" data-tab="chart-order"><a href="javascript:;"><span>주문</span></a></li>
                            <li class="tab-link" data-tab="chart-sales"><a href="javascript:;" id="salesStat"><span>매출</span></a></li>
                            <li class="tab-link" data-tab="chart-member"><a href="javascript:;"><span>회원</span></a></li>
                            <li class="tab-link" data-tab="chart-visit"><a href="javascript:;"><span>방문</span></a></li>
                        </ul>
                    </div>
                    <div class="main-chart-content-wrap">
                        <div class="main-chart-menu">
                            <ul class="main-chart-menu-list">
                                <li class="menu menu01"><a href="#none" class="active"><span>베스트셀러</span><img src="/asset/img/admin/icon-arrow-down-p.svg" alt="down-arrow"></a>
                                    <ul class="sub-menu" style="display: block;">
                                        <li><a href="#none" class="on"><span>카테고리A</span></a></li>
                                        <li><a href="#none"><span>카테고리B</span></a></li>
                                        <li><a href="#none"><span>카테고리C</span></a></li>
                                        <li><a href="#none"><span>카테고리D</span></a></li>
                                    </ul>
                                </li>
                                <li class="menu menu02"><a href="#none"><span>신규 상품</span><img src="/asset/img/admin/icon-arrow-down-p.svg" alt="down-arrow"></a>
                                    <ul class="sub-menu">
                                        <li><a href="#none"><span>카테고리A</span></a></li>
                                        <li><a href="#none"><span>카테고리B</span></a></li>
                                        <li><a href="#none"><span>카테고리C</span></a></li>
                                        <li><a href="#none"><span>카테고리D</span></a></li>
                                        <li><a href="#none"><span>카테고리E</span></a></li>
                                    </ul>
                                </li>
                                <li class="menu menu03"><a href="#none"><span>추천 상품</span><img src="/asset/img/admin/icon-arrow-down-p.svg" alt="down-arrow"></a>
                                    <ul class="sub-menu">
                                        <li><a href="#none"><span>카테고리A</span></a></li>
                                        <li><a href="#none"><span>카테고리B</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-container main-chart-container">
                            <div class="tab-content-wrap">
                                <div id="chart-order" class="tab-content main-chart-content chart-order current">
                                    <div id="chart-order-table01" style="width: 100%; height: 40vh;">
                                        <canvas id="orderChart"></canvas>
                                    </div>
                                </div>
                                <div id="chart-sales" class="tab-content main-chart-content chart-sales">
                                    <div id="chart-sales-table01" style="width: 100%; height: 40vh;">
                                        <canvas id="salesChart"></canvas>
                                    </div>
                                </div>
                                <div id="chart-member" class="tab-content main-chart-content chart-member">
                                    <div id="chart-member-table01" style="width: 100%; height: 40vh;">
                                    </div>
                                </div>
                                <div id="chart-visit" class="tab-content main-chart-content chart-visit">
                                    <div id="chart-visit-table01" style="width: 100%; height: 40vh;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <div class="right-sec-wrap">
                <!-- goto-product-sec -->
                <section class="section home-sec goto-product-sec pc">
                    <ul class="goto-product">
                        <li><a href="/product/management/list"><span>상품전시관리</span><span class="goto-btn"></span></a></li>
                        <li class="mid-line"></li>
                        <li><a href="/product/management/detail"><span>상품 등록</span><span class="goto-btn"></span></a></li>
                    </ul>
                </section>

                <!-- sales-sec -->
                <section class="section home-sec sales-sec pc">
                    <div class="today">
                        <figure class="today-sales-img">
                            <img src="/asset/img/admin/icon-calendar-w.svg" alt="달력">
                        </figure>
                        <div class="title">
                            <p class="tit">오늘의 매출</p><p class="date">05.12 금요일</p>
                        </div>
                    </div>
                    <div class="sales">1,897,400<span>원</span></div>
                    <div class="total-sales"><div class="compared up">전날 대비 3% <span>3%</span></div><p>당월 누적 매출</p></div>
                </section>

                <!-- inventory-sec -->
                <section class="section home-sec inventory-sec pc">
                    <div class="sec-title-wrap">
                        <h2 class="sec-title">재고관리</h2>
                        <button type="button" aria-label="옵션보기" class="option-view-btn"><img src="/asset/img/admin/icon-more-opt.svg" alt="옵션보기"></button>
                    </div>
                    <div class="inventory-contents">
                        <div class="restock-req">
                            <strong class="inventory-tit">재입고 요청</strong>
                            <div class="inventory-con">
                                <figure class="inventory-img">
                                    <img src="/asset/img/temp/temp-product01.jpg" alt="리페어 크림리페어 크림">
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
                                    <img src="/asset/img/temp/temp-product02.jpg" alt="리페어 크림리페어 크림">
                                </figure>
                                <ul class="inventory-detail">
                                    <li><span class="sub-tit"><i>상</i><i>품</i><i>명</i></span><p>리페어 크림리페어 크림</p></li>
                                    <li><span class="sub-tit"><i>재</i><i>고</i></span><p>4건</p></li>
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
                                <button type="button" aria-label="이전 달" class="btn prev-month"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 달"></button>
                                <button type="button" aria-label="다음 달" class="btn next-month"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 달"></button>
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
                                <button type="button" aria-label="일정 등록" class="schedule-add-btn">등록</button>
                            </div>
                        </div>
                        <ul class="schedule">
                            <li>
                                <span class="date">05.12</span>
                                <p class="detail">룰렛 이벤트 종료</p>
                                <button type="button" aria-label="옵션보기" class="option-view-btn"><img src="/asset/img/admin/icon-more-opt.svg" alt="옵션보기"></button>
                            </li>
                            <li>
                                <span class="date">05.12</span>
                                <p class="detail">출석체크 이벤트</p>
                                <button type="button" aria-label="옵션보기" class="option-view-btn"><img src="/asset/img/admin/icon-more-opt.svg" alt="옵션보기"></button>
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
                                <div class="swiper-button-prev"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 이벤트"></div>
                                <div class="swiper-button-next"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 이벤트"></div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper event-swiper">
                        <div class="swiper-wrapper event-slide-wrapper">
                            <div class="swiper-slide event-slide">
                                <div class="event-content-wrap skeleton-box">
                                    <div class="skeleton-loading"></div>
                                    <figure class="event-img">
                                        <span class="state ing">진행중</span>
                                        <img src="/asset/img/temp/temp-event01.jpg" alt="이벤트 이미지">
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
                                <div class="event-content-wrap skeleton-box">
                                    <div class="skeleton-loading"></div>
                                    <figure class="event-img">
                                        <span class="state ing">진행중</span>
                                        <img src="/asset/img/temp/temp-event02.jpg" alt="이벤트 이미지">
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
                                <div class="event-content-wrap skeleton-box">
                                    <div class="skeleton-loading"></div>
                                    <figure class="event-img">
                                        <span class="state end">종료</span>
                                        <img src="/asset/img/temp/temp-event01.jpg" alt="이벤트 이미지">
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
                                <div class="event-content-wrap skeleton-box">
                                    <div class="skeleton-loading"></div>
                                    <figure class="event-img">
                                        <span class="state end">종료</span>
                                        <img src="/asset/img/temp/temp-event02.jpg" alt="이벤트 이미지">
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
<script src="/asset/js/basic.js"></script>
<script src="/asset/js/basic_admin.js"></script>
<script>
    let currDates;
    let nowDay = new Date();
    let nowMonth = new Date();

    Date.prototype.getWeek = function(start) {
        //Calcing the starting point
        start = start || 0;

        var startDay = new Date(this.setHours(0, 0, 0, 0));
        var endDay = new Date(this.setHours(0, 0, 0, 0));
        var day = startDay.getDay() - start;
        var date = startDay.getDate() - day;

        // Grabbing Start/End Dates
        var StartDate = new Date(startDay.setDate(date + 1));
        var EndDate = new Date(endDay.setDate(date + 7));

        return [StartDate, EndDate];
    }

    // 일간 주문 수
    function dayOrderBtn(start) {
        if(start == 0) {
            nowDay = new Date();
        } else {
            nowDay.setDate(nowDay.getDate() + start);
        }
        $("#dayOrderText").text(toStringByFormatting(nowDay, '.').substr(2));
        selectOrderCount(nowDay, 'day');
    }

    // 주간 주문 수
    function weekOrderBtn(start) {
        if(start == 0) {
            currDates = new Date().getWeek();
        } else {
            currDates = currDates[0].getWeek(start);
        }
        $("#weekOrderText").text(toStringByFormatting(currDates[0], '.').substr(2) + '~' + toStringByFormatting(currDates[1], '.').substr(2));
        selectOrderCount(currDates, 'week');
    }

    // 월간 주문 수
    function monthOrderBtn(start) {
        if(start == 0) {
            nowMonth = new Date();
        } else {
            nowMonth.setMonth(nowMonth.getMonth() + start);
        }
        $("#monthOrderText").text(toStringByFormatting(nowMonth, '.').slice(0, -3));
        selectOrderCount(nowMonth, 'month');
    }

    function selectOrderCount(dates, type) {
        let params = {};

        if(type == 'week') {
            params = {
                'startDate' : toStringByFormatting(dates[0]),
                'endDate' : toStringByFormatting(dates[1]),
                'searchType' : type
            };
        } else if(type == 'day' || type == 'month') {
            params = {
                'startDate' : toStringByFormatting(dates),
                'endDate' : toStringByFormatting(dates),
                'searchType' : type
            };
        }

        $.ajax({
            type : "POST",
            url : "/order/select-order-count",
            dataType:"json",
            contentType : 'application/json; charset=utf-8',
            data : JSON.stringify(params),
            success : function(data){
                let compare = data.compare;

                orderConfig.datasets[0].data = data.orderList;
                orderConfig.datasets[1].data = data.salesPriceList;
                orderChart.update();

                $("#" + type + "OrderTotal").html(data.curr_count.toLocaleString('ko-KR') + ' <span>건</span>');
                if(compare > 0) {
                    $("#" + type + "OrderCompared").attr('class', 'compared up');
                    $("#" + type + "OrderCompared").html('전날 대비 ' + compare.toLocaleString('ko-KR') + '건 많음 <span>3%</span>');
                } else {
                    $("#" + type + "OrderCompared").attr('class', 'compared down');
                    $("#" + type + "OrderCompared").html('전날 대비 ' + Math.abs(compare).toLocaleString('ko-KR') + '건 적음 <span>3%</span>');
                }
            }
        });
    }

    function selectReviewList(orderType, sort) {
        let params = {
            orderType : orderType,
            sort : sort
        };

        $.ajax({
            type : "POST",
            url : "/product/review/select-review-count",
            dataType:"json",
            contentType : 'application/json; charset=utf-8',
            data : JSON.stringify(params),
            success : function(data){
                let html = '';
                let reviewList = data.reviewList;

                // 초기화
                $("#reviewDiv").empty();

                if(reviewList.length <= 0) {
                    html += '<p>금일 등록된 리뷰가 없습니다.</p>';
                } else {
                    reviewList.forEach(function(review) {
                        let star = Math.floor(review.starPoint);
                        let starClass = '';

                        switch (star) {
                            case 5:
                                starClass = 'five';
                                break;
                            case 4:
                                starClass = 'four';
                                break;
                            case 3:
                                starClass = 'three';
                                break;
                            case 2:
                                starClass = 'two';
                                break;
                            case 1:
                                starClass = 'one';
                                break;
                        }

                        html += '<div class="swiper-slide review-content skeleton-box">';
                        html +=     '<div class="skeleton-loading"></div>';
                        html +=     '<a href="/product/review/review-detail?reviewSeq=' + review.reviewSeq + '">'
                        html +=     '<figure class="review-prd-img">';
                        if(review.reviewImagePath) {
                            html +=     '<img src="../../asset/upload/img' + review.reviewImagePath + '" alt="리뷰이미지">';
                        } else {
                            html +=     '<img style="background-color: #f3f3f9;" src="/asset/img/temp.png" alt="리뷰이미지">';
                        }
                        html +=     '</figure>';
                        html +=     '</a>';
                        html +=     '<div class="review-prd-con">';
                        html +=         '<p class="prd-tit">' + review.productName + '</p>';
                        html +=         '<p class="review-txt">' + review.reviewContent + '</p>';
                        html +=         '<div class="star-wrap review-star">';
                        html +=             '<div class="star-box">';
                        html +=                 '<div class="star ' + starClass + '"></div><span class="rating">' + review.starPoint + '</span>';
                        html +=                 '<div style="width: 15px; height: 15px; margin-left: 10px; background-image: url(\'../../asset/img/icon-tumb.svg\');"></div><span class="rating">' + review.likeCount + '</span>';
                        html +=             '</div>';
                        html +=         '</div>';
                        html +=     '</div>';
                        html += '</div>';
                    });
                }

                $("#reviewDiv").html(html);
            },
            complete : function(xhr, status) {
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
                reviewSwiper.update();

                const skeletonBox = document.querySelectorAll('.skeleton-box');
                const skeletonImgBox = document.querySelectorAll('.skeleton-img-box');
                const skeletonItem = document.querySelectorAll('.skeleton-loading');

                const hideSkeleton = () => {
                    skeletonItem.forEach(element => {
                        $(element).fadeOut(() => {
                            element.classList.remove('skeleton-loading');
                            skeletonBox.forEach(boxElement => {
                                boxElement.classList.remove('skeleton-box');
                            });
                            skeletonImgBox.forEach(imgElement => {
                                imgElement.classList.remove('skeleton-img-box');
                            });
                        });
                    });
                };
                setTimeout(hideSkeleton, 1000);
            }
        });
    }

    function goToTodayReview() {
        window.location.href = "/product/review/main?startDate=" + toStringByFormatting(new Date()) + "&endDate=" + toStringByFormatting(new Date());
    }

    function goToOrderList(type) {
        if(type == 'week') {
            window.location.href = "/order/main?startDate=" + toStringByFormatting(currDates[0]) + "&endDate=" + toStringByFormatting(currDates[1]);
        } else if(type == 'day') {
            window.location.href = "/order/main?startDate=" + toStringByFormatting(nowDay) + "&endDate=" + toStringByFormatting(nowDay);
        } else if(type == 'month') {
            nowMonth.setDate(1);
            let startDate = toStringByFormatting(nowMonth);
            let endDate = toStringByFormatting(new Date(nowMonth.getFullYear(), (nowMonth.getMonth() + 1), 0));

            window.location.href = "/order/main?startDate=" + startDate + "&endDate=" + endDate;
        }
    }

    function selectNoticeDetail(flag) {
        let offsetNum = Number($('#noticeOffsetNum').val());
        if (flag === 'prev') {
            offsetNum++;
        } else {
            offsetNum--;
        }

        $.ajax({
            type : 'GET',
            url : '/notice/detail-ajax/'+offsetNum,
            dataType:'json',
            success : function(data){

                let obj = $('.notice-list');
                let noticeSeq = data['notice_seq'];
                let noticeTitle = data['notice_title'];
                let regDtStr = data['reg_dt_str'];
                let htmlStr = '<li><a href="/notice/detail?seq='+noticeSeq+'"><p>'+noticeTitle+'</p><span class="date">'+regDtStr+'</span></a></li>';

                obj.empty();
                obj.html(htmlStr);

                if (Number(data['diff_days']) <= 7) {
                    $('.notice-list > li > a > p').append('<span class="new">new</span>');
                }

                $('#noticeOffsetNum').val(data['offsetNum']);
            }
        })
    }

    $(document).ready(function() {
        $("#orderType").change(function() {
            let sortOption = $(this).val().split('_');
            selectReviewList(sortOption[0], sortOption[1]);
        });

        $("#salesStat").click(function() {
            restartAnims(salesChart);
        });

        weekOrderBtn(0);
        monthOrderBtn(0);
        selectReviewList('regDt', 'DESC');
    });

    // 주문 차트 init
    const labels = months({count: new Date().getMonth() + 1});
    const orderConfig = {
        labels: labels,
        datasets: [
            {
                label: '주문',
                // data: numbers(NUMBER_CFG),
                data: [],
                borderColor: CHART_COLORS.blue,
                backgroundColor: transparentize(CHART_COLORS.blue, 0.5),
                borderWidth: 1,
                type: 'line',
                pointStyle: 'circle',
                pointRadius: 5,
                pointHoverRadius: 8,
                order: 0,
                // tension: 0.2,
            },
            {
                label: '매출',
                // data: numbers(NUMBER_CFG),
                data: [],
                borderColor: CHART_COLORS.red,
                backgroundColor: transparentize(CHART_COLORS.red, 0.5),
                order: 1,
                // tension: 0.2,
            }
        ]
    };

    var context = document.getElementById("orderChart");
    var orderChart = new Chart(context, {
        type: 'bar',
        data: orderConfig,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: false,
                    text: '주문 차트'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';

                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                if(label == '매출: ') {
                                    label += new Intl.NumberFormat().format(context.parsed.y * 10000) + '원'
                                } else {
                                    label += Math.floor(context.parsed.y) + '건';
                                }
                            }
                            return label;
                        }
                    }
                },
            },
        },
    });

    // Data-----
    const data = [];
    const data2 = [];
    let prev = 100;
    let prev2 = 80;
    for (let i = 0; i < 365; i++) {
        prev += 5 - Math.random() * 10;
        data.push({x: i, y: prev});
        prev2 += 5 - Math.random() * 10;
        data2.push({x: i, y: prev2});
    }
    // Data-----

    // Animation-----
    const totalDuration = 5000;
    const delayBetweenPoints = totalDuration / data.length;
    const previousY = (ctx) => ctx.index === 0 ? ctx.chart.scales.y.getPixelForValue(100) : ctx.chart.getDatasetMeta(ctx.datasetIndex).data[ctx.index - 1].getProps(['y'], true).y;
    const animation = {
        x: {
            type: 'number',
            easing: 'linear',
            duration: delayBetweenPoints,
            from: NaN, // the point is initially skipped
            delay(ctx) {
                if (ctx.type !== 'data' || ctx.xStarted) {
                    return 0;
                }
                ctx.xStarted = true;
                return ctx.index * delayBetweenPoints;
            }
        },
        y: {
            type: 'number',
            easing: 'linear',
            duration: delayBetweenPoints,
            from: previousY,
            delay(ctx) {
                if (ctx.type !== 'data' || ctx.yStarted) {
                    return 0;
                }
                ctx.yStarted = true;
                return ctx.index * delayBetweenPoints;
            }
        }
    };
    // Animation-----

    // Config-----
    const salesConfig = {
        type: 'line',
        data: {
            datasets: [{
                label: new Date().getFullYear() + '년도',
                borderColor: CHART_COLORS.red,
                backgroundColor: transparentize(CHART_COLORS.red, 0.5),
                borderWidth: 1,
                radius: 0,
                data: data,
            },
                {
                    label: (new Date().getFullYear() - 1) + '년도',
                    borderColor: CHART_COLORS.blue,
                    backgroundColor: transparentize(CHART_COLORS.blue, 0.5),
                    borderWidth: 1,
                    radius: 0,
                    data: data2,
                }]
        },
        options: {
            animation,
            interaction: {
                intersect: false
            },
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: true,
                tooltip: {
                    titleFont: {
                      size: 14
                    },
                    bodyFont: {
                      size: 14
                    },
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';

                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += new Intl.NumberFormat().format(Math.floor(context.parsed.y) * 10000) + '원';

                            }
                            return label;
                        },
                        title: function(context) {
                            var date = new Date();
                            var first = new Date(date.getFullYear(), 0, 1);
                            first.setDate(first.getDate() + parseInt(context[0].label));

                            return toStringByFormatting(first, '.').substring(5, 10);
                        }
                    }
                },
            },
            scales: {
                x: {
                    type: 'linear',
                    min: 0,
                    max: 365,
                    ticks: {
                        stepSize: 30,
                        callback: function(value, index, ticks) {
                            var date = new Date();
                            var first = new Date(date.getFullYear(), 0, 1);
                            first.setDate(first.getDate() + parseInt(value));

                            return toStringByFormatting(first, '.').substring(5, 10)
                        }
                    }
                }
            },
        }
    };
    // Config-----

    var salesChart = new Chart(document.getElementById('salesChart'), salesConfig);

</script>
</body>
</html>
