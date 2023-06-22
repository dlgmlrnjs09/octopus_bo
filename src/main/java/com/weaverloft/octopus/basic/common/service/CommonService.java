package com.weaverloft.octopus.basic.common.service;

import com.weaverloft.octopus.basic.member.vo.MemberVo;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface CommonService {
    int insertDownloadLog(String reason);

    int insertAdminLoginLog(Map<String, Object> map);
}
