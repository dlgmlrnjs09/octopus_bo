package com.weaverloft.octopus.basic.product.review.dao;

import com.weaverloft.octopus.basic.product.review.vo.ReviewVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Mapper
public interface ReviewDao {
    int selectReviewCount(ReviewVo reviewVo);

    List<ReviewVo> selectReviewCountForMainPage(ReviewVo reviewVo);

    List<ReviewVo> selectReviewList(ReviewVo reviewVo);

    ReviewVo getReviewDetail(ReviewVo reviewVo);

    List<String> getReviewImagePathList(ReviewVo reviewVo);

    List<?> selectExcelReviewList(ReviewVo reviewVo);
}
