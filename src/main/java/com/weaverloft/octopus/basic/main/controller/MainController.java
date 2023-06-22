package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.main.service.MainService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;

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

    @GetMapping("/main-page")
    public String showMainPage(HttpServletRequest request, HttpServletResponse response) {
        List<String> roleList = Arrays.asList("ADMIN", "MANAGER");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")) {
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            if(user.getUserRole() == null) {
                new SecurityContextLogoutHandler().logout(request, response, authentication);   // 로그인 정보 삭제
                return "/main/denied.admin";
            }
            if(!roleList.contains(user.getUserRole())) {
                new SecurityContextLogoutHandler().logout(request, response, authentication);   // 로그인 정보 삭제
                return "/main/denied.admin";
            }
        }

        return "/main/main-page.admin";
    }

    @RequestMapping("/login-form")
    public String loginform(HttpServletRequest request, MemberVo memberVo) {
        return "/main/login-form.admin";
    }

    @RequestMapping("/login-error")
    public String loginerror(@RequestParam("login_error")String loginError){
        return "/main/login-error.admin";
    }

    @RequestMapping("/denied")
    public String denied(){
        return "/main/denied.admin";
    }
}