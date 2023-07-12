package com.weaverloft.octopus.basic.option.notice.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-07-05
 */

@Mapper
public interface NoticeDao {
    List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap);
    int selectNoticeListCnt(Map<String, Object> paramMap);
    Map<String, Object> selectNoticeDetail(int seq);
    int insertNotice(Map<String, Object> paramMap);
    int updateNotice(Map<String, Object> paramMap);
    int deleteNotice(Map<String, Object> paramMap);

    Map<String, Object> selectNoticeForMainPage(int num);
}
