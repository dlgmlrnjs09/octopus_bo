package com.weaverloft.octopus.basic.product.review.service;

import com.weaverloft.octopus.basic.product.review.vo.ReviewVo;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface ReviewService {
    int selectReviewCount(ReviewVo reviewVo);

    Map<String, Object> selectReviewCountForMainPage(ReviewVo reviewVo);

    List<ReviewVo> selectReviewList(ReviewVo reviewVo);

    ReviewVo getReviewDetail(ReviewVo reviewVo);

    List<String> getReviewImagePathList(ReviewVo reviewVo);

    List<?> selectExcelReviewList(ReviewVo reviewVo);
}
