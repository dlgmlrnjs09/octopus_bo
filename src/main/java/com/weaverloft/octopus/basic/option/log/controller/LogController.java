package com.weaverloft.octopus.basic.option.log.controller;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.option.log.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
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
@RequestMapping("admin-log")
public class LogController {

    @Autowired
    private LogService logService;

    @GetMapping("/main")
    public String showMemberMainPage(Model model) {
        return "/option/log/log-main.admin";
    }

    @GetMapping("/select-log-list")
    @ResponseBody
    public ModelAndView selectMemberList(Model model, @RequestParam Map<String, Object> paramMap) {
        ModelAndView mv = new ModelAndView();

        try{
            String type = String.valueOf(paramMap.get("type"));

            int currPage = CommonUtil.isEmpty((String) paramMap.get("curPage")) ? 1 : Integer.parseInt(paramMap.get("curPage").toString());
            int pageSize = CommonUtil.isEmpty((String) paramMap.get("pageSize")) ? 10 : Integer.parseInt(paramMap.get("pageSize").toString());

            int totalCnt = logService.selectLogCount(paramMap);

            PagingModel pagingModel = PagingModel.getPagingModel(Integer.toString(currPage), Integer.toString(pageSize), totalCnt);
            paramMap.put("pagingModel", pagingModel);

            List<Map<String, Object>> logList = new ArrayList<>();

            if(type.equals("download")) {
                logList = logService.selectDownloadList(paramMap);
            } else if(type.equals("login")) {
                logList = logService.selectAdminLoginList(paramMap);
            }

            mv.setViewName("/option/log/setLogList");
            mv.addObject("logList", logList);
            mv.addObject("type", type);
            mv.addObject("pagingModel", pagingModel);
        }catch (Exception e) {
            System.out.println(e);

            mv.setViewName("404");
            return mv;
        }

        return mv;
    }
}