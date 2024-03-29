package com.weaverloft.octopus.basic.product.management.controller;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.product.category.service.ProductCategoryService;
import com.weaverloft.octopus.basic.product.management.service.ProductMngService;
import org.springframework.beans.factory.HierarchicalBeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-24
 */
@Controller
@RequestMapping("product/management")
public class ProductMngController {

    @Autowired
    private ProductMngService productMngService;
    @Autowired
    private ProductCategoryService productCategoryService;

    @Autowired
    private FileService fileService;

    @RequestMapping("/list")
    public String getProductMngList(@RequestParam Map<String, Object> paramMap, Model model) {
        int currPage = CommonUtil.isEmpty((String) paramMap.get("curPage")) ? 1 : Integer.parseInt(paramMap.get("curPage").toString());
        int pageSize = CommonUtil.isEmpty((String) paramMap.get("pageSize")) ? 10 : Integer.parseInt(paramMap.get("pageSize").toString());

        int totalCnt = productMngService.getProductMngListCnt(paramMap);
        PagingModel pagingModel = PagingModel.getPagingModel(Integer.toString(currPage), Integer.toString(pageSize), totalCnt);
        pagingModel.setListCnt(totalCnt);

        if (totalCnt > 0) {
            paramMap.put("pagingModel", pagingModel);
            model.addAttribute("productMngList", productMngService.getProductMngList(paramMap));
        }

        model.addAttribute("pagingModel", pagingModel);
        model.addAttribute("startDate", paramMap.get("startDate"));
        model.addAttribute("endDate", paramMap.get("endDate"));
        model.addAttribute("search_keyword", paramMap.get("search_keyword"));
        model.addAttribute("search_type", paramMap.get("search_type"));

        return "/product/management/product-mng-list.admin";
    }

    @GetMapping("/detail")
    public String getProductMngDetail(Model model, @RequestParam(required = false) String seq) {
        String regType = "insert";

        try {
            // 최상위 카테고리 리스트
            List<Map<String, Object>> topCategoryList = productCategoryService.getChildCategoryInfo(0);

            // 수정
            if (!CommonUtil.isEmpty(seq)) {
                int productSeq = Integer.parseInt(seq);

                Map<String, Object> productDetailInfo = productMngService.getProductMngDetail(productSeq);
                List<Map<String, Object>> hierarchicalCategoryList = productCategoryService.getHierarchicalCategoryList((Integer) productDetailInfo.get("category_seq"), topCategoryList);
                List<Map<String, Object>> productOptionList = productMngService.getProductOptionList(productSeq);
                List<Map<String, Object>> productCombinationOptionList = productMngService.getCombinationOptionList(productSeq);

                FileVo fileVo = new FileVo();
                fileVo.setTypeDepth1("product");
                fileVo.setForeignSeqList(Arrays.asList(productSeq));
                List<Map<String, Object>> fileList = fileService.selectFileInfoList(fileVo);

                // 이미지를 썸네일(resize)로 변환
                for (Map<String, Object> thumbnail : fileList) {
                    String filePath = (String) thumbnail.get("file_path");
                    int lastSlashIndex = filePath.lastIndexOf("/");
                    StringBuffer sb = new StringBuffer();

                    sb.append(filePath);
                    sb.insert(lastSlashIndex+1, "s_");

                    thumbnail.put("file_path", sb);
                }

                model.addAttribute("productDetailInfo", productDetailInfo);                         // 상품 상세 정보
                model.addAttribute("productOptionList", productOptionList);                         // 옵션 명, 옵션 값
                model.addAttribute("productCombinationOptionList", productCombinationOptionList);   // 옵션 조합별 정보
                model.addAttribute("hierarchicalCategoryList", hierarchicalCategoryList);           // 차수 별 카테고리 목록, 선택된 카테고리 정보
                model.addAttribute("fileList", fileList);
                regType = "update";
            }

            model.addAttribute("topCategoryList", topCategoryList);
            model.addAttribute("regType", regType);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/product/management/product-mng-detail.admin";
    }

    @PostMapping("/submit-ajax/{regType}")
    @ResponseBody
    public Map<String, Object> submitProductMngDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model, @PathVariable String regType) {
        Map<String, Object> validateMap = new HashMap<>();
        boolean isHasOption = Boolean.parseBoolean((String) paramMap.get("is_has_option"));
        int productSeq = Integer.parseInt((String) paramMap.get("productSeq"));
        try {
            if ("insert".equals(regType)) {
                productSeq = productMngService.getProductNextSeq();
                paramMap.put("nextProductSeq", productSeq);
            }
            validateMap = productMngService.checkSubmitValidation(paramMap);
            if ("pass".equals(validateMap.get("name"))) {
                boolean isSuccessSubmit = productMngService.submitProductMng(paramMap, regType);
                if (isSuccessSubmit && isHasOption) {
                    productMngService.submitOptionMng(paramMap, regType);
                }
            }
            validateMap.put("productSeq", productSeq);

            //첨부파일 삭제
            String[] delSeqArr = request.getParameterValues("removeImages");
            if (delSeqArr != null && delSeqArr.length > 0) {

                for(String seq : delSeqArr) {
                    int fileSeq = Integer.parseInt(seq);
                    Map<String, Object> fileMap = fileService.getFileObject(request, fileSeq);
                    File file = (File) fileMap.get("file");

                    file.delete();
                    fileService.deleteFileInfo(fileSeq);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return validateMap;
    }

//    @GetMapping("/select-category-popup")
//    public String showProductCategoryPopup() {
//        return "";
//    }

}
