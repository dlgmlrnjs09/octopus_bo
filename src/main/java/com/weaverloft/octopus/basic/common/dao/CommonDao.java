package com.weaverloft.octopus.basic.common.dao;

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
public interface CommonDao {
    int insertDownloadLog(Map<String, Object> map);

    int insertAdminLoginLog(Map<String, Object> map);
}
