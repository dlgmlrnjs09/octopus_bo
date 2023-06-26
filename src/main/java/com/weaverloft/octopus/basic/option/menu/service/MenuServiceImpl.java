package com.weaverloft.octopus.basic.option.menu.service;

import com.weaverloft.octopus.basic.option.menu.dao.MenuDao;
import org.springframework.beans.factory.annotation.Autowired;
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

    public int deleteMenu(List<Integer> menuSeqList) { return menuDao.deleteMenu(menuSeqList); }

    public int updateMenu(Map<String, Object> map) { return menuDao.updateMenu(map); }

    public int insertMenu(Map<String, Object> map) { return menuDao.insertMenu(map); }

    public List<Integer> getChildMenuSeq(Integer menuSeq) { return menuDao.getChildMenuSeq(menuSeq); }
}
