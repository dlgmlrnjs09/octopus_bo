package com.weaverloft.octopus.api.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Mapper
public interface ApiMemberDao {
    List<Map<String, Object>> selectPointSumList(Map<String, Object> map);

    List<Map<String, Object>> selectCouponList(Map<String, Object> map);

    Map<String, Object> selectCurrentMembershipInfo(Map<String, Object> map);

    Map<String, Object> selectNextMembershipInfo(Map<String, Object> map);
}
