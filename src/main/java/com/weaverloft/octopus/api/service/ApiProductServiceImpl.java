package com.weaverloft.octopus.api.service;

import com.weaverloft.octopus.api.dao.ApiProductDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ApiProductServiceImpl implements ApiProductService {

    @Autowired
    ApiProductDao apiProductDao;

    @Override
    public Map<String, Object> selectProductDetail(int productSeq) {
        return apiProductDao.selectProductDetail(productSeq);
    }

    @Override
    public List<Map<String, Object>> selectRecommendedProductList(Map<String, Object> paramMap) {
        return apiProductDao.selectRecommendedProductList(paramMap);
    }

    @Override
    public void setProductViews(int productSeq) {
        apiProductDao.setProductViews(productSeq);
    }

}
