package com.weaverloft.octopus.basic.member.dao;

import org.apache.ibatis.annotations.Mapper;

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
@Mapper
public interface MembershipDao {
    List<Map<String, Object>> selectMembershipList();

    Map<String, Object> selectMembershipInfo(int seq);

    Map<String, Object> selectMembershipBenefitDetail(int seq);

    int selectCountMembershipInfo(Map<String, Object> paramMap);

    int insertMembershipInfo(Map<String, Object> paramMap);

    int updateMembershipInfo(Map<String, Object> paramMap);

    int deleteMembershipInfo(Map<String, Object> paramMap);

    int getMaxMembershipPriority();

    int updateMembershipPriority(Map<String, Object> paramMap);

    void updateMembershipSeq();

    int getSumOrderPeriod();

    int updateSumOrderPeriod(int sumOrderPeriod);
}
