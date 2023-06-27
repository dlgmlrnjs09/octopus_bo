package com.weaverloft.octopus.basic.option.log.service;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface LogService {
    int selectLogCount(Map<String, Object> map);

    List<Map<String, Object>> selectDownloadList(Map<String, Object> map);

    List<Map<String, Object>> selectAdminLoginList(Map<String, Object> map);
}
