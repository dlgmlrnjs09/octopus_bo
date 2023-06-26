package com.weaverloft.octopus.basic.common.interceptor;

import com.weaverloft.octopus.basic.option.menu.service.MenuService;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class AuthInterceptor implements HandlerInterceptor {

    @Autowired
    private MenuService menuService;

    // 세션 체크
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        ModelAndView mav = new ModelAndView();
        List<String> roleList = Arrays.asList("ADMIN", "MANAGER");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        try{
            if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")) {
                CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

                if(user.getUserRole() == null) {
                    new SecurityContextLogoutHandler().logout(request, response, authentication);   // 로그인 정보 삭제

                    mav = new ModelAndView("redirect:/main/denied");
                    throw new ModelAndViewDefiningException(mav);
                }
                if(!roleList.contains(user.getUserRole())) {
                    new SecurityContextLogoutHandler().logout(request, response, authentication);   // 로그인 정보 삭제

                    mav = new ModelAndView("redirect:/main/denied");
                    throw new ModelAndViewDefiningException(mav);
                }

            } else { // 세션이 없으면 로그인 페이지로 이동
                mav = new ModelAndView("redirect:/main/login-form");
                throw new ModelAndViewDefiningException(mav);
            }

            return true;

        } catch (Exception e) {
//            mav.addObject("msg", "세션이 만료되어 로그아웃 되었습니다.");
//            mav.addObject("url", "/");
            throw new ModelAndViewDefiningException(mav);
        }
    }

    // 권한 체크
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        String requestURI = request.getRequestURI();
        ModelAndView mav = new ModelAndView();
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        Map<String, Object> map = new HashMap<>();
        List<String> urlList = new ArrayList<>();
        List<Map<String, Object>> menuList = menuService.getMenuInfo(map);

        for(Map<String, Object> menuMap : menuList) {
            urlList.add((String)menuMap.get("menu_url"));
        }

        try {
            if(urlList.contains(requestURI)) {
                if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")) {
                    CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

                    for(Map<String, Object> menuMap : menuList) {
                        if(menuMap.containsKey("has_authority") && menuMap.containsKey("menu_url")) {
                            if(requestURI.equals((String)menuMap.get("menu_url"))) {
                                String authority = (String) menuMap.get("has_authority");

                                if(authority != null) {
                                    String[] authorityList = authority.toUpperCase().split(",");

                                    if(!Arrays.asList(authorityList).contains(user.getUserRole())) {
                                        mav = new ModelAndView("redirect:/main/denied");
                                        throw new ModelAndViewDefiningException(mav);
                                    }
                                }
                            }
                        }
                    }
                } else { // 세션이 없으면 로그인 페이지로 이동
                    mav = new ModelAndView("redirect:/main/login-form");
                    throw new ModelAndViewDefiningException(mav);
                }
            }
        } catch (Exception e) {
//            ModelAndView mav = new ModelAndView("redirect:/main/main-page");
//            mav.addObject("msgCode", "권한이 없습니다.");
//            mav.addObject("returnUrl", "/main/denied");
            throw new ModelAndViewDefiningException(mav);
        }
    }

}
