package com.weaverloft.octopus.basic.option.notice.service;

import com.weaverloft.octopus.basic.option.notice.dao.NoticeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-07-05
 */
@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDao noticeDao;

    @Override
    public List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap) {
        return noticeDao.selectNoticeList(paramMap);
    }

    @Override
    public int selectNoticeListCnt(Map<String, Object> paramMap) {
        return noticeDao.selectNoticeListCnt(paramMap);
    }

    @Override
    public Map<String, Object> selectNoticeDetail(int seq) {
        return noticeDao.selectNoticeDetail(seq);
    }

    @Override
    public int insertNotice(Map<String, Object> paramMap) {
        return noticeDao.insertNotice(paramMap);
    }

    @Override
    public int updateNotice(Map<String, Object> paramMap) {
        return noticeDao.updateNotice(paramMap);
    }

    @Override
    public int deleteNotice(Map<String, Object> paramMap) {
        return noticeDao.deleteNotice(paramMap);
    }

    @Override
    public Map<String, Object> selectNoticeForMainPage(int num) { return noticeDao.selectNoticeForMainPage(num); }

}
