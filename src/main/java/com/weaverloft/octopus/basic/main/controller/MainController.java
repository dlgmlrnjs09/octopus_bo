package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.option.notice.service.NoticeService;
import com.weaverloft.octopus.basic.order.service.OrderService;
import com.weaverloft.octopus.basic.product.review.service.ReviewService;
import com.weaverloft.octopus.basic.product.review.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-04-10
 */
@Controller
@RequestMapping("main")
public class MainController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private NoticeService noticeService;

    @GetMapping("/main-page")
    public String showMainPage(Model model) {
        Map<String, Object> orderCountMap =  orderService.selectOrderCountForMainPage(null);
        Map<String, Object> reviewCountMap =  reviewService.selectReviewCountForMainPage(new ReviewVo());
        Map<String, Object> noticeMap = noticeService.selectNoticeForMainPage(0);
        noticeMap.put("offsetNum", 0);

        model.addAttribute("orderCountMap", orderCountMap);
        model.addAttribute("reviewCountMap", reviewCountMap);
        model.addAttribute("noticeMap", noticeMap);
        return "/main/main-page.admin";
    }

    @RequestMapping("/login-form")
    public String loginForm(HttpServletRequest request, MemberVo memberVo) {
        return "/main/login-form.admin";
    }

    @RequestMapping("/login-error")
    public String loginError(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();

        model.addAttribute("msg", session.getAttribute("msg"));
        return "/main/login-error.admin";
    }

    @RequestMapping("/denied")
    public String denied(){
        return "/main/denied.admin";
    }
}