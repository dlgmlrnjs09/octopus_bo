<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
            $("#dayOrderText").text(nowDay.toLocaleDateString().substr(2).slice(0, -1));
            selectOrderCount(nowDay, 'day');
        }

        // 주간 주문 수
        function weekOrderBtn(start) {
            if(start == 0) {
                currDates = new Date().getWeek();
            } else {
                currDates = currDates[0].getWeek(start);
            }
            $("#weekOrderText").text(currDates[0].toLocaleDateString().substr(2).slice(0, -1) + '~' + currDates[1].toLocaleDateString().substr(2).slice(0, -1));
            selectOrderCount(currDates, 'week');
        }

        // 월간 주문 수
        function monthOrderBtn(start) {
            if(start == 0) {
                nowMonth = new Date();
            } else {
                nowMonth.setMonth(nowMonth.getMonth() + start);
            }
            $("#monthOrderText").text(nowMonth.toLocaleDateString().slice(0, -5));
            selectOrderCount(nowMonth, 'month');
        }

        function selectOrderCount(dates, type) {
            let params = {};

            if(type == 'week') {
                params = {
                    'startDate' : dates[0].getFullYear() + '-' + (dates[0].getMonth()+1) + '-' + dates[0].getDate(),
                    'endDate' : dates[1].getFullYear() + '-' + (dates[1].getMonth()+1) + '-' + dates[1].getDate(),
                    'searchType' : type
                };
            } else if(type == 'day' || type == 'month') {
                params = {
                    'startDate' : dates.getFullYear() + '-' + (dates.getMonth()+1) + '-' + dates.getDate(),
                    'endDate' : dates.getFullYear() + '-' + (dates.getMonth()+1) + '-' + dates.getDate(),
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
                    let compare = data.curr_count - data.prev_count;

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

        $(document).ready(function() {
            weekOrderBtn(0);
            monthOrderBtn(0);
        });
    </script>

<!--========== CONTENTS ==========-->
<main id="main" class="page-home-admin">
    <div class="admin-section-wrap">
        <div class="home-section-wrap">
            <div class="left-sec-wrap">
                <!-- notice-sec -->
                <section class="section home-sec notice-sec">
                    <h2 class="sec-title">Notice</h2>
                    <ul class="notice-list">
                        <li class="new"><a href="#none"><p>4월 30일 부로 리페어로션 단종 처리 됩니다. <span class="new">new</span></p><span class="date">2023.05.12</span></a></li>
                        <li class="mid-line"></li>
                        <li><a href="#none"><span>리페어로션 단종 처리 됩니다.</span><span class="date">2023.05.14</span></a></li>
                    </ul>
                    <div class="btn-wrap">
                        <button type="button" aria-label="이전 공지사항" class="btn prev"><img src="/asset/img/admin/icon-arrow-prev.svg" alt="이전 공지사항"></button>
                        <span class="mid-line"></span>
                        <button type="button" aria-label="다음 공지사항" class="btn next"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 공지사항"></button>
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
                                                <p class="date" id="dayOrderText">${now}</p>
                                                <button type="button" aria-label="다음" class="btn next" onclick="dayOrderBtn(1);"><img src="/asset/img/admin/icon-arrow-next.svg" alt="다음 날"></button>
                                            </div>
                                            <div class="total" id="dayOrderTotal">${curr_count} <span>건</span></div>
                                            <div class="compared <c:choose><c:when test='${compare > 0}'>up</c:when><c:otherwise>down</c:otherwise></c:choose>" id="dayOrderCompared">전날 대비 <fmt:formatNumber value="${compare < 0 ? -compare : compare}" pattern="#,###" />건 <c:choose><c:when test='${compare > 0}'>많음</c:when><c:otherwise>적음</c:otherwise></c:choose> <span>3%</span></div>
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
                                            <div class="total" id="weekOrderTotal">0 <span>건</span></div>
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
                                            <div class="total" id="monthOrderTotal">2,950 <span>건</span></div>
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
                            <div class="basic-select-box by-date">
                                <select>
                                    <option value="등록일순">등록일순</option>
                                    <option value="a">a</option>
                                    <option value="b">b</option>
                                    <option value="c">c</option>
                                    <option value="d">d</option>
                                </select>
                                <span class="border-focus"><i></i></span>
                            </div>
                            <div class="basic-select-box highest-star">
                                <select>
                                    <option value="별점 높은순">별점 높은순</option>
                                    <option value="a">a</option>
                                    <option value="b">b</option>
                                    <option value="c">c</option>
                                    <option value="d">d</option>
                                </select>
                                <span class="border-focus"><i></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="review-content-wrap">
                        <div class="review-info">
                            <div class="new"><p class="tit">신규등록</p><span class="num">20건</span></div>
                            <span class="mid-line"></span>
                            <div class="total"><p class="tit">총 누적건수</p><span class="num">16002건</span></div>
                        </div>
                        <div class="review-list-wrap">
                            <div class="swiper review-list">
                                <div class="swiper-wrapper review-wrapper">
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
                            <li class="tab-link current" data-tab="chart-sales"><a href="javascript:;"><span>매출</span></a></li>
                            <li class="tab-link" data-tab="chart-order"><a href="javascript:;"><span>주문</span></a></li>
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
                                <div id="chart-sales" class="tab-content main-chart-content chart-sales current">
                                    <div id="chart-sales-table01"></div>
                                </div>
                                <div id="chart-order" class="tab-content main-chart-content chart-order">
                                    <div id="chart-order-table01"></div>
                                </div>
                                <div id="chart-member" class="tab-content main-chart-content chart-member">
                                    <div id="chart-member-table01"></div>
                                </div>
                                <div id="chart-visit" class="tab-content main-chart-content chart-visit">
                                    <div id="chart-visit-table01"></div>
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
                        <li><a href="#none"><span>상품전시관리</span><span class="goto-btn"></span></a></li>
                        <li class="mid-line"></li>
                        <li><a href="#none"><span>상품 등록</span><span class="goto-btn"></span></a></li>
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
</body>
</html>
