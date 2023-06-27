package com.weaverloft.octopus.basic.option.log.service;

import com.weaverloft.octopus.basic.option.log.dao.LogDao;
import com.weaverloft.octopus.basic.option.menu.dao.MenuDao;
import com.weaverloft.octopus.basic.option.menu.service.MenuService;
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
@Service("logService")
public class LogServiceImpl implements LogService{
    @Autowired
    private LogDao logDao;

    public int selectLogCount(Map<String, Object> map) { return logDao.selectLogCount(map); }

    public List<Map<String, Object>> selectDownloadList(Map<String, Object> map) { return logDao.selectDownloadList(map); }

    public List<Map<String, Object>> selectAdminLoginList(Map<String, Object> map) { return logDao.selectAdminLoginList(map); }
}
