package com.weaverloft.octopus.basic.product.category.service;

import com.weaverloft.octopus.basic.product.category.dao.ProductCategoryDao;
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
 * @date 2023-05-19
 */
@Service
public class ProductCategoryServiceImpl implements ProductCategoryService{

    @Autowired
    private ProductCategoryDao productCategoryDao;

    @Override
    public List<Map<String, Object>> getChildCategoryInfo(int parentCategorySeq) {
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        resultList = productCategoryDao.getChildCategoryInfo(parentCategorySeq);
        return resultList;
    }

//    @Override
//    public List<Map<String, Object>> getSiblingCategoryInfo(int currCategorySeq) {
//        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
//        resultList = productCategoryDao.getSiblingCategoryInfo(currCategorySeq);
//        return resultList;
//    }

    @Override
    public List<Map<String, Object>> getHierarchicalCategoryList(int currCategorySeq, List<Map<String, Object>> topCategoryList) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        Map<String, Object> hierarchicalInfo = productCategoryDao.getHierarchicalCategoryInfo(currCategorySeq);
        Integer[] categorySeqPathArr = (Integer[]) hierarchicalInfo.get("path");

        Map<String, Object> topInnerMap = new HashMap<>();
        // 최상위 카테고리 정보 SET
        topInnerMap.put("seq", categorySeqPathArr[0]);
        topInnerMap.put("list", topCategoryList);
        resultList.add(topInnerMap);
        // 등록된 카테고리 별 형제 카테고리 조회
        for (int i=1; i<categorySeqPathArr.length; i++) {
            Map<String, Object> innerMap = new HashMap<>();
            innerMap.put("seq", categorySeqPathArr[i]);
            innerMap.put("list", productCategoryDao.getSiblingCategoryInfo(categorySeqPathArr[i]));
            resultList.add(innerMap);
        }

        return resultList;
    }

    @Override
    public boolean submitProductCategory(Map<String, Object> paramMap) {
        String taskType = (String) paramMap.get("task_type");
        int successCnt = 0;

        if ("insert".equals(taskType)) {
            successCnt = productCategoryDao.insertProductCategoryInfo(paramMap);
        } else if ("update".equals(taskType)) {
            successCnt = productCategoryDao.updateProductCategoryInfo(paramMap);
        } else {
            successCnt = productCategoryDao.deleteProductCategoryInfo(paramMap);
        }

        return successCnt > 0;
    }
}
