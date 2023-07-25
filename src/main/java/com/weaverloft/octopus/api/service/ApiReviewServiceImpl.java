package com.weaverloft.octopus.api.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weaverloft.octopus.api.dao.ApiReviewDao;

@Service
public class ApiReviewServiceImpl implements ApiReviewService {

    @Autowired
    ApiReviewDao apiReviewDao;

    @Override
    public List<Map<String, Object>> selectProductReviewList(Map<String, Object> paramMap) {
        return apiReviewDao.selectProductReviewList(paramMap);
    }

    @Override
    public int selectReviewCnt(int productSeq) {
        return apiReviewDao.selectReviewCnt(productSeq);
    }

    @Override
    public double selectReviewAvg(int productSeq) {
        return apiReviewDao.selectReviewAvg(productSeq);
    }

    @Override
    public List<Map<String, Object>> selectReviewCountList(int productSeq) {
        return apiReviewDao.selectReviewCountList(productSeq);
    }

    @Override
    public int insertProductReview(Map<String, Object> paramMap) {
        return apiReviewDao.insertProductReview(paramMap);
    }

    @Override
    public int updateProductReview(Map<String, Object> paramMap) {
        return apiReviewDao.updateProductReview(paramMap);
    }

    @Override
    public int deleteProductReview(Map<String, Object> paramMap) {
        return apiReviewDao.deleteProductReview(paramMap);
    }

    @Override
    public int updateLikeCount(Map<String, Object> paramMap) {
        return apiReviewDao.updateLikeCount(paramMap);
    }
}
