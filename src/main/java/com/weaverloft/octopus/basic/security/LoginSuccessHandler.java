package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.option.role.service.RoleService;
import com.weaverloft.octopus.basic.option.role.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@Component(value = "authenticationSuccessHandler")
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private CommonService commonService;

    @Autowired
    private RoleService roleService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        System.out.println("로그인성공");

        List<String> roleList = new ArrayList<>();
        List<RoleVo> roleVoList = roleService.selectRoleList(new RoleVo());
        for (RoleVo role : roleVoList) {
            roleList.add(role.getRoleId());
        }
        String redirectUrl = "/main/main-page";

        Map<String, Object> logMap = new HashMap<>();
        logMap.put("adminLoginId", request.getParameter("userId"));
        logMap.put("adminLoginIp", request.getRemoteAddr());
        logMap.put("isSuccess", true);

        if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")) {
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            if(user.getUserRole() == null || !roleList.contains(user.getUserRole())) {
                logMap.put("isSuccess", false);

                HttpSession session = request.getSession();
                session.setAttribute("msg", "관리자 페이지에 접근 권한이 없습니다.");

                redirectUrl = "/main/login-form?error=1";
            }
        }

        commonService.insertAdminLoginLog(logMap);
        response.sendRedirect(redirectUrl);
    }
}
