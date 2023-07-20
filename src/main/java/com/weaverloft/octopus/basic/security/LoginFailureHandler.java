package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.admin.service.AdminService;
import com.weaverloft.octopus.basic.admin.vo.AdminVo;
import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component(value = "authenticationFailureHandler")
public class LoginFailureHandler implements AuthenticationFailureHandler {

    @Autowired
    private CommonService commonService;

    @Autowired
    private AdminService adminService;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String errMsg = e.getMessage();
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("password");

        AdminVo adminVo = new AdminVo();
        adminVo.setAdminId(userId);

        AdminVo loginMember = new AdminVo();
        loginMember = adminService.getAdminRole(adminVo);

        if(loginMember != null) {
            if(!passwordEncoder.matches(userPw, loginMember.getAdminPw())){
                errMsg = "비밀번호가 맞지 않습니다. 다시 확인해주세요.";
            }
        }

        System.out.println("로그인실패 : " + errMsg);

        if(loginMember != null) {
            Map<String, Object> logMap = new HashMap<>();
            logMap.put("adminLoginId", loginMember.getAdminId());
            logMap.put("adminLoginIp", request.getRemoteAddr());
            logMap.put("isSuccess", false);

            commonService.insertAdminLoginLog(logMap);
        }

        HttpSession session = request.getSession();
        session.setAttribute("msg", errMsg);

        response.sendRedirect("/main/login-form?error=1");
    }
}
