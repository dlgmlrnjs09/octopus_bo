package com.weaverloft.octopus.api.service;

import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface ApiMemberService {
    Map<String, Object> selectPointCouponInfo(Map<String, Object> map);

    Map<String, Object> selectMembershipInfo(Map<String, Object> map);
}
