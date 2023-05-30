package com.weaverloft.octopus.basic.menu.service;

import com.weaverloft.octopus.basic.menu.dao.MenuDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Service("menuService")
public class MenuServiceImpl implements MenuService{
    @Autowired
    private MenuDao menuDao;

    public List<Map<String, Object>> getMenuInfo(Map<String, Object> map) { return menuDao.getMenuInfo(map); }

    public Map<String, Object> selectMenuDetail(Integer menuSeq) { return menuDao.selectMenuDetail(menuSeq); }

    public int deleteMenu(Integer menuSeq) { return menuDao.deleteMenu(menuSeq); }

    public int updateMenu(Map<String, Object> map) { return menuDao.updateMenu(map); }

    public int insertMenu(Map<String, Object> map) { return menuDao.insertMenu(map); }
}
