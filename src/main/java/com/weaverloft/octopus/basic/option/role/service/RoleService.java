package com.weaverloft.octopus.basic.option.role.service;

import com.weaverloft.octopus.basic.option.role.vo.RoleVo;

import java.util.List;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface RoleService {

    int selectRoleCount(RoleVo roleVo);

    List<RoleVo> selectRoleList(RoleVo roleVo);

    RoleVo getRoleDetail(RoleVo roleVo);

    int updateRole(RoleVo roleVo);

    int insertRole(RoleVo roleVo);
}
