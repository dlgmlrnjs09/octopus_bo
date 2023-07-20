package com.weaverloft.octopus.basic.admin.service;

import com.weaverloft.octopus.basic.admin.dao.AdminDao;
import com.weaverloft.octopus.basic.admin.vo.AdminVo;
import com.weaverloft.octopus.basic.member.dao.MemberDao;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
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
public class AdminServiceImpl implements AdminService{
    @Autowired
    private AdminDao adminDao;

    public int selectAdminCount(AdminVo adminVo) { return adminDao.selectAdminCount(adminVo); }

    public List<AdminVo> selectAdminList(AdminVo adminVo) { return adminDao.selectAdminList(adminVo); }

    public AdminVo getAdminDetail(AdminVo adminVo) { return adminDao.getAdminDetail(adminVo); }

    public AdminVo getAdminRole(AdminVo adminVo) { return adminDao.getAdminRole(adminVo); }

    public int updateAdmin(AdminVo adminVo) { return adminDao.updateAdmin(adminVo); }

    public int updateAdminRole(AdminVo adminVo) { return adminDao.updateAdminRole(adminVo); }

    public int insertAdmin(AdminVo adminVo) { return adminDao.insertAdmin(adminVo); }

    public List<String> selectAdminIdList() { return adminDao.selectAdminIdList(); }

    public List<?> selectExcelAdminList(AdminVo adminVo) { return adminDao.selectExcelAdminList(adminVo); }
}
