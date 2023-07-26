package com.weaverloft.octopus.api.service;

import java.util.List;
import java.util.Map;

public interface ApiReviewService {

    /**
     * 상품 리뷰 리스트
     * @param paramMap
     * @return
     */
    List<Map<String, Object>> selectProductReviewList(Map<String, Object> paramMap);

    /**
     * 상품 리뷰 개수
     * @param productSeq
     * @return
     */
    int selectReviewCnt(int productSeq);

    /**
     * 상품 리뷰 평점
     * @param productSeq
     * @return
     */
    double selectReviewAvg(int productSeq);

    /**
     * 리뷰 평점별 개수 집계
     * @param productSeq
     * @return
     */
    List<Map<String,Object>> selectReviewCountList(int productSeq);

    /**
     * 리뷰 작성
     * @param paramMap
     * @return
     */
    int insertProductReview(Map<String, Object> paramMap);

    /**
     * 리뷰 수정
     * @param paramMap
     * @return
     */
    int updateProductReview(Map<String, Object> paramMap);

    /**
     * 리뷰 삭제
     * @param paramMap
     * @return
     */
    int deleteProductReview(Map<String, Object> paramMap);

    /**
     * 리뷰 추천수 업데이트
     * @param paramMap
     * @return
     */
    int updateLikeCount(Map<String, Object> paramMap);
}
