package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
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
    private MemberService memberService;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
        String errMsg = "";

        System.out.println("로그인실패 : " + e.getMessage());
        if(e instanceof BadCredentialsException){
            errMsg = "아이디 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else {
            errMsg = e.getMessage();
        }

        MemberVo memberVo = new MemberVo();
        memberVo.setMemberId(request.getParameter("userId"));

        MemberVo loginMember = new MemberVo();
        loginMember = memberService.getMemberRole(memberVo);

        if(loginMember != null) {
            Map<String, Object> logMap = new HashMap<>();
            logMap.put("adminLoginId", loginMember.getMemberId());
            logMap.put("adminLoginIp", request.getRemoteAddr());
            logMap.put("isSuccess", false);

            commonService.insertAdminLoginLog(logMap);
        }

        HttpSession session = request.getSession();
        session.setAttribute("msg", errMsg);

        response.sendRedirect("/main/login-error");
    }
}
