package com.weaverloft.octopus.basic.product.category.service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-19
 */
public interface ProductCategoryService {
    List<Map<String, Object>> getChildCategoryInfo(int parentCategorySeq);
    List<Map<String, Object>> getHierarchicalCategoryList(int currCategorySeq, List<Map<String, Object>> topCategoryList);
    boolean submitProductCategory(Map<String, Object> paramMap);
}
