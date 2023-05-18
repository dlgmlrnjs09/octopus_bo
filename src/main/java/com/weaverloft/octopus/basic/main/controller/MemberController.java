package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.MemberService;
import com.weaverloft.octopus.basic.main.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author hyojeong kim
 * @version 0.0.1
 * @brief 회원 관리
 * @details 회원 조회
 * @date 2023-05-17
 */
@Controller
@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService memberService;


    @GetMapping("/main")
    public String showMainPage(Model model) {
        return "/member/member-main";
    }

    @GetMapping(value = "/select-user-list")
    @ResponseBody
    public ModelAndView selectUserList(Model model, @ModelAttribute MemberVo memberVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = memberService.selectUserCount(memberVo);

            PagingModel pagingModel = PagingModel.getPagingModel(memberVo.getCurPage(), memberVo.getPageSize(), count);
            memberVo.setPagingModel(pagingModel);

            List<MemberVo> memberList = memberService.selectUserList(memberVo);

            mv.setViewName("/member/setUserList");
            mv.addObject("memberList", memberList);
            mv.addObject("pagingModel", pagingModel);
        }catch (Exception e) {
            System.out.println(e);

            mv.setViewName("404");
            return mv;
        }

        return mv;
    }
}
