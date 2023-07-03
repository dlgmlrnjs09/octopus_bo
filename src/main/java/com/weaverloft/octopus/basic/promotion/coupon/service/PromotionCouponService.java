package com.weaverloft.octopus.basic.promotion.coupon.service;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-06-26
 */
public interface PromotionCouponService {
    int getPromotionCouponListCnt(Map<String, Object> paramMap);
    List<Map<String, Object>> getPromotionCouponList(Map<String, Object> paramMap);
    Map<String, Object> getPromotionCouponDetail(int seq);
    Map<String, Object> checkSubmitValidation(Map<String, Object> paramMap);
    boolean submitProductCoupon(Map<String, Object> paramMap, String regType);
}
