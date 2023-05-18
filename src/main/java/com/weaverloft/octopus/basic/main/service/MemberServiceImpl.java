package com.weaverloft.octopus.basic.main.service;

import com.weaverloft.octopus.basic.main.dao.MainDao;
import com.weaverloft.octopus.basic.main.dao.MemberDao;
import com.weaverloft.octopus.basic.main.vo.MemberVo;
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
@Service
public class MemberServiceImpl implements MemberService{
    @Autowired
    private MemberDao memberDao;

    public int selectUserCount(MemberVo memberVo) {
        return memberDao.selectUserCount(memberVo);
    }

    public List<MemberVo> selectUserList(MemberVo memberVo) {
        return memberDao.selectUserList(memberVo);
    }
}
