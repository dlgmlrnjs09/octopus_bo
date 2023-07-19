package com.weaverloft.octopus.basic.member.service;

import com.weaverloft.octopus.basic.member.dao.MemberDao;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
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
@Service
public class MemberServiceImpl implements MemberService{
    @Autowired
    private MemberDao memberDao;

    public int selectMemberCount(MemberVo memberVo) {
        return memberDao.selectMemberCount(memberVo);
    }

    public List<MemberVo> selectMemberList(MemberVo memberVo) {
        return memberDao.selectMemberList(memberVo);
    }

    public MemberVo getMemberDetail(MemberVo memberVo) { return memberDao.getMemberDetail(memberVo); }

    public MemberVo getMemberRole(MemberVo memberVo) { return memberDao.getMemberRole(memberVo); }

    public int updateMember(MemberVo memberVo) { return memberDao.updateMember(memberVo); }

    public int updateMemberRole(MemberVo memberVo) { return memberDao.updateMemberRole(memberVo); }

    public int insertMember(MemberVo memberVo) { return memberDao.insertMember(memberVo); }

    public List<String> selectMemberIdList() { return memberDao.selectMemberIdList(); }

    public List<?> selectExcelMemberList(MemberVo memberVo) { return memberDao.selectExcelMemberList(memberVo); }

    @Override
    public int updateMembership(MemberVo memberVo) {
        return memberDao.updateMembership(memberVo);
    }


}
