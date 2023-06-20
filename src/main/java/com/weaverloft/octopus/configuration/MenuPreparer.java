package com.weaverloft.octopus.configuration;

import com.weaverloft.octopus.basic.menu.service.MenuService;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuPreparer implements ViewPreparer {

    @Autowired
    private MenuService menuService;

    @Override
    public void execute(Request request, AttributeContext attributeContext) throws PreparerException {
        String roleName = "";
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if(authentication != null) {
            if(!authentication.getPrincipal().equals("anonymousUser")) {
                 CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
                 roleName = user.getUserRole();

                 System.out.println("사용자이름 : " + user.getUserRealName());
                 System.out.println("사용자아이디 : " + user.getUsername());

                 attributeContext.putAttribute("user", new Attribute(user), true);
            } else {
                attributeContext.putAttribute("user", new Attribute(authentication.getPrincipal()), true);
            }
        } else {
            attributeContext.putAttribute("user", new Attribute("anonymousUser"), true);
        }

        Map<String, Object> map = new HashMap<>();
        List<Map<String, Object>> menuList = menuService.getMenuInfo(map);

        // 최대 3 depth
        Integer target = 3;

        // 상위 메뉴가 미사용 처리인 경우 하위 메뉴 제외
        for(int i = 1; i < menuList.size(); i++) {
            if(target < (Integer)menuList.get(i).get("level")) {
                menuList.remove(i);
                i--;    // remove 후 다음 요소를 조회하려면 index - 1 필요
                continue;
            } else {
                target = 3;
            }

            if(!(Boolean) menuList.get(i).get("is_use")) {
                target = (Integer)menuList.get(i).get("level");
                menuList.remove(i);
                i--;
            } else {
                // 권한 별 메뉴 출력
                if(menuList.get(i).containsKey("has_authority")) {
                    String authority = (String) menuList.get(i).get("has_authority");
                    if(authority != null) {
                        String[] authorityList = authority.toUpperCase().split(",");

                        if(!Arrays.asList(authorityList).contains(roleName.toUpperCase())) {
                            target = (Integer)menuList.get(i).get("level");
                            menuList.remove(i);
                            i--;
                        }
                    }
                }
            }
        }

        // 권한 별 메뉴 출력
//        for(int i = 1; i < menuList.size(); i++) {
//            if(target < (Integer)menuList.get(i).get("level")) {
//                menuList.remove(i);
//                i--;    // remove 후 다음 요소를 조회하려면 index - 1 필요
//                continue;
//            } else {
//                target = 3;
//            }
//
//            if(menuList.get(i).containsKey("has_authority")) {
//                String authority = (String) menuList.get(i).get("has_authority");
//                if(!authority.isEmpty()) {
//                    String[] authorityList = authority.toUpperCase().split(",");
//
////                  if(!Arrays.asList(authorityList).contains("ALL") && !Arrays.asList(authorityList).contains(roleName.toUpperCase())) {
//                    if(!Arrays.asList(authorityList).contains(roleName.toUpperCase())) {
//                        menuList.remove(i);
//                        i--;
//                    }
//                }
//            }
//        }

        attributeContext.putAttribute("menuList", new Attribute(menuList), true);
    }
}
