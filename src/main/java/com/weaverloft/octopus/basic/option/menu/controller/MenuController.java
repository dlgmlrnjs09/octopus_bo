package com.weaverloft.octopus.basic.option.menu.controller;

import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.option.menu.service.MenuService;
import com.weaverloft.octopus.basic.option.role.service.RoleService;
import com.weaverloft.octopus.basic.option.role.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-04-10
 */
@Controller
@RequestMapping("menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private RoleService roleService;

    /** File Service */
    @Autowired
    protected FileService fileService;

    @GetMapping("/main")
    public String showMenuMainPage(Model model) {
        Map<String, Object> map = new HashMap<>();
        List<Map<String, Object>> menuList = menuService.getMenuInfo(map);

        List<RoleVo> roleList = roleService.selectRoleList(new RoleVo());

//        map.put("ADMIN", "어드민");
//        map.put("MANAGER", "매장관리자");

        model.addAttribute("menuList", menuList);
        model.addAttribute("roleList", roleList);
        return "/option/menu/menu-main.admin";
    }

    @GetMapping("/select-menu-detail")
    @ResponseBody
    public List<Map<String, Object>> selectMenuDetail(@RequestParam("menuSeq") Integer menuSeq) {
        Map<String, Object> map = new HashMap<>();
        map.put("menuSeq", menuSeq);

        List<Map<String, Object>> menuDetail = menuService.getMenuInfo(map);

        return menuDetail;
    }

    @GetMapping("/delete-menu")
    @ResponseBody
    public int deleteMenu(@RequestParam("menuSeq") Integer menuSeq) {
        List<Integer> deleteSeqList = menuService.getChildMenuSeq(menuSeq);

        // TODO 메뉴 아이콘 파일도 삭제 처리
        int result = menuService.deleteMenu(deleteSeqList);

        return result;
    }

    @PostMapping("/update-menu")
    @ResponseBody
    public int updateMenu(@RequestParam Map<String, Object> menuMap, HttpServletRequest request) throws Exception {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        String filePath = request.getServletContext().getRealPath("/asset/upload/img");
        File dir = new File(filePath);
        if (!dir.isDirectory()) {
            dir.mkdirs();
        }

        CommonsMultipartFile fileIcon = (CommonsMultipartFile) multipartRequest.getFile("fileIcon");

        FileVo fileIconVO = new FileVo();

        if(fileIcon.getSize()!=0){
            fileIconVO = fileService.saveFileProduct(fileIcon, filePath);

            fileIconVO.setTypeDepth1("menu");
            fileIconVO.setForeignSeq(Integer.valueOf((String)menuMap.get("menuSeq")));

            Map<String, Object> currFileIconMap = fileService.selectFileInfo(fileIconVO);
            if(currFileIconMap == null) {
                fileService.insertFileInfo(fileIconVO);
            } else {
                fileService.updateFileInfo(fileIconVO);
            }
        }

        int result = menuService.updateMenu(menuMap);

        return result;
    }

    @PostMapping("/insert-menu")
    @ResponseBody
    public int insertMenu(Model model, @RequestParam Map<String, Object> menuMap, HttpServletRequest request) throws Exception {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        String filePath = request.getServletContext().getRealPath("/asset/upload/img");
        File dir = new File(filePath);
        if (!dir.isDirectory()) {
            dir.mkdirs();
        }

        CommonsMultipartFile fileIcon = (CommonsMultipartFile) multipartRequest.getFile("fileIcon");

        FileVo fileIconVO = new FileVo();

        int result = menuService.insertMenu(menuMap);

        if(fileIcon.getSize()!=0){
            fileIconVO = fileService.saveFileProduct(fileIcon, filePath);

            fileIconVO.setTypeDepth1("menu");
            fileIconVO.setForeignSeq(Integer.valueOf((String)menuMap.get("menuSeq")));

            // TODO 이미지 썸네일 등록
            fileService.insertFileInfo(fileIconVO);
        }

        return result;
    }
}