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

import java.io.IOException;
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
    public Map<String, Object> checkSubmitValidation(Map<String, Object> paramMap){
        Map<String, Object> resultMap = new HashMap<>();
        String name = "";
        String popupMsg = "";

        boolean isHasOption = Boolean.parseBoolean((String) paramMap.get("is_has_option"));
        boolean isDiscount = Boolean.parseBoolean((String) paramMap.get("is_discount"));
        boolean isPayBuyPoint = Boolean.parseBoolean((String) paramMap.get("is_pay_buy_point"));
        boolean isPayNormalReviewPoint = Boolean.parseBoolean((String) paramMap.get("is_pay_normal_review_point"));
        boolean isPayMediaReviewPoint = Boolean.parseBoolean((String) paramMap.get("is_pay_media_review_point"));
        boolean isSetProductOrderCoupon = Boolean.parseBoolean((String) paramMap.get("is_set_product_order_coupon"));
        boolean isValidOption = true;

        List<Map<String, Object>> optionList = new ArrayList<>();
        List<Map<String, Object>> optionCombinationList = new ArrayList<>();

        if (isHasOption) {
            try {
                // 옵션 파싱
                ObjectMapper objectMapper = new ObjectMapper();
                optionList = objectMapper.readValue((String) paramMap.get("optionList"), new TypeReference<List<Map<String, Object>>>() {});
                // 옵션 별 가격, 재고수량 파싱
                optionCombinationList = objectMapper.readValue((String) paramMap.get("optionCombinationList"), new TypeReference<List<Map<String, Object>>>() {});

                if (optionCombinationList.size() <= 0) {
                    isValidOption = false;
                } else {
                    // 옵션 유효성 체크
                    outOptionListLoop:
                    for (Map<String, Object> optionMap : optionList) {
                        if (CommonUtil.isEmpty(optionMap.get("name"))) {
                            isValidOption = false;
                            break;
                        }
                        List<Map<String, Object>> values = (List<Map<String, Object>>) optionMap.get("values");
                        if (values.size() <= 0) {
                            isValidOption = false;
                            break;
                        }
                        for (Map<String, Object> valueMap : values) {
                            if (CommonUtil.isEmpty(valueMap.get("name"))) {
                                isValidOption = false;
                                break outOptionListLoop;
                            }
                        }
                    }
                    // 옵션 조합 유효성 체크
                    for (Map<String, Object> optionCombineMap : optionCombinationList) {
                        if (CommonUtil.isEmpty(optionCombineMap.get("price"), optionCombineMap.get("stock"))) {
                            isValidOption = false;
                            break;
                        }
                    }
                }
            } catch (IOException e) {
                isValidOption = false;
            }
        }

        if (CommonUtil.isEmpty(paramMap.get("product_name"))) {
            name = "product_name";
            popupMsg = "상품명을 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("category_seq"))) {
            name = "category_seq";
            popupMsg = "카테고리를 선택해주세요. 카테고리는 3차 카테고리까지 선택되어야 합니다.";
        } else if (isHasOption && !isValidOption) {
            name = "option_invalid";
            popupMsg = "올바른 옵션 정보를 입력해주세요.";
        } else if (!isHasOption && CommonUtil.isEmpty(paramMap.get("product_stock"))) {
            name = "product_stock";
            popupMsg = "상품 재고를 입력해주세요.";
        } else if (CommonUtil.isEmpty(paramMap.get("product_price"))) {
            name = "product_price";
            popupMsg = "상품 가격을 입력해주세요.";
        } else if (isDiscount && CommonUtil.isEmpty(paramMap.get("discount_price"))) {
            name = "discount_price";
            popupMsg = "할인 금액을 입력해주세요.";
        } else if ("condition".equals(paramMap.get("delivery_condition")) && CommonUtil.isEmpty(paramMap.get("default_delivery_charge_conditional"))) {
            name = "default_delivery_charge_conditional";
            popupMsg = "기본 배송비를 입력해주세요.";
        } else if ("condition".equals(paramMap.get("delivery_condition")) && CommonUtil.isEmpty(paramMap.get("condition_delivery_charge"))) {
            name = "condition_delivery_charge";
            popupMsg = "배송비 조건을 입력해주세요.";
        } else if ("charge".equals(paramMap.get("delivery_condition")) && CommonUtil.isEmpty(paramMap.get("default_delivery_charge"))) {
            name = "default_delivery_charge";
            popupMsg = "기본 배송비를 입력해주세요.";
        } else if (isSetProductOrderCoupon && CommonUtil.isEmpty(paramMap.get("product_order_coupon_seq"))) {
            name = "product_order_coupon_seq";
            popupMsg = "상품주문 쿠폰을 선택해주세요.";
        } else if (isPayBuyPoint && CommonUtil.isEmpty(paramMap.get("pay_buy_point"))) {
            name = "pay_buy_point";
            popupMsg = "지급할 구매포인트를 입력해주세요.";
        } else if (isPayNormalReviewPoint && CommonUtil.isEmpty(paramMap.get("pay_normal_review_point"))) {
            name = "pay_normal_review_point";
            popupMsg = "지급할 텍스트리뷰 포인트를 입력해주세요.";
        } else if (isPayMediaReviewPoint && CommonUtil.isEmpty(paramMap.get("pay_media_review_point"))) {
            name = "pay_media_review_point";
            popupMsg = "지급할 미디어리뷰 포인트를 입력해주세요.";
        } else {
            name = "pass";
        }

        resultMap.put("name", name);
        resultMap.put("popupMsg", popupMsg);
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
        paramMap.put("is_set_product_order_coupon", Boolean.parseBoolean((String) paramMap.get("is_set_product_order_coupon")));

        if ("insert".equals(regType)) {
            successCnt = productMngDao.insertProductMng(paramMap);
        } else {
            successCnt = productMngDao.updateProductMng(paramMap);
        }

        return successCnt > 0;
    }

    @Override
    public void submitOptionMng(Map<String, Object> paramMap, String regType) throws Exception {

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
    }
}
