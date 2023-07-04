package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.main.service.MainService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.order.service.OrderService;
import com.weaverloft.octopus.basic.order.vo.OrderVo;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
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
    private MainService mainService;

    @Autowired
    private OrderService orderService;

    @GetMapping("/main-page")
    public String showMainPage(Model model) {
        LocalDate currentDate = LocalDate.now();

        OrderVo orderVo = new OrderVo();
        orderVo.setStartDate(currentDate.format(DateTimeFormatter.ISO_DATE));
        orderVo.setEndDate(currentDate.format(DateTimeFormatter.ISO_DATE));
        orderVo.setSearchType("day");

        Map<String, Object> countMap =  orderService.selectOrderCountForMainPage(orderVo);
        int compare = Integer.parseInt(String.valueOf(countMap.get("curr_count"))) - Integer.parseInt(String.valueOf(countMap.get("prev_count")));

        model.addAttribute("now", currentDate.format(DateTimeFormatter.ofPattern("YY. M. dd")));
        model.addAttribute("curr_count", countMap.get("curr_count"));
        model.addAttribute("compare", compare);

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