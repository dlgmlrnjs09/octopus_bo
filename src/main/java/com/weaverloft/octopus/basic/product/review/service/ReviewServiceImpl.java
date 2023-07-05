package com.weaverloft.octopus.basic.product.review.service;

import com.weaverloft.octopus.basic.product.review.dao.ReviewDao;
import com.weaverloft.octopus.basic.product.review.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Service
public class ReviewServiceImpl implements ReviewService{
    @Autowired
    private ReviewDao reviewDao;

    public int selectReviewCount(ReviewVo reviewVo) { return reviewDao.selectReviewCount(reviewVo); }

    public Map<String, Object> selectReviewCountForMainPage(ReviewVo reviewVo) {
        LocalDate currentDate = LocalDate.now();

        int totalCount = reviewDao.selectReviewCount(reviewVo);

        reviewVo.setStartDate(currentDate.format(DateTimeFormatter.ISO_DATE));
        reviewVo.setEndDate(currentDate.format(DateTimeFormatter.ISO_DATE));

        int todayCount = reviewDao.selectReviewCount(reviewVo);
        List<ReviewVo> reviewList = reviewDao.selectReviewCountForMainPage(reviewVo);

        Map<String, Object> countMap = new HashMap<>();

        countMap.put("totalCount", totalCount);
        countMap.put("todayCount", todayCount);
        countMap.put("reviewList", reviewList);

        return countMap;
    }

    public List<ReviewVo> selectReviewList(ReviewVo reviewVo) { return reviewDao.selectReviewList(reviewVo); }

    public ReviewVo getReviewDetail(ReviewVo reviewVo) { return reviewDao.getReviewDetail(reviewVo); }

    public List<String> getReviewImagePathList(ReviewVo reviewVo) { return reviewDao.getReviewImagePathList(reviewVo); }

    public List<?> selectExcelReviewList(ReviewVo reviewVo) { return reviewDao.selectExcelReviewList(reviewVo); }
}
