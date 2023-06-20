package com.weaverloft.octopus.basic.product.management.dao;

import com.weaverloft.octopus.basic.common.util.PagingModel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-24
 */
@Mapper
public interface ProductMngDao {
    List<Map<String, Object>> getProductMngList(Map<String, Object> paramMap);
    int getProductMngListCnt(Map<String, Object> paramMap);
    int insertProductMng(Map<String, Object> paramMap);
    int updateProductMng(Map<String, Object> paramMap);
    int getProductNextSeq();
    Map<String, Object> getProductMngDetail(int productSeq);
    int insertProductOptionInfo(@Param("nextProductSeq") int nextProductSeq, @Param("optionList") List<Map<String, Object>> optionList);
    int insertProductOptionDetail(@Param("nextProductSeq") int nextProductSeq, @Param("optionSeq") int optionSeq, @Param("optionDetailList") List<Map<String, Object>> optionDetailList);
    int insertProductOptionCombination(@Param("nextProductSeq") int nextProductSeq, @Param("combinationParamList") List<Map<String, Object>> combinationParamList);
    int deleteProductOptionInfo(int productSeq);
    int deleteProductOptionDetail(int productSeq);
    int deleteProductOptionCombination(int productSeq);
    int updateProductOptionCombination(@Param("productSeq") int productSeq, @Param("optionCombinationList") List<Map<String, Object>> optionCombinationList);
    int getLastOptionSeq(int productSeq);
    List<Map<String, Object>> getProductFullOptionInfo(int productSeq);
    List<Map<String, Object>> getCombinationOptionList(int productSeq);
}
