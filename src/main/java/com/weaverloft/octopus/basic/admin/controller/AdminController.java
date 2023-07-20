package com.weaverloft.octopus.basic.admin.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.admin.service.AdminService;
import com.weaverloft.octopus.basic.admin.vo.AdminVo;
import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.ExcelService;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.member.service.MemberService;
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
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private CommonService commonService;

    @Autowired
    private RoleService roleService;

    /** File Service */
    @Autowired
    protected FileService fileService;

    /** ExcelService */
    @Autowired
    ExcelService excelService;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @GetMapping("/main")
    public String showAdminMainPage(Model model) {
        return "/admin/admin-main.admin";
    }

    @GetMapping("/select-admin-list")
    @ResponseBody
    public ModelAndView selectAdminList(Model model, @ModelAttribute AdminVo adminVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = adminService.selectAdminCount(adminVo);

            PagingModel pagingModel = PagingModel.getPagingModel(adminVo.getCurPage(), adminVo.getPageSize(), count);
            adminVo.setPagingModel(pagingModel);

            List<AdminVo> adminList = adminService.selectAdminList(adminVo);

            for(AdminVo admin : adminList) {
                if(admin.getAdminName() != null) {
                    admin.setAdminName(CommonUtil.maskingName(admin.getAdminName()));
                }
                if(admin.getAdminPhoneFull() != null) {
                    admin.setAdminPhoneFull(CommonUtil.maskingPhone(admin.getAdminPhoneFull()));
                }
            }

            mv.setViewName("/admin/setAdminList");
            mv.addObject("adminList", adminList);
            mv.addObject("pagingModel", pagingModel);
        }catch (Exception e) {
            System.out.println(e);

            mv.setViewName("404");
            return mv;
        }

        return mv;
    }

    @GetMapping("/admin-detail")
    public String loadAdminDetail(Model model, @ModelAttribute AdminVo adminVo) {

        try{
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

            if(!user.getUserRole().equals("ADMIN")) {
                return "redirect:/main/denied";
            }

            List<RoleVo> roleList = roleService.selectRoleList(new RoleVo());
            AdminVo admin = adminService.getAdminDetail(adminVo);

            model.addAttribute("roleList", roleList);
            model.addAttribute("admin", admin);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "/admin/admin-detail.admin";
    }

    @GetMapping("/admin-update")
    @ResponseBody
    public String updateAdmin(Model model, @ModelAttribute AdminVo adminVo) {

        try{
            adminVo.setAdminEmailFull(adminVo.getAdminEmailId() + "@" + adminVo.getAdminEmailDomain());

            // 전화번호 & 이메일 형식 체크
            if(CommonUtil.isValidPhone(adminVo.getAdminPhoneFull()) && CommonUtil.isValidEmail(adminVo.getAdminEmailFull())) {
                String[] phone = adminVo.getAdminPhoneFull().split("-");

                adminVo.setAdminPhone1(phone[0]);
                adminVo.setAdminPhone2(phone[1]);
                adminVo.setAdminPhone3(phone[2]);
            } else {
                return "fail";
            }

            adminService.updateAdmin(adminVo);

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
    public String updateAdminRole(Model model, @ModelAttribute AdminVo adminVo) {

        try{
            adminService.updateAdminRole(adminVo);

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

    @GetMapping("/insert-admin-list-popup")
    public String insertAdminListPopup(Model model) {
        return "/popup/insert-admin-list-popup.admin";
    }

    @PostMapping("/insert-admin-list")
    @ResponseBody
    public ModelAndView insertAdminList(Model model, @ModelAttribute AdminVo adminVo, HttpServletRequest request) throws Exception {
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

        List<String> idList = adminService.selectAdminIdList();

        // 벨리데이션 check result
        List<Map<String, Object>> validateList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> validateDataList = new ArrayList<Map<String, Object>>();

        if(!"".equals(excelFile)){

            String excelData[][] = excelService.uploadProd(excelFile);
            totalCnt = excelData.length-1 ;
            System.out.println(totalCnt);

            for(int i = 1; i < excelData.length; i++) {
                AdminVo excelVo = new AdminVo();
                Map<String, Object> validate = new HashMap<String, Object>();
                Map<String, Object> validateData = new HashMap<String, Object>();

                boolean validateResult = true;

                excelVo.setAdminId((excelData[i][0] == null || "".equals(excelData[i][0])) ? "" : excelData[i][0]); 		// 회원 아이디
                excelVo.setAdminPhoneFull((excelData[i][1] == null || "".equals(excelData[i][1])) ? "" : excelData[i][1]); // 휴대전화번호
                excelVo.setAdminEmailFull((excelData[i][2] == null || "".equals(excelData[i][2])) ? "" : excelData[i][2]); // 회원 이메일

                validateData.put("adminId", excelVo.getAdminId());
                if("".equals(excelVo.getAdminId())){
                    validate.put("adminId", "관리자 아이디를 입력해 주세요.");
                    validateData.put("adminId", excelVo.getAdminId());
                    validateResult = false;
                } else if(idList.contains(excelVo.getAdminId())) {
                    validate.put("adminId", "괸리자 아이디가 중복입니다.");
                    validateData.put("adminId", excelVo.getAdminId());
                    validateResult = false;
                }

                validateData.put("adminPhoneFull", excelVo.getAdminPhoneFull());
                if("".equals(excelVo.getAdminPhoneFull())){
                    validate.put("adminPhoneFull", "전화번호를 입력해 주세요.");
                    validateData.put("adminPhoneFull", excelVo.getAdminPhoneFull());
                    validateResult = false;
                } else if(!CommonUtil.isValidPhone(excelVo.getAdminPhoneFull())) {
                    validate.put("adminPhoneFull", "전화번호를 형식에 맞게 입력해 주세요.");
                    validateData.put("adminPhoneFull", excelVo.getAdminPhoneFull());
                    validateResult = false;
                }

                validateData.put("adminEmailFull", excelVo.getAdminEmailFull());
                if("".equals(excelVo.getAdminEmailFull())){
                    validate.put("adminEmailFull", "이메일을 입력해 주세요.");
                    validateData.put("adminEmailFull", excelVo.getAdminEmailFull());
                    validateResult = false;
                } else if(!CommonUtil.isValidEmail(excelVo.getAdminEmailFull())) {
                    validate.put("adminEmailFull", "이메일을 형식에 맞게 입력해 주세요.");
                    validateData.put("adminEmailFull", excelVo.getAdminEmailFull());
                    validateResult = false;
                }

                //필수 값이 모두 있으면
                if(validateResult){
                    excelVo.setAdminPw("$2a$10$G/ADAGLU3vKBd62E6GbrgetQpEKu2ukKgiDR5TWHYwrem0cSv6Z8m");  // pw : 1234

                    excelVo.setAdminPhone1(excelData[i][1].split("-")[0]);
                    excelVo.setAdminPhone2(excelData[i][1].split("-")[1]);
                    excelVo.setAdminPhone3(excelData[i][1].split("-")[2]);

                    excelVo.setAdminEmailId(excelData[i][2].split("@")[0]);
                    excelVo.setAdminEmailDomain(excelData[i][2].split("@")[1]);

                    adminService.insertAdmin(excelVo);
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

    @RequestMapping(value = "/excel/insert-admin-excel-log", produces = "application/text; charset=utf-8")
    public void insertAdminExcelLog(@RequestParam("dataJson") String dataJson, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>() ;
        setting.put("아이디", "adminId");
        setting.put("휴대전화번호", "adminPhoneFull");
        setting.put("이메일", "adminEmailFull");

        excelService.excelLogDown(setting, dataJson,  response , request, fileSetting);
    }

    @RequestMapping("/excel/download-admin-excel")
    public void downloadAdminExcel(@RequestParam("dataJson") String dataJson, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        AdminVo adminVo =  new ObjectMapper().readValue(dataJson, AdminVo.class);

        List<Object> excelAdminList = (List<Object>) adminService.selectExcelAdminList(adminVo);

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>();
        setting.put("번호", "seq");
        setting.put("회원 아이디", "AdminId");
        setting.put("회원 이름", "AdminName");
        setting.put("휴대전화번호", "AdminPhoneFull");
        setting.put("생년월일", "AdminBirth");
        setting.put("이메일", "AdminEmailFull");
        setting.put("사용자 권한", "AdminRoleName");
        setting.put("등록일", "RegDt");

        // 개인정보 다운로드 로그 저장
        commonService.insertDownloadLog("[관리자 회원 관리] 관리자 회원 정보 다운로드");

        excelService.down(setting, excelAdminList, response , request, fileSetting);
    }

}
