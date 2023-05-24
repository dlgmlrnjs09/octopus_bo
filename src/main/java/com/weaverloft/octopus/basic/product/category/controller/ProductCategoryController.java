package com.weaverloft.octopus.basic.product.category.controller;

import com.weaverloft.octopus.basic.product.category.service.ProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-18
 */
@Controller
@RequestMapping("product/category")
public class ProductCategoryController {

    @Autowired
    private ProductCategoryService categoryService;

    @GetMapping("/list")
    public String getProductCategoryList(Model model) {

        try {
            List<Map<String, Object>> categoryList = categoryService.getProductCategoryInfo(0);

            model.addAttribute("categoryList", categoryList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/product/category/product-category-list.admin";
    }

    @GetMapping("/get-child-category-ajax")
    @ResponseBody
    public List<Map<String, Object>> getChildCategoryAjax(int categorySeq) {
        List<Map<String, Object>> categoryList = new ArrayList<>();

        try {
            categoryList = categoryService.getProductCategoryInfo(categorySeq);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryList;
    }

    @PostMapping("/submit")
    @ResponseBody
    public boolean submitProductCategory(@RequestBody Map<String, Object> categoryInfoMap) {
        boolean isSuccess = false;

        try {
            isSuccess = categoryService.submitProductCategory(categoryInfoMap);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }
}
