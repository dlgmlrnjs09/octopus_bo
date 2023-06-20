package com.weaverloft.octopus.basic.product.management.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.product.management.dao.ProductMngDao;
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
 * @date 2023-05-24
 */
@Service
public class ProductMngServiceImpl implements ProductMngService{

    @Autowired
    private ProductMngDao productMngDao;

    @Override
    public List<Map<String, Object>> getProductMngList(Map<String, Object> paramMap) {
        return productMngDao.getProductMngList(paramMap);
    }

    @Override
    public int getProductMngListCnt(Map<String, Object> paramMap) {
        return productMngDao.getProductMngListCnt(paramMap);
    }

    @Override
    public Map<String, Object> getProductMngDetail(int productSeq) {
        return productMngDao.getProductMngDetail(productSeq);
    }

    @Override
    public List<Map<String, Object>> getProductOptionList(int productSeq) {
        List<Map<String, Object>> fullOptionInfoList = productMngDao.getProductFullOptionInfo(productSeq);
        // ,로 구분 -> 배열로 변환 후 SET
        for (Map<String, Object> fullOptionInfo : fullOptionInfoList) {
            String[] optionDetailSeqArr = ((String) fullOptionInfo.get("option_detail_seq_arr")).split(",");
            String[] optionDetailNameArr = ((String) fullOptionInfo.get("option_detail_name_arr")).split(",");

            List<Map<String, Object>> innerMapList = new ArrayList<>();
            for (int i=0; i<optionDetailSeqArr.length; i++) {
                Map<String, Object> innerMap = new HashMap<>();
                innerMap.put("seq", optionDetailSeqArr[i]);
                innerMap.put("name", optionDetailNameArr[i]);
                innerMapList.add(innerMap);
            }

            fullOptionInfo.put("option_detail_list", innerMapList);
        }
        return fullOptionInfoList;
    }

    @Override
    public List<Map<String, Object>> getCombinationOptionList(int productSeq) {
        List<Map<String, Object>> optionDetailInfoList = productMngDao.getCombinationOptionList(productSeq);
//        for (Map<String, Object> optionDetailInfo : optionDetailInfoList) {
//            List<Map<String, Object>> innerMapList = new ArrayList<>();
//            for (int i=1; i<=3; i++) {
//                Integer optionDetailSeq = (Integer) optionDetailInfo.get("option_detail_seq_" + i);
//
//                if (!CommonUtil.isEmpty(optionDetailSeq)) {
//                    Map<String, Object> innerMap = new HashMap<>();
//                    innerMap.put("index", i);
//                    innerMap.put("seq", optionDetailSeq);
//                    innerMap.put("name", optionDetailInfo.get("option_detail_name_" + i));
//                    innerMapList.add(innerMap);
//                }
//            }
//
//            optionDetailInfo.put("option_detail_map", innerMapList);
//        }

        return optionDetailInfoList;
    }

    @Override
    public Map<String, Object> checkSubmitValidation(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = new HashMap<>();
        return resultMap;
    }

    @Override
    public int getProductNextSeq() {
        return productMngDao.getProductNextSeq();
    }

    @Override
    public boolean submitProductMng(Map<String, Object> paramMap, String regType) throws Exception {
        int successCnt = 0;

        String deliveryCondition = (String) paramMap.get("delivery_condition");
        boolean isUseConditionalDelivery = false;
        if ("free".equals(deliveryCondition)) {
            paramMap.put("delivery_charge", 0);
        } else if ("condition".equals(deliveryCondition)) {
            paramMap.put("delivery_charge", paramMap.get("default_delivery_charge_conditional"));
            isUseConditionalDelivery = true;
        } else {    // charge
            paramMap.put("delivery_charge", paramMap.get("default_delivery_charge"));
        }
        paramMap.put("is_use_conditional_delivery", isUseConditionalDelivery);

        paramMap.put("is_discount", Boolean.parseBoolean((String) paramMap.get("is_discount")));
        paramMap.put("is_pay_buy_point", Boolean.parseBoolean((String) paramMap.get("is_pay_buy_point")));
        paramMap.put("is_pay_normal_review_point", Boolean.parseBoolean((String) paramMap.get("is_pay_normal_review_point")));
        paramMap.put("is_pay_media_review_point", Boolean.parseBoolean((String) paramMap.get("is_pay_media_review_point")));
        paramMap.put("is_has_option", Boolean.parseBoolean((String) paramMap.get("is_has_option")));

        if ("insert".equals(regType)) {
            successCnt = productMngDao.insertProductMng(paramMap);
        } else {
            successCnt = productMngDao.updateProductMng(paramMap);
        }

        return successCnt > 0;
    }

