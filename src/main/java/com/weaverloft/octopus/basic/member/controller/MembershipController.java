package com.weaverloft.octopus.basic.member.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.member.service.MembershipService;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

/**
 * @author heuijin yang
 * @version 0.0.1
 * @brief 회원 관리
 * @details 회원 조회
 * @date 2023-07-12
 */

@Controller
@RequestMapping("/member/membership")
public class MembershipController {

    @Autowired
    MembershipService membershipService;

    @Autowired
    FileService fileService;

    @GetMapping("/main")
    public String showMembershipMainPage(Model model) {

        List<Map<String, Object>> membershipList = membershipService.selectMembershipList();
        int sumOrderPeriod = membershipService.getSumOrderPeriod();

        model.addAttribute("membershipList", membershipList);
        model.addAttribute("sumOrderPeriod", sumOrderPeriod);

        return "/member/membership/membership-main.admin";
    }

    @GetMapping("detail")
    public String showMembershipDetail(@RequestParam(required = false) String seq, HttpServletRequest request, Model model) {

        if (!CommonUtil.isEmpty(seq)) {
            int membershipSeq = Integer.parseInt(seq);

            Map<String, Object> detailMap = membershipService.selectMembershipInfo(membershipSeq);

            FileVo fileVo = new FileVo();
            fileVo.setTypeDepth1("membership");
            fileVo.setForeignSeq(membershipSeq);
            Map<String, Object> fileInfo = fileService.selectFileInfo(fileVo);
            if (fileInfo != null) {
                model.addAttribute("filePath", fileInfo.get("file_path"));
            }
            model.addAttribute("membershipDetail", detailMap);
            model.addAttribute("flag", "update");
        } else {
            model.addAttribute("flag", "insert");
        }

        model.addAttribute("maxMembershipPriority", membershipService.getMaxMembershipPriority());

        return "/member/membership/membership-detail.admin";
    }

    @ResponseBody
    @PostMapping("/submit/{flag}")
    public Map<String, Object> submitMembership(@RequestParam Map<String, Object> paramMap, @PathVariable String flag, MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {

        Map<String, Object> resultMap = new HashMap<>();
        int isSuccess = 0;
        int membershipSeq = 0;
        boolean isAuto = Boolean.parseBoolean((String) paramMap.get("membershipIsAuto"));

        try {

            if ("insert".equals(flag) || "update".equals(flag)) {
                if (isAuto && membershipService.selectCountMembershipInfo(paramMap) > 0) {
                    resultMap.put("result", "duplicate");
                    resultMap.put("msg", "기준 누적금액과 동일한 등급이 존재합니다.");
                    return resultMap;
                }

                String[] benefitFlags = request.getParameterValues("benefitFlags");
                String benefitFlag = "";
                if (benefitFlags != null && benefitFlags.length > 0) {
                    benefitFlag = Arrays.toString(benefitFlags);

                    if (benefitFlag.contains("discount")) paramMap.put("hasDiscount", true);
                    if (benefitFlag.contains("mileage")) paramMap.put("hasMileage", true);
                    if (benefitFlag.contains("delivery")) paramMap.put("hasDelivery", true);
                }
                paramMap.put("benefitFlag", benefitFlag);
            } else if ("delete".equals(flag)) {
                if ("1".equals((String) paramMap.get("membershipSeq") )) {
                    resultMap.put("result", "unable");
                    resultMap.put("msg", "기본등급은 삭제하실 수 없습니다.");
                    return resultMap;
                }
            }

            switch (flag) {
                case "insert" :
                    isSuccess = membershipService.insertMembership(paramMap);
                    membershipSeq = (int) paramMap.get("membershipSeq");
                    break;
                case "update" :
                    isSuccess = membershipService.updateMembership(paramMap);
                    membershipSeq = Integer.parseInt((String)paramMap.get("membershipSeq"));
                    break;
                case "delete" :
                    isSuccess = membershipService.deleteMembership(paramMap);
                    membershipSeq = Integer.parseInt((String)paramMap.get("membershipSeq"));
                    break;
            }
            if (isSuccess > 0) {
                resultMap.put("result", "OK");

                String realPath = request.getServletContext().getRealPath("/asset/upload/img");
                File dir = new File(realPath);
                if (!dir.isDirectory()) {
                    dir.mkdirs();
                }
                CommonsMultipartFile fileIcon = (CommonsMultipartFile) multipartRequest.getFile("fileIcon");
                FileVo fileIconVO = new FileVo();

                if ("insert".equals(flag) || "update".equals(flag)) {
                    if(fileIcon.getSize()!=0){
                        fileIconVO = fileService.saveFileProduct(fileIcon, realPath);

                        fileIconVO.setTypeDepth1("membership");
                        fileIconVO.setForeignSeq(membershipSeq);

                        Map<String, Object> currFileIconMap = fileService.selectFileInfo(fileIconVO);
                        if(currFileIconMap == null) {
                            fileService.insertFileInfo(fileIconVO);
                        } else {
                            fileService.updateFileInfo(fileIconVO);
                        }
                    }
                } else if ("delete".equals(flag)) {

                    fileIconVO.setTypeDepth1("membership");
                    fileIconVO.setForeignSeq(membershipSeq);

                    Map<String, Object> fileInfo = fileService.selectFileInfo(fileIconVO);
                    if (fileInfo != null) {
                        String filePath = (String) fileInfo.get("file_path");
                        File file = new File(realPath + filePath);
                        file.delete();
                        fileService.deleteFileInfo((Integer) fileInfo.get("seq"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", "error");
            resultMap.put("msg", "처리에 실패했습니다.");
        }

        return resultMap;
    }

    @ResponseBody
    @PostMapping("/priority/update")
    public Map<String, Object> updateMembershipPriority (@RequestParam Map<String, Object> params) {

        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> paramMap = new HashMap<>();
        int isSuccess = 0;

        try {
            String json = StringEscapeUtils.unescapeHtml(params.get("paramList").toString());
            ObjectMapper mapper = new ObjectMapper();
            List<Map<String, Object>> paramList = mapper.readValue(json, new TypeReference<ArrayList<Map<String,Object>>>(){});

            for (Map<String, Object> param : paramList) {
                paramMap.put("membershipPriority", Integer.parseInt((String) param.get("membershipPriority")));
                paramMap.put("membershipSeq", (int) param.get("membershipSeq"));

                isSuccess += membershipService.updateMembershipPriority(paramMap);
            }

            if (isSuccess > 0) {
                resultMap.put("result", "success");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", "error");
            resultMap.put("msg", "처리에 실패했습니다.");
        }

        return resultMap;
    }

    @ResponseBody
    @PostMapping("/update-peroid/{sumOrderPeriod}")
    public String updateSumOrderPeriod(@PathVariable int sumOrderPeriod) {

        try {
            membershipService.updateSumOrderPeriod(sumOrderPeriod);
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }

        return "success";
    }
}
