package com.weaverloft.octopus.basic.main.service;

import com.weaverloft.octopus.basic.main.dao.MainDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Service
public class MainServiceImpl implements MainService{
    @Autowired
    private MainDao mainDao;

    public int test() {
        return mainDao.test();
    }
}
