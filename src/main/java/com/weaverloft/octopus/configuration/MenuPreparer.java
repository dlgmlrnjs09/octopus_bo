package com.weaverloft.octopus.configuration;

import com.weaverloft.octopus.basic.menu.service.MenuService;
import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuPreparer implements ViewPreparer {

    @Autowired
    private MenuService menuService;

    @Override
    public void execute(Request request, AttributeContext attributeContext) throws PreparerException {
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
            }
        }

        attributeContext.putAttribute("menuList", new Attribute(menuList), true);
    }
}
