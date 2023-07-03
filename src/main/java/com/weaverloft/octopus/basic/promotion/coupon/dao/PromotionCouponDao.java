package com.weaverloft.octopus.basic.promotion.coupon.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-06-26
 */
@Mapper
public interface PromotionCouponDao {
    int getPromotionCouponListCnt(Map<String, Object> paramMap);
    List<Map<String, Object>> getPromotionCouponList(Map<String, Object> paramMap);
    Map<String, Object> getPromotionCouponDetail(int seq);
    int insertProductCoupon(Map<String, Object> paramMap);
    int updateProductCoupon(Map<String, Object> paramMap);
}
