package com.weaverloft.octopus.basic.product.review.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.ExcelService;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.product.review.service.ReviewService;
import com.weaverloft.octopus.basic.product.review.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hyojeong kim
 * @version 0.0.1
 * @brief 리뷰 관리
 * @details 리뷰 조회
 * @date 2023-06-30
 */
@Controller
@RequestMapping("product/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CommonService commonService;

    /** File Service */
    @Autowired
    protected FileService fileService;

    /** ExcelService */
    @Autowired
    ExcelService excelService;

    @GetMapping("/main")
    public String showReviewMainPage(Model model) {
        return "/product/review/review-main.admin";
    }

    @PostMapping("/select-review-list")
    @ResponseBody
    public ModelAndView selectReviewList(Model model, @RequestBody ReviewVo reviewVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = reviewService.selectReviewCount(reviewVo);

            PagingModel pagingModel = PagingModel.getPagingModel(reviewVo.getCurPage(), reviewVo.getPageSize(), count);
            reviewVo.setPagingModel(pagingModel);

            List<ReviewVo> reviewList = reviewService.selectReviewList(reviewVo);

            for(ReviewVo review : reviewList) {
                // 개인정보 마스킹
                if(review.getMemberNm() != null) {
                    review.setMemberNm(CommonUtil.maskingName(review.getMemberNm()));
                }
            }

            mv.setViewName("/product/review/setReviewList");
            mv.addObject("reviewList", reviewList);
            mv.addObject("pagingModel", pagingModel);
        }catch (Exception e) {
            System.out.println(e);

            mv.setViewName("404");
            return mv;
        }

        return mv;
    }

    @PostMapping("/select-review-count")
    @ResponseBody
    public Map<String, Object> selectReviewCount(Model model, @RequestBody ReviewVo reviewVo) {
        Map<String, Object> countMap = new HashMap<>();

        try{
            countMap = reviewService.selectReviewCountForMainPage(reviewVo);
        }catch (Exception e) {
            System.out.println(e);
        }

        return countMap;
    }

    @GetMapping("/review-detail")
    public String loadReviewDetail(Model model, @ModelAttribute ReviewVo reviewVo) {

        try{
            ReviewVo review = reviewService.getReviewDetail(reviewVo);
            List<String> filePathList = reviewService.getReviewImagePathList(reviewVo);

            model.addAttribute("filePathList", filePathList);
            model.addAttribute("review", review);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "/product/review/review-detail.admin";
    }

    @RequestMapping("/excel/download-review-excel")
    public void downloadReviewExcel(@RequestParam("dataJson") String dataJson, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        ReviewVo reviewVo =  new ObjectMapper().readValue(dataJson, ReviewVo.class);

        List<Object> excelReviewList = (List<Object>) reviewService.selectExcelReviewList(reviewVo);

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>();
        setting.put("번호", "seq");
        setting.put("상품명", "ProductName");
        setting.put("상품 옵션", "OrderOption");
        setting.put("내용", "ReviewContent");
        setting.put("회원 아이디", "RegId");
        setting.put("회원 이름", "MemberNm");
        setting.put("평점", "StarPoint");
        setting.put("추천수", "LikeCount");
        setting.put("등록일시", "RegDt");

        // 개인정보 다운로드 로그 저장
        commonService.insertDownloadLog("[리뷰 관리] 리뷰 정보 다운로드");

        excelService.down(setting, excelReviewList, response , request, fileSetting);
    }
    
}
