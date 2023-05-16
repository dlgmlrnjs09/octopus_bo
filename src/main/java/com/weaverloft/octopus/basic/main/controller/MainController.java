package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.main.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-04-10
 */
@Controller
@RequestMapping("main")
public class MainController {

    @Autowired
    private MainService mainService;

    @GetMapping("/main-page")
    public String showMainPage() {
        System.out.println(mainService.test());
        return "/main/main-page";
    }
}
