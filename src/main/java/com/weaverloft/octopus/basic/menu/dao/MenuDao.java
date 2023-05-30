package com.weaverloft.octopus.basic.menu.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Mapper
public interface MenuDao {
    List<Map<String, Object>> getMenuInfo(Map<String, Object> map);

    Map<String, Object> selectMenuDetail(Integer menuSeq);

    int deleteMenu(Integer menuSeq);

    int updateMenu(Map<String, Object> map);

    int insertMenu(Map<String, Object> map);
}
