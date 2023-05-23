package com.weaverloft.octopus.basic.main.service;

import com.weaverloft.octopus.basic.main.vo.MemberVo;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface MemberService {
    int selectMemberCount(MemberVo memberVo);

    List<MemberVo> selectMemberList(MemberVo memberVo);

    MemberVo getMemberDetail(MemberVo memberVo);

    int updateMember(MemberVo memberVo);

    int updateMemberRole(MemberVo memberVo);

    int insertMember(MemberVo memberVo);

    List<String> selectMemberIdList();

    List<?> selectExcelMemberList(MemberVo memberVo);
}
