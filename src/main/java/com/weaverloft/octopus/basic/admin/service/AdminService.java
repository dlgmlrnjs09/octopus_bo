package com.weaverloft.octopus.basic.admin.service;

import com.weaverloft.octopus.basic.admin.vo.AdminVo;
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
public interface AdminService {
    int selectAdminCount(AdminVo adminVo);

    List<AdminVo> selectAdminList(AdminVo adminVo);

    AdminVo getAdminDetail(AdminVo adminVo);

    AdminVo getAdminRole(AdminVo adminVo);

    int updateAdmin(AdminVo adminVo);

    int updateAdminRole(AdminVo adminVo);

    int insertAdmin(AdminVo adminVo);

    List<String> selectAdminIdList();

    List<?> selectExcelAdminList(AdminVo adminVo);
}
