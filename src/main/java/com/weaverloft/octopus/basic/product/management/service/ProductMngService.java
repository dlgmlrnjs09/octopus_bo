package com.weaverloft.octopus.basic.product.management.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.weaverloft.octopus.basic.common.util.PagingModel;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-24
 */
public interface ProductMngService {
    List<Map<String, Object>> getProductMngList(Map<String, Object> paramMap);
    int getProductMngListCnt(Map<String, Object> paramMap);
    Map<String, Object> getProductMngDetail(int productSeq);
    Map<String, Object> checkSubmitValidation(Map<String, Object> paramMap);
    List<Map<String, Object>> getProductOptionList(int productSeq);
    List<Map<String, Object>> getCombinationOptionList(int productSeq);
    int getProductNextSeq();
    boolean submitProductMng(Map<String, Object> paramMap, String regType) throws Exception;
    boolean submitOptionMng(Map<String, Object> paramMap, String regType) throws Exception;
}
