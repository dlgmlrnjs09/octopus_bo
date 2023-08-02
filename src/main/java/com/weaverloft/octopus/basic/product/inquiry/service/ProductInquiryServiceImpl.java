package com.weaverloft.octopus.basic.product.inquiry.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weaverloft.octopus.basic.product.inquiry.dao.ProductInquiryDao;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-19
 */
@Service
public class ProductInquiryServiceImpl implements ProductInquiryService {

    @Autowired
    private ProductInquiryDao productInquiryDao;

    @Override
    public int insertProductInquiry(Map<String, Object> paramMap) {
        return productInquiryDao.insertProductInquiry(paramMap);
    }

    @Override
    public int updateProductInquiry(Map<String, Object> paramMap) {
        return productInquiryDao.updateProductInquiry(paramMap);
    }

    @Override
    public int deleteProductInquiry(Map<String, Object> paramMap) {
        return productInquiryDao.deleteProductInquiry(paramMap);
    }

    @Override
    public List<Map<String, Object>> selectInquiryList(Map<String, Object> paramMap) {
        return productInquiryDao.selectInquiryList(paramMap);
    }

    @Override
    public int selectCountInquiry(Map<String, Object> paramMap) {
        return productInquiryDao.selectCountInquiry(paramMap);
    }

    @Override
    public List<Map<String, Object>> selectInquiryDetail(int inquirySeq) {
        return productInquiryDao.selectInquiryDetail(inquirySeq);
    }
}
