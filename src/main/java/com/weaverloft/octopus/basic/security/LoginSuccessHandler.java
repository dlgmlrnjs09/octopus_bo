package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.common.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component(value = "authenticationSuccessHandler")
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private CommonService commonService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        System.out.println("로그인성공");

        List<String> roleList = Arrays.asList("ADMIN", "MANAGER");
        String redirectUrl = "/main/main-page";

        Map<String, Object> logMap = new HashMap<>();
        logMap.put("adminLoginId", request.getParameter("userId"));
        logMap.put("adminLoginIp", request.getRemoteAddr());
        logMap.put("isSuccess", true);

        if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")) {
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            if(user.getUserRole() == null || !roleList.contains(user.getUserRole())) {
                logMap.put("isSuccess", false);
                redirectUrl = "/main/denied";
            }
        }

        commonService.insertAdminLoginLog(logMap);
        response.sendRedirect(redirectUrl);
    }
}
