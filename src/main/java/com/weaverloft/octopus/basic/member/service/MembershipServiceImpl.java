package com.weaverloft.octopus.basic.member.service;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.member.dao.MembershipDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
@Service("MembershipService")
public class MembershipServiceImpl implements MembershipService {

    @Autowired
    MembershipDao membershipDao;

    @Override
    public List<Map<String, Object>> selectMembershipList() {
        return membershipDao.selectMembershipList();
    }

    @Override
    public Map<String, Object> selectMembershipInfo(int seq) {
        return membershipDao.selectMembershipInfo(seq);
    }

    @Override
    public int insertMembership(Map<String, Object> paramMap) {
        return membershipDao.insertMembershipInfo(paramMap);
    }

    @Override
    public int updateMembership(Map<String, Object> paramMap) {
        return membershipDao.updateMembershipInfo(paramMap);
    }

    @Override
    public int deleteMembership(Map<String, Object> paramMap) {
        return membershipDao.deleteMembershipInfo(paramMap);
    }

    @Override
    public int selectCountMembershipInfo(Map<String, Object> paramMap) {
        return membershipDao.selectCountMembershipInfo(paramMap);
    }

    @Override
    public int getMaxMembershipPriority() {
        return membershipDao.getMaxMembershipPriority();
    }

    @Override
    public int updateMembershipPriority(Map<String, Object> paramMap) {
        return membershipDao.updateMembershipPriority(paramMap);
    }

    @Override
    public void updateMembershipSeq() {
        membershipDao.updateMembershipSeq();
    }

    @Override
    public int getSumOrderPeriod() {
        return membershipDao.getSumOrderPeriod();
    }

    @Override
    public int updateSumOrderPeriod(int sumOrderPeriod) {
        return membershipDao.updateSumOrderPeriod(sumOrderPeriod);
    }
}