    @Override
    public boolean submitOptionMng(Map<String, Object> paramMap, String regType) throws Exception {
        int successCnt = 0;
        // 옵션 INSERT/UPDATE 여부
        boolean isOptionUpdateYn = "Y".equals((String) paramMap.get("isOptionUpdateYn"));

        // 옵션 파싱
        ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> optionList = objectMapper.readValue((String) paramMap.get("optionList"), new TypeReference<List<Map<String, Object>>> () {});
        // 옵션 별 가격, 재고수량 파싱
        List<Map<String, Object>> optionCombinationList = objectMapper.readValue((String) paramMap.get("optionCombinationList"), new TypeReference<List<Map<String, Object>>> () {});

        int productSeq = 0;
        if ("insert".equals(regType)) {
          productSeq = (Integer) paramMap.get("nextProductSeq");
        } else {
            productSeq = Integer.parseInt((String) paramMap.get("productSeq"));
        }

//        if (isOptionUpdateYn) {
//
//        } else {
            // 옵션 별 시퀀스 부여
            int optionDetailSeq = 0;
            int lastOptionSeq = productMngDao.getLastOptionSeq(productSeq);
            for (int i=0; i<optionList.size(); i++) {
                Map<String, Object> option = optionList.get(i);
                lastOptionSeq++;
                option.put("optionSeq", lastOptionSeq);
                // 옵션 디테일 시퀀스 부여
                List<Map<String, Object>> valueMapList = (List<Map<String, Object>>) option.get("values");
                for (Map<String, Object> value : valueMapList) {
                    optionDetailSeq++;
                    value.put("optionDetailSeq", optionDetailSeq);
                }
            }
            // 옵션 정보 저장 - product_option_info
            productMngDao.deleteProductOptionInfo(productSeq);
            if (productMngDao.insertProductOptionInfo(productSeq, optionList) > 0) {
                // 상세옵션 정보 저장 - product_option_detail
                productMngDao.deleteProductOptionDetail(productSeq);
                // TODO : Mybatis Foreach 로 처리되도록 수정 해야함
                for (Map<String, Object> option : optionList) {
                    int optionSeq = (Integer) option.get("optionSeq");
                    List<Map<String, Object>> optionDetailList = (List<Map<String, Object>>) option.get("values");
                    productMngDao.insertProductOptionDetail(productSeq, optionSeq, optionDetailList);
                }

                if (isOptionUpdateYn) {
                    productMngDao.updateProductOptionCombination(productSeq, optionCombinationList);
                } else {
                    // 옵션 조합별 정보 저장 - product_option_combine_info
                    List<Map<String, Object>> combinationParamList = new ArrayList<>();
                    for (Map<String, Object> optionCombination : optionCombinationList) {
                        List<String> indexList = (List<String>) optionCombination.get("indices");

                        Map<String, Object> combinationParamMap = new HashMap<>();
                        List<Map<String, Object>> targetColList = new ArrayList<>();
                        for (int i = 0; i < indexList.size(); i++) {
                            Map<String, Object> targetColMap = new HashMap<>();
                            int indexByArray = Integer.parseInt(indexList.get(i));
                            targetColMap.put("colName", "option_detail_seq_" + (i + 1));
                            List<Map<String, Object>> optionDetailList = (List<Map<String, Object>>) optionList.get(i).get("values");
                            targetColMap.put("colValue", optionDetailList.get(indexByArray).get("optionDetailSeq"));
                            targetColList.add(targetColMap);
                        }
                        combinationParamMap.put("targetColList", targetColList);
                        combinationParamMap.put("price", optionCombination.get("price"));
                        combinationParamMap.put("stock", optionCombination.get("stock"));
                        combinationParamList.add(combinationParamMap);
                    }

                    productMngDao.deleteProductOptionCombination(productSeq);
                    productMngDao.insertProductOptionCombination(productSeq, combinationParamList);
                }
            }
//        }

        return successCnt > 0;
    }
}
