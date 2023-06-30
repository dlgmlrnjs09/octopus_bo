package com.weaverloft.octopus.basic.promotion.coupon.controller;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.promotion.coupon.service.PromotionCouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-06-26
 */
@Controller
@RequestMapping("promotion/coupon")
public class PromotionCouponController {
    @Autowired
    private PromotionCouponService couponService;

    @GetMapping("/list")
    public String getPromotionCouponList() {
        return "/promotion/coupon/promotion-coupon-list.admin";
    }

    @GetMapping("/detail")
    public String getPromotionCouponDetail(Model model, @RequestParam(required = false) String seq) {
        String regType = "insert";

        if (!CommonUtil.isEmpty(seq)) {
            regType = "update";
            int couponSeq = Integer.parseInt(seq);
            Map<String, Object> couponDetailInfo = couponService.getPromotionCouponDetail(couponSeq);

            model.addAttribute("couponDetailInfo", couponDetailInfo);
        }

        model.addAttribute("regType", regType);
        return "/promotion/coupon/promotion-coupon-detail.admin";
    }

    @PostMapping("/submit-ajax/{regType}")
    @ResponseBody
    public Map<String, Object> submitPromotionCouponDetail(@RequestParam Map<String, Object> paramMap, @PathVariable String regType) {
        Map<String, Object> validateMap = new HashMap<>();

        try {
            validateMap = couponService.checkSubmitValidation(paramMap);
            if ("pass".equals(validateMap.get("name"))) {
                couponService.submitProductCoupon(paramMap, regType);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return validateMap;
    }

    @GetMapping("/select-coupon-popup")
    public String openSelectCouponPopup(Model model) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("coupon_issue_type", "conditional");
        paramMap.put("coupon_issue_condition_type", "order");
        List<Map<String, Object>> orderCouponList = couponService.getPromotionCouponList(paramMap);

        model.addAttribute("orderCouponList", orderCouponList);
        return "/popup/select-coupon-popup.admin";
    }
}
