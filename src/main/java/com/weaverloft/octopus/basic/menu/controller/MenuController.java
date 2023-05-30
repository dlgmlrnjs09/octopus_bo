package com.weaverloft.octopus.basic.menu.controller;

import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.menu.service.MenuService;
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

    /** File Service */
    @Autowired
    protected FileService fileService;

    @GetMapping("/main")
    public String showMenuMainPage(Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("mode", "EDIT");

        List<Map<String, Object>> menuList = menuService.getMenuInfo(map);

        model.addAttribute("menuList", menuList);
        return "/menu/menu-main.admin";
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
        int result = menuService.deleteMenu(menuSeq);

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

        if(fileIcon.getSize()!=0){
            fileIconVO = fileService.saveFileProduct(fileIcon, filePath);

            fileIconVO.setTypeDepth1("menu");
            fileIconVO.setForeignSeq(Integer.valueOf((String)menuMap.get("menuSeq")));

            // TODO 이미지 썸네일 등록
            fileService.insertFileInfo(fileIconVO);
        }

        int result = menuService.insertMenu(menuMap);

        return result;
    }

    @PostMapping("/select-menu-icon")
    @ResponseBody
    public List<Map<String, Object>> selectMenuIcon(@RequestBody FileVo fileVo) {
        List<Map<String, Object>> menuIconList = fileService.selectFileInfoList(fileVo);

        return menuIconList;
    }
}