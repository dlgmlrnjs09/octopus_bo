package com.weaverloft.octopus.basic.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-07-12
 */
public interface MembershipService {
    List<Map<String, Object>> selectMembershipList();

    Map<String, Object> selectMembershipInfo(int seq);

    int insertMembership(Map<String, Object> paramMap);

    int updateMembership(Map<String, Object> paramMap);

    int deleteMembership(Map<String, Object> paramMap);

    int selectCountMembershipInfo(Map<String, Object> paramMap);

    int getMaxMembershipPriority();

    int updateMembershipPriority(Map<String, Object> paramMap);

    void updateMembershipSeq();

    int getSumOrderPeriod();

    int updateSumOrderPeriod(int sumOrderPeriod);
}
