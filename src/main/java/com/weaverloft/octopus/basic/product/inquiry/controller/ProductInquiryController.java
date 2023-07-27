package com.weaverloft.octopus.basic.product.inquiry.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.product.inquiry.service.ProductInquiryService;
import com.weaverloft.octopus.basic.security.CustomUserDetails;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-07-26
 */
@Controller
@RequestMapping("product/inquiry")
public class ProductInquiryController {

    @Autowired
    private ProductInquiryService productInquiryService;

    @GetMapping("/list")
    public String getProductInquiryList(Model model, @RequestParam Map<String, Object> paramMap) {

        try {
            int currPage = CommonUtil.isEmpty((String) paramMap.get("curPage")) ? 1 : Integer.parseInt(paramMap.get("curPage").toString());
            int pageSize = CommonUtil.isEmpty((String) paramMap.get("pageSize")) ? 10 : Integer.parseInt(paramMap.get("pageSize").toString());

            int totalCnt = productInquiryService.selectCountInquiry(paramMap);

            PagingModel pagingModel = PagingModel.getPagingModel(Integer.toString(currPage), Integer.toString(pageSize), totalCnt);
            pagingModel.setListCnt(totalCnt);

            if (totalCnt > 0) {
                paramMap.put("pagingModel", pagingModel);
                model.addAttribute("inquiryList", productInquiryService.selectInquiryList(paramMap));
            }

            model.addAttribute("pagingModel", pagingModel);
            model.addAttribute("startDate", paramMap.get("startDate"));
            model.addAttribute("endDate", paramMap.get("endDate"));
            model.addAttribute("searchKeyword", paramMap.get("searchKeyword"));
            model.addAttribute("searchType", paramMap.get("searchType"));
            model.addAttribute("hasAnswer", paramMap.get("hasAnswer"));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/product/inquiry/inquiry-list.admin";
    }

    @GetMapping("/detail")
    public String getProductInquiryDetail(Model model, @RequestParam Map<String, Object> paramMap, @RequestParam int inquirySeq, Authentication authentication) {

        //Session
        CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
        String id = user.getUsername();

        try {
            List<Map<String, Object>> inquiryDetail = productInquiryService.selectInquiryDetail(inquirySeq);

            model.addAttribute("data", inquiryDetail);
            model.addAttribute("flag", inquiryDetail.size() > 1 ? "update" : "insert");
            model.addAttribute("sessionId", id);
            //페이징 & 검색 유지
            model.addAttribute("curPage", paramMap.get("curPage"));
            model.addAttribute("pageSize", paramMap.get("pageSize"));
            model.addAttribute("startDate", paramMap.get("startDate"));
            model.addAttribute("endDate", paramMap.get("endDate"));
            model.addAttribute("searchKeyword", paramMap.get("searchKeyword"));
            model.addAttribute("searchType", paramMap.get("searchType"));
            model.addAttribute("hasAnswer", paramMap.get("hasAnswer"));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/product/inquiry/inquiry-detail.admin";
    }

    @ResponseBody
    @PostMapping("/submit/{flag}")
    public Map<String, Object> submitInquiryAnswerData(@RequestParam Map<String, Object> paramMap, @PathVariable String flag) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            switch (flag) {
                case "insert":
                    productInquiryService.insertProductInquiry(paramMap);
                    break;
                case "update":
                    productInquiryService.updateProductInquiry(paramMap);
                    break;
            }

            resultMap.put("result", "OK");
        } catch (Exception e) {
            resultMap.put("result", "failed");
        }

        return resultMap;
    }

    @RequestMapping("/excel-download")
    public void getInquiryListExcelFile(@RequestParam("dataJson") String dataJson, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
        LocalDate nowDate = LocalDate.now();
        String fileNm = nowDate+".xls";

        List<Map<String, Object>> list = productInquiryService.selectInquiryList(paramMap);

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>();
        setting.put("번호", "seq");
        setting.put("상품명", "");
        setting.put("제목", "");
        setting.put("내용", "");
        setting.put("회원 아이디", "");
        setting.put("등록일시", "");
        setting.put("답변 완료 여부", "");

    }
}
