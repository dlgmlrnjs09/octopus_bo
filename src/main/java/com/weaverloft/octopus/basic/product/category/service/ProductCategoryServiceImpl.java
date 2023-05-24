package com.weaverloft.octopus.basic.product.category.service;

import com.weaverloft.octopus.basic.product.category.dao.ProductCategoryDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    public List<Map<String, Object>> getProductCategoryInfo(int parentCategorySeq) {
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        resultList = productCategoryDao.getProductCategoryInfo(parentCategorySeq);
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
