package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.common.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component(value = "authenticationSuccessHandler")
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private CommonService commonService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        System.out.println("로그인성공");

        Map<String, Object> logMap = new HashMap<>();
        logMap.put("adminLoginId", request.getParameter("userId"));
        logMap.put("adminLoginIp", request.getRemoteAddr());
        logMap.put("isSuccess", true);

        commonService.insertAdminLoginLog(logMap);
        response.sendRedirect("/main/main-page");
    }
}
