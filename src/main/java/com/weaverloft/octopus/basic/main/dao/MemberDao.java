package com.weaverloft.octopus.basic.main.dao;

import com.weaverloft.octopus.basic.main.vo.MemberVo;
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
    int selectUserCount(MemberVo memberVo);

    List<MemberVo> selectUserList(MemberVo memberVo);
}
