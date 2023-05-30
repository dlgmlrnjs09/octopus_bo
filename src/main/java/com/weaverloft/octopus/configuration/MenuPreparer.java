package com.weaverloft.octopus.configuration;

import com.weaverloft.octopus.basic.menu.service.MenuService;
import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
        map.put("mode", "SELECT");

        List<Map<String, Object>> menuList = menuService.getMenuInfo(map);

        attributeContext.putAttribute("menuList", new Attribute(menuList), true);
    }
}
