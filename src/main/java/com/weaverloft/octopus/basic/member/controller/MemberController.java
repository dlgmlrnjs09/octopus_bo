package com.weaverloft.octopus.basic.member.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.ExcelService;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.member.service.MembershipService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.option.role.service.RoleService;
import com.weaverloft.octopus.basic.option.role.vo.RoleVo;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import com.weaverloft.octopus.basic.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.time.LocalDate;
import java.util.*;

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

    @Autowired
    private CommonService commonService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private MembershipService membershipService;

    /** File Service */
    @Autowired
    protected FileService fileService;

    /** ExcelService */
    @Autowired
    ExcelService excelService;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @GetMapping("/main")
    public String showMemberMainPage(@RequestParam(required = false) String srchMembershipSeq, Model model) {

        List<Map<String, Object>> membershipList = membershipService.selectMembershipList();

        model.addAttribute("membershipList", membershipList);
        model.addAttribute("srchMembershipSeq", srchMembershipSeq);

        return "/member/member-main.admin";
    }

    @PostMapping("/select-member-list")
    @ResponseBody
    public ModelAndView selectMemberList(Model model, @RequestBody MemberVo memberVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = memberService.selectMemberCount(memberVo);

            PagingModel pagingModel = PagingModel.getPagingModel(memberVo.getCurPage(), memberVo.getPageSize(), count);
            memberVo.setPagingModel(pagingModel);

            List<MemberVo> memberList = memberService.selectMemberList(memberVo);
            List<Map<String, Object>> membershipList = membershipService.selectMembershipList();

            for(MemberVo member : memberList) {
                if(member.getMemberNm() != null) {
                    member.setMemberNm(CommonUtil.maskingName(member.getMemberNm()));
                }
                if(member.getMemberPhoneFull() != null) {
                    member.setMemberPhoneFull(CommonUtil.maskingPhone(member.getMemberPhoneFull()));
                }
            }

            mv.setViewName("/member/setUserList");
            mv.addObject("memberList", memberList);
            mv.addObject("pagingModel", pagingModel);
            mv.addObject("membershipList", membershipList);
        }catch (Exception e) {
            e.printStackTrace();

            mv.setViewName("404");
            return mv;
        }

        return mv;
    }

    @GetMapping("/member-detail")
    public String loadMemberDetail(Model model, @ModelAttribute MemberVo memberVo) {

        try{
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            if(!user.getUserRole().equals("ADMIN")) {
                return "redirect:/main/denied";
            }

//            List<RoleVo> roleList = roleService.selectRoleList(new RoleVo());
            List<Map<String, Object>> membershipList = membershipService.selectMembershipList();
            MemberVo member = memberService.getMemberDetail(memberVo);

//            model.addAttribute("roleList", roleList);
            model.addAttribute("membershipList", membershipList);
            model.addAttribute("member", member);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "/member/member-detail.admin";
    }

    @GetMapping("/member-update")
    @ResponseBody
    public String updateMember(Model model, @ModelAttribute MemberVo memberVo) {

        try{
            memberVo.setMemberEmailFull(memberVo.getMemberEmailId() + "@" + memberVo.getMemberEmailDomain());

            // 전화번호 & 이메일 형식 체크
            if(CommonUtil.isValidPhone(memberVo.getMemberPhoneFull()) && CommonUtil.isValidEmail(memberVo.getMemberEmailFull())) {
                String[] phone = memberVo.getMemberPhoneFull().split("-");

                memberVo.setMemberPhone1(phone[0]);
                memberVo.setMemberPhone2(phone[1]);
                memberVo.setMemberPhone3(phone[2]);
            } else {
                return "fail";
            }

            memberService.updateMember(memberVo);

            // security 새로운 인증 생성
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, user.getUsername()));
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

            // security 새로운 인증 생성
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, user.getUsername()));
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "success";
    }

    @PostMapping("/membership-update")
    @ResponseBody
    public String updateMembership(@RequestBody MemberVo memberVo) {

        List<Integer> seqList = memberVo.getMemberSeqList();
        if (seqList == null || seqList.size() == 0) {
            return "none";
        }

        try {
            memberService.updateMembership(memberVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }

        return "success";
    }

    /**
      * @description 새로운 인증 생성
      * @param currentAuth 현재 auth 정보
      * @param username	현재 사용자 Id
      * @return Authentication
      * @author Armton
    */
    protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
        CustomUserDetails newPrincipal = (CustomUserDetails) customUserDetailsService.loadUserByUsername(username);
        UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
        newAuth.setDetails(currentAuth.getDetails());
        return newAuth;
    }

    @GetMapping("/insert-member-list-popup")
    public String insertMemberListPopup(Model model) {
        return "/popup/insert-member-list-popup.admin";
    }

    @PostMapping("/insert-member-list")
    @ResponseBody
    public ModelAndView insertMemberList(Model model, @ModelAttribute MemberVo memberVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
        mv.setView(jsonView);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        String filePath = request.getServletContext().getRealPath("/asset/upload");
        File dir = new File(filePath);
        if (!dir.isDirectory()) {
            dir.mkdirs();
        }

        CommonsMultipartFile fileExcel = (CommonsMultipartFile) multipartRequest.getFile("fileExcel");

        FileVo fileExcelVO = new FileVo();
        String excelFile = "";
        model.addAttribute("result",true);

        if(fileExcel.getSize()!=0){
            fileExcelVO = fileService.saveFileProduct(fileExcel, filePath);
            excelFile = filePath + fileExcelVO.getStrgePath() + "/" + fileExcelVO.getStrgeFileNm();
        }

        int totalCnt = 0;
        int succesCnt = 0;
        int failCnt = 0;

        List<String> idList = memberService.selectMemberIdList();

        // 벨리데이션 check result
        List<Map<String, Object>> validateList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> validateDataList = new ArrayList<Map<String, Object>>();

        if(!"".equals(excelFile)){

            String excelData[][] = excelService.uploadProd(excelFile);
            totalCnt = excelData.length-1 ;
            System.out.println(totalCnt);

            for(int i = 1; i < excelData.length; i++) {
                MemberVo excelVo = new MemberVo();
                Map<String, Object> validate = new HashMap<String, Object>();
                Map<String, Object> validateData = new HashMap<String, Object>();

                boolean validateResult = true;

                excelVo.setMemberId((excelData[i][0] == null || "".equals(excelData[i][0])) ? "" : excelData[i][0]); 		// 회원 아이디
                excelVo.setMemberPhoneFull((excelData[i][1] == null || "".equals(excelData[i][1])) ? "" : excelData[i][1]); // 휴대전화번호
                excelVo.setMemberEmailFull((excelData[i][2] == null || "".equals(excelData[i][2])) ? "" : excelData[i][2]); // 회원 이메일

                validateData.put("memberId", excelVo.getMemberId());
                if("".equals(excelVo.getMemberId())){
                    validate.put("memberId", "회원 아이디를 입력해 주세요.");
                    validateData.put("memberId", excelVo.getMemberId());
                    validateResult = false;
                } else if(idList.contains(excelVo.getMemberId())) {
                    validate.put("memberId", "회원 아이디가 중복입니다.");
                    validateData.put("memberId", excelVo.getMemberId());
                    validateResult = false;
                }

                validateData.put("memberPhoneFull", excelVo.getMemberPhoneFull());
                if("".equals(excelVo.getMemberPhoneFull())){
                    validate.put("memberPhoneFull", "전화번호를 입력해 주세요.");
                    validateData.put("memberPhoneFull", excelVo.getMemberPhoneFull());
                    validateResult = false;
                } else if(!CommonUtil.isValidPhone(excelVo.getMemberPhoneFull())) {
                    validate.put("memberPhoneFull", "전화번호를 형식에 맞게 입력해 주세요.");
                    validateData.put("memberPhoneFull", excelVo.getMemberPhoneFull());
                    validateResult = false;
                }

                validateData.put("memberEmailFull", excelVo.getMemberEmailFull());
                if("".equals(excelVo.getMemberEmailFull())){
                    validate.put("memberEmailFull", "이메일을 입력해 주세요.");
                    validateData.put("memberEmailFull", excelVo.getMemberEmailFull());
                    validateResult = false;
                } else if(!CommonUtil.isValidEmail(excelVo.getMemberEmailFull())) {
                    validate.put("memberEmailFull", "이메일을 형식에 맞게 입력해 주세요.");
                    validateData.put("memberEmailFull", excelVo.getMemberEmailFull());
                    validateResult = false;
                }

                //필수 값이 모두 있으면
                if(validateResult){
                    excelVo.setMemberPw("$2a$10$G/ADAGLU3vKBd62E6GbrgetQpEKu2ukKgiDR5TWHYwrem0cSv6Z8m");  // pw : 1234

                    excelVo.setMemberPhone1(excelData[i][1].split("-")[0]);
                    excelVo.setMemberPhone2(excelData[i][1].split("-")[1]);
                    excelVo.setMemberPhone3(excelData[i][1].split("-")[2]);

                    excelVo.setMemberEmailId(excelData[i][2].split("@")[0]);
                    excelVo.setMemberEmailDomain(excelData[i][2].split("@")[1]);

                    memberService.insertMember(excelVo);
                    succesCnt++;
                }else{
                    model.addAttribute("result",false);
                    validateDataList.add(validateData);
                    validateList.add(validate);
                    failCnt++;
                }

            }

        }
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("succesCnt", succesCnt);
        model.addAttribute("failCnt", failCnt);
        model.addAttribute("validateList",validateList);
        model.addAttribute("validateDataList",validateDataList);
        return mv;
    }

    @RequestMapping(value = "/excel/insert-member-excel-log", produces = "application/text; charset=utf-8")
    public void insertMemberExcelLog(@RequestParam("dataJson") String dataJson, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>() ;
        setting.put("아이디", "memberId");
        setting.put("휴대전화번호", "memberPhoneFull");
        setting.put("이메일", "memberEmailFull");

        excelService.excelLogDown(setting, dataJson,  response , request, fileSetting);
    }

    @RequestMapping("/excel/download-member-excel")
    public void downloadMemberExcel(@RequestParam("dataJson") String dataJson, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        MemberVo memberVo =  new ObjectMapper().readValue(dataJson, MemberVo.class);

        List<Object> excelMemberList = (List<Object>) memberService.selectExcelMemberList(memberVo);

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>();
        setting.put("번호", "seq");
        setting.put("회원 아이디", "MemberId");
        setting.put("회원 이름", "MemberNm");
        setting.put("휴대전화번호", "MemberPhoneFull");
        setting.put("생년월일", "MemberBirth");
        setting.put("우편번호", "MemberZipCode");
        setting.put("주소", "MemberAddrFull");
        setting.put("이메일", "MemberEmailFull");
        setting.put("사용자 권한", "MemberRole");
        setting.put("등록일", "RegDt");

        // 개인정보 다운로드 로그 저장
        commonService.insertDownloadLog("[회원 관리] 회원 정보 다운로드");

        excelService.down(setting, excelMemberList, response , request, fileSetting);
    }
}
