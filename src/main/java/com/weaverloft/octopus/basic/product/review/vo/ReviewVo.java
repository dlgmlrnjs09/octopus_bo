package com.weaverloft.octopus.basic.product.review.vo;

import com.weaverloft.octopus.basic.main.vo.PagingVo;

import java.util.List;

public class ReviewVo extends PagingVo {
    private int reviewSeq;
    private String reviewContent;
    private int productSeq;
    private String productName;
    private int optionCombineSeq;
    private String orderOption;
    private String regId;
    private String memberNm;
    private double starPoint;
    private int likeCount;
    private String regDt;
    private String udtDt;
    private String delDt;
    private String reviewImagePath;
    private List<Integer> reviewSeqList;
    private String orderType;
    private String sort;

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getReviewImagePath() {
        return reviewImagePath;
    }

    public void setReviewImagePath(String reviewImagePath) {
        this.reviewImagePath = reviewImagePath;
    }

    public List<Integer> getReviewSeqList() {
        return reviewSeqList;
    }

    public void setReviewSeqList(List<Integer> reviewSeqList) {
        this.reviewSeqList = reviewSeqList;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getOrderOption() {
        return orderOption;
    }

    public void setOrderOption(String orderOption) {
        this.orderOption = orderOption;
    }

    public String getMemberNm() {
        return memberNm;
    }

    public void setMemberNm(String memberNm) {
        this.memberNm = memberNm;
    }

    public int getReviewSeq() {
        return reviewSeq;
    }

    public void setReviewSeq(int reviewSeq) {
        this.reviewSeq = reviewSeq;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
    }

    public int getProductSeq() {
        return productSeq;
    }

    public void setProductSeq(int productSeq) {
        this.productSeq = productSeq;
    }

    public int getOptionCombineSeq() {
        return optionCombineSeq;
    }

    public void setOptionCombineSeq(int optionCombineSeq) {
        this.optionCombineSeq = optionCombineSeq;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public double getStarPoint() {
        return starPoint;
    }

    public void setStarPoint(double starPoint) {
        this.starPoint = starPoint;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getUdtDt() {
        return udtDt;
    }

    public void setUdtDt(String udtDt) {
        this.udtDt = udtDt;
    }

    public String getDelDt() {
        return delDt;
    }

    public void setDelDt(String delDt) {
        this.delDt = delDt;
    }
}
