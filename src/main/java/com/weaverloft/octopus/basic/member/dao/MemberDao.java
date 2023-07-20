package com.weaverloft.octopus.basic.member.dao;

import com.weaverloft.octopus.basic.member.vo.MemberVo;
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
public interface MemberDao {
    int selectMemberCount(MemberVo memberVo);

    List<MemberVo> selectMemberList(MemberVo memberVo);

    MemberVo getMemberDetail(MemberVo memberVo);

    int updateMember(MemberVo memberVo);

    int insertMember(MemberVo memberVo);

    List<String> selectMemberIdList();

    List<?> selectExcelMemberList(MemberVo memberVo);

    Map<String, Object> selectMemberAgeList();

    int updateMembership(MemberVo memberVo);

}
