package com.weaverloft.octopus.basic.role.service;

import com.weaverloft.octopus.basic.member.dao.MemberDao;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.role.dao.RoleDao;
import com.weaverloft.octopus.basic.role.vo.RoleVo;
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
public class RoleServiceImpl implements RoleService{
    @Autowired
    private RoleDao roleDao;

    public int selectRoleCount(RoleVo roleVo) { return roleDao.selectRoleCount(roleVo); }

    public List<RoleVo> selectRoleList(RoleVo roleVo) { return roleDao.selectRoleList(roleVo); }

    public RoleVo getRoleDetail(RoleVo roleVo) { return roleDao.getRoleDetail(roleVo); }

    public int updateRole(RoleVo roleVo) { return roleDao.updateRole(roleVo); }

    public int insertRole(RoleVo roleVo) { return roleDao.insertRole(roleVo); }
}
