package com.weaverloft.octopus.basic.option.role.controller;

import com.weaverloft.octopus.basic.option.role.service.RoleService;
import com.weaverloft.octopus.basic.option.role.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-04-10
 */
@Controller
@RequestMapping("role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @GetMapping("/main")
    public String showRoleMainPage(Model model) {
        List<RoleVo> roleList = roleService.selectRoleList(new RoleVo());

        model.addAttribute("roleList", roleList);
        return "/option/role/role-main.admin";
    }

    @GetMapping("/select-role-detail")
    @ResponseBody
    public RoleVo selectRoleDetail(@ModelAttribute RoleVo roleVo) {
        RoleVo role = roleService.getRoleDetail(roleVo);

        return role;
    }

    @GetMapping("/update-role")
    @ResponseBody
    public int updateRole(@ModelAttribute RoleVo roleVo) throws Exception {
        int result = roleService.updateRole(roleVo);

        return result;
    }

    @PostMapping("/insert-role")
    @ResponseBody
    public int insertRole(@ModelAttribute RoleVo roleVo) throws Exception {
        int result = roleService.insertRole(roleVo);

        return result;
    }
}