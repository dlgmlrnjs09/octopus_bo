package com.weaverloft.octopus.basic.promotion.coupon.service;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.promotion.coupon.dao.PromotionCouponDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
@Service
public class PromotionCouponServiceImpl implements PromotionCouponService{

    @Autowired
    private PromotionCouponDao couponDao;

    @Override
    public List<Map<String, Object>> getPromotionCouponList(Map<String, Object> paramMap) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        resultList = couponDao.getPromotionCouponList(paramMap);
        return resultList;
    }

    @Override
    public Map<String, Object> getPromotionCouponDetail(int seq) {
        return couponDao.getPromotionCouponDetail(seq);
    }

    @Override
    public Map<String, Object> checkSubmitValidation(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = new HashMap<>();
        String name = "";
        String popupMsg = "";

        boolean isCouponIssuePerLimit = Boolean.parseBoolean((String) paramMap.get("is_coupon_issue_per_limit"));
        boolean isCouponIssueLimit = Boolean.parseBoolean((String) paramMap.get("is_coupon_issue_limit"));

        if (CommonUtil.isEmpty(paramMap.get("coupon_name"))) {
            name = "coupon_name";
            popupMsg = "쿠폰명을 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("coupon_description"))) {
            name = "coupon_description";
            popupMsg = "쿠폰설명을 입력해주세요.";
        } else if ("amount".equals(paramMap.get("coupon_benefit_type")) && CommonUtil.isEmpty(paramMap.get("coupon_benefit_amount"))) {
            name = "coupon_benefit_amount";
            popupMsg = "할인금액을 입력해주세요.";
        } else if ("percentage".equals(paramMap.get("coupon_benefit_type")) && CommonUtil.isEmpty(paramMap.get("coupon_benefit_percentage"))) {
            name = "coupon_benefit_percentage";
            popupMsg = "할인율을 입력해주세요.";
        } else if ("conditional".equals(paramMap.get("coupon_issue_type")) && CommonUtil.isEmpty(paramMap.get("coupon_issue_condition_type"))) {
            name = "coupon_issue_condition_type";
            popupMsg = "쿠폰발급 조건을 선택해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("coupon_coverage_type"))) {
            name = "coupon_coverage_type";
            popupMsg = "쿠폰 적용범위를 선택해주세요.";
        } else if (isCouponIssuePerLimit && CommonUtil.isEmpty(paramMap.get("coupon_issue_per_limit"))) {
            name = "coupon_issue_per_limit";
            popupMsg = "1인당 최대 발급수량을 입력해주세요.";
        } else if (isCouponIssueLimit && CommonUtil.isEmpty(paramMap.get("coupon_issue_limit"))) {
            name = "coupon_issue_limit";
            popupMsg = "쿠폰 최대 발급수량을 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("coupon_issue_start_date"))) {
            name = "coupon_issue_start_date";
            popupMsg = "쿠폰 발급 시작일을 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("coupon_issue_end_date"))) {
            name = "coupon_issue_end_date";
            popupMsg = "쿠폰 발급 종료일을 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("coupon_use_start_date"))) {
            name = "coupon_use_start_date";
            popupMsg = "쿠폰 사용 시작일을 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("coupon_use_end_date"))) {
            name = "coupon_end_start_date";
            popupMsg = "쿠폰 사용 종료일을 입력해주세요.";
        } else {
            name = "pass";

        }

        resultMap.put("name", name);
        resultMap.put("popupMsg", popupMsg);
        return resultMap;
    }

    @Override
    public boolean submitProductCoupon(Map<String, Object> paramMap, String regType) {
        int successCnt = 0;

        paramMap.put("is_coupon_issue_per_limit", Boolean.parseBoolean((String) paramMap.get("is_coupon_issue_per_limit")));
        paramMap.put("is_coupon_issue_limit", Boolean.parseBoolean((String) paramMap.get("is_coupon_issue_limit")));

        if ("insert".equals(regType)) {
            successCnt = couponDao.insertProductCoupon(paramMap);
        } else {
            successCnt = couponDao.updateProductCoupon(paramMap);
        }

        return successCnt > 0;
    }
}
