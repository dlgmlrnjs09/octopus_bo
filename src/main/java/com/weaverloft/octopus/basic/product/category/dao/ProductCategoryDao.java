package com.weaverloft.octopus.basic.product.category.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Mapper
public interface ProductCategoryDao {
    List<Map<String, Object>> getProductCategoryInfo(int parentCategorySeq);
    int insertProductCategoryInfo(Map<String, Object> paramMap);
    int updateProductCategoryInfo(Map<String, Object> paramMap);
    int deleteProductCategoryInfo(Map<String, Object> paramMap);
}
