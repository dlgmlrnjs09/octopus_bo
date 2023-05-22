package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
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
import java.util.regex.Pattern;

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

    @GetMapping("/select-user-list")
    @ResponseBody
    public ModelAndView selectUserList(Model model, @ModelAttribute MemberVo memberVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = memberService.selectUserCount(memberVo);

            PagingModel pagingModel = PagingModel.getPagingModel(memberVo.getCurPage(), memberVo.getPageSize(), count);
            memberVo.setPagingModel(pagingModel);

            List<MemberVo> memberList = memberService.selectUserList(memberVo);

            for(MemberVo member : memberList) {
                member.setMemberNm(CommonUtil.maskingName(member.getMemberNm()));
                member.setMemberPhoneFull(CommonUtil.maskingPhone(member.getMemberPhoneFull()));
            }

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

    @GetMapping("/member-detail")
    public String loadMemberDetail(Model model, @ModelAttribute MemberVo memberVo) {

        try{
            MemberVo member = memberService.getMemberDetail(memberVo);
            model.addAttribute("member", member);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "/member/member-detail";
    }

    @GetMapping("/member-update")
    @ResponseBody
    public String updateMember(Model model, @ModelAttribute MemberVo memberVo) {

        try{
            String phoneRegex = "^\\d{3}-\\d{3,4}-\\d{4}$";

            // 전화번호 형식 체크
            if(Pattern.matches(phoneRegex, memberVo.getMemberPhoneFull())) {
                String[] phone = memberVo.getMemberPhoneFull().split("-");

                memberVo.setMemberPhone1(phone[0]);
                memberVo.setMemberPhone2(phone[1]);
                memberVo.setMemberPhone3(phone[2]);
            } else {
                return "fail";
            }

            memberVo.setMemberEmailFull(memberVo.getMemberEmailId() + "@" + memberVo.getMemberEmailDomain());

            memberService.updateMember(memberVo);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "success";
    }

    @GetMapping("/role-update")
    @ResponseBody
    public String updateMemberRole(Model model, @ModelAttribute MemberVo memberVo) {

        try{
            memberService.updateMemberRole(memberVo);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "success";
    }
}
