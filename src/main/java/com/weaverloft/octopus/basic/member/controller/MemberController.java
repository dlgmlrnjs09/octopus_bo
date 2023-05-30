package com.weaverloft.octopus.basic.member.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.ExcelService;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
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

    /** File Service */
    @Autowired
    protected FileService fileService;

    /** ExcelService */
    @Autowired
    ExcelService excelService;

    @GetMapping("/main")
    public String showMemberMainPage(Model model) {
        return "/member/member-main.admin";
    }

    @GetMapping("/select-member-list")
    @ResponseBody
    public ModelAndView selectMemberList(Model model, @ModelAttribute MemberVo memberVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = memberService.selectMemberCount(memberVo);

            PagingModel pagingModel = PagingModel.getPagingModel(memberVo.getCurPage(), memberVo.getPageSize(), count);
            memberVo.setPagingModel(pagingModel);

            List<MemberVo> memberList = memberService.selectMemberList(memberVo);

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

        return "/member/member-detail.admin";
    }

    @GetMapping("/member-update")
    @ResponseBody
    public String updateMember(Model model, @ModelAttribute MemberVo memberVo) {

        try{
            memberVo.setMemberEmailFull(memberVo.getMemberEmailId() + "@" + memberVo.getMemberEmailDomain());

            // 전화번호 & 이메일 형식 체크
            if(isValidPhone(memberVo.getMemberPhoneFull()) && isValidEmail(memberVo.getMemberEmailFull())) {
                String[] phone = memberVo.getMemberPhoneFull().split("-");

                memberVo.setMemberPhone1(phone[0]);
                memberVo.setMemberPhone2(phone[1]);
                memberVo.setMemberPhone3(phone[2]);
            } else {
                return "fail";
            }

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
        List<Map<String, Object>> validateMemberList = new ArrayList<Map<String, Object>>();

        if(!"".equals(excelFile)){

            String excelData[][] = excelService.uploadProd(excelFile);
            totalCnt = excelData.length-1 ;
            System.out.println(totalCnt);

            for(int i = 1; i < excelData.length; i++) {
                MemberVo excelVo = new MemberVo();
                Map<String, Object> validate = new HashMap<String, Object>();
                Map<String, Object> validateMember = new HashMap<String, Object>();

                boolean validateResult = true;

                excelVo.setMemberId((excelData[i][0] == null || "".equals(excelData[i][0])) ? "" : excelData[i][0]); 		// 회원 아이디
                excelVo.setMemberPhoneFull((excelData[i][1] == null || "".equals(excelData[i][1])) ? "" : excelData[i][1]); // 휴대전화번호
                excelVo.setMemberEmailFull((excelData[i][2] == null || "".equals(excelData[i][2])) ? "" : excelData[i][2]); // 회원 이메일

                validateMember.put("memberId", excelVo.getMemberId());
                if("".equals(excelVo.getMemberId())){
                    validate.put("memberId", "회원 아이디를 입력해 주세요.");
                    validateMember.put("memberId", excelVo.getMemberId());
                    validateResult = false;
                } else if(idList.contains(excelVo.getMemberId())) {
                    validate.put("memberId", "회원 아이디가 중복입니다.");
                    validateMember.put("memberId", excelVo.getMemberId());
                    validateResult = false;
                }

                validateMember.put("memberPhoneFull", excelVo.getMemberPhoneFull());
                if("".equals(excelVo.getMemberPhoneFull())){
                    validate.put("memberPhoneFull", "전화번호를 입력해 주세요.");
                    validateMember.put("memberPhoneFull", excelVo.getMemberPhoneFull());
                    validateResult = false;
                } else if(!isValidPhone(excelVo.getMemberPhoneFull())) {
                    validate.put("memberPhoneFull", "전화번호를 형식에 맞게 입력해 주세요.");
                    validateMember.put("memberPhoneFull", excelVo.getMemberPhoneFull());
                    validateResult = false;
                }

                validateMember.put("memberEmailFull", excelVo.getMemberEmailFull());
                if("".equals(excelVo.getMemberEmailFull())){
                    validate.put("memberEmailFull", "이메일을 입력해 주세요.");
                    validateMember.put("memberEmailFull", excelVo.getMemberEmailFull());
                    validateResult = false;
                } else if(!isValidEmail(excelVo.getMemberEmailFull())) {
                    validate.put("memberEmailFull", "이메일을 형식에 맞게 입력해 주세요.");
                    validateMember.put("memberEmailFull", excelVo.getMemberEmailFull());
                    validateResult = false;
                }

                // TODO 기본 패스워드 지정
                //필수 값이 모두 있으면
                if(validateResult){
                    excelVo.setMemberPw("기본패스워드");  // pw not null

                    excelVo.setMemberPhone1(excelData[i][1].split("-")[0]);
                    excelVo.setMemberPhone2(excelData[i][1].split("-")[1]);
                    excelVo.setMemberPhone3(excelData[i][1].split("-")[2]);

                    excelVo.setMemberEmailId(excelData[i][2].split("@")[0]);
                    excelVo.setMemberEmailDomain(excelData[i][2].split("@")[1]);

                    memberService.insertMember(excelVo);
                    succesCnt++;
                }else{
                    model.addAttribute("result",false);
                    validateMemberList.add(validateMember);
                    validateList.add(validate);
                    failCnt++;
                }

            }

        }
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("succesCnt", succesCnt);
        model.addAttribute("failCnt", failCnt);
        model.addAttribute("validateList",validateList);
        model.addAttribute("validateMemberList",validateMemberList);
        return mv;
    }

    @RequestMapping(value = "/insert-member-excel-log", produces = "application/text; charset=utf-8")
    public void insertMemberExcelLog(@RequestParam("dataJson") String dataJson, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>() ;
        setting.put("아이디", "memberId");
        setting.put("휴대전화번호", "memberPhoneFull");
        setting.put("이메일", "memberEmailFull");

        excelService.memberExcelLogDown(setting, dataJson,  response , request, fileSetting);
    }

    @RequestMapping("/download-member-excel")
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
        Map<String, Object> logMap = new HashMap<>();
        logMap.put("downloadRegId", "다운로드 사용자 아이디");
        logMap.put("downloadLogIp", request.getRemoteAddr());
        logMap.put("downloadLogReason", "[회원 관리] 회원 정보 다운로드");
        // TODO 다운로드 로그 저장 공통으로 빼기
        memberService.insertMemberDownloadLog(logMap);

        excelService.down(setting, excelMemberList, response , request, fileSetting);
    }

    // 전화번호 형식 체크
    public boolean isValidPhone(String phone) {
        String phoneRegex = "^\\d{3}-\\d{3,4}-\\d{4}$";

        if(Pattern.matches(phoneRegex, phone)) {
            return true;
        } else {
            return false;
        }
    }

    // 이메일 형식 체크
    public boolean isValidEmail(String email) {
        String emailRegex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";

        if(Pattern.matches(emailRegex, email)) {
            return true;
        } else {
            return false;
        }
    }

}
