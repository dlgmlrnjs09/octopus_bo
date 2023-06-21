package com.weaverloft.octopus.basic.order.vo;

import com.weaverloft.octopus.basic.main.vo.PagingVo;

import java.util.List;
import java.util.Map;

public class OrderVo extends PagingVo {
    private int orderSeq;
    private String orderNo;
    private int memberSeq;
    private String memberId;
    private String memberNm;
    private String memberPhoneFull;

    private int orderProductSeq;
    private String productName;
    private int productPrice;
    private int orderProductStock;
    private Map<String, Object> product;

    private String orderStatus;
    private String orderToName;
    private String orderToPhone1;
    private String orderToPhone2;
    private String orderToPhone3;
    private String orderToPhoneFull;
    private String orderToAddr1;
    private String orderToAddr2;
    private String orderToAddrDetail;
    private String orderToAddrFull;
    private String orderToZipCode;
    private int orderTotalPrice;
    private String orderOption;
    private String orderDeliveryNo;
    private String orderDeliveryComment;
    private String orderDeliveryCd;
    private String returnDeliveryNo;
    private String returnDeliveryCd;
    private String regDt;
    private String udtDt;
    private List<Integer> orderSeqList;
    private List<String> orderStatusList;
    private List<Map<String, Object>> productList;

    public String getOrderOption() {
        return orderOption;
    }

    public void setOrderOption(String orderOption) {
        this.orderOption = orderOption;
    }

    public List<String> getOrderStatusList() {
        return orderStatusList;
    }

    public void setOrderStatusList(List<String> orderStatusList) {
        this.orderStatusList = orderStatusList;
    }

    public String getReturnDeliveryNo() {
        return returnDeliveryNo;
    }

    public void setReturnDeliveryNo(String returnDeliveryNo) {
        this.returnDeliveryNo = returnDeliveryNo;
    }

    public String getReturnDeliveryCd() {
        return returnDeliveryCd;
    }

    public void setReturnDeliveryCd(String returnDeliveryCd) {
        this.returnDeliveryCd = returnDeliveryCd;
    }

    public int getOrderProductStock() {
        return orderProductStock;
    }

    public void setOrderProductStock(int orderProductStock) {
        this.orderProductStock = orderProductStock;
    }

    public Map<String, Object> getProduct() {
        return product;
    }

    public void setProduct(Map<String, Object> product) {
        this.product = product;
    }

    public int getOrderProductSeq() {
        return orderProductSeq;
    }

    public void setOrderProductSeq(int orderProductSeq) {
        this.orderProductSeq = orderProductSeq;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public List<Map<String, Object>> getProductList() {
        return productList;
    }

    public void setProductList(List<Map<String, Object>> productList) {
        this.productList = productList;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberNm() {
        return memberNm;
    }

    public void setMemberNm(String memberNm) {
        this.memberNm = memberNm;
    }

    public String getMemberPhoneFull() {
        return memberPhoneFull;
    }

    public void setMemberPhoneFull(String memberPhoneFull) {
        this.memberPhoneFull = memberPhoneFull;
    }

    public int getOrderSeq() {
        return orderSeq;
    }

    public void setOrderSeq(int orderSeq) {
        this.orderSeq = orderSeq;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public int getMemberSeq() {
        return memberSeq;
    }

    public void setMemberSeq(int memberSeq) {
        this.memberSeq = memberSeq;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderToName() {
        return orderToName;
    }

    public void setOrderToName(String orderToName) {
        this.orderToName = orderToName;
    }

    public String getOrderToPhone1() {
        return orderToPhone1;
    }

    public void setOrderToPhone1(String orderToPhone1) {
        this.orderToPhone1 = orderToPhone1;
    }

    public String getOrderToPhone2() {
        return orderToPhone2;
    }

    public void setOrderToPhone2(String orderToPhone2) {
        this.orderToPhone2 = orderToPhone2;
    }

    public String getOrderToPhone3() {
        return orderToPhone3;
    }

    public void setOrderToPhone3(String orderToPhone3) {
        this.orderToPhone3 = orderToPhone3;
    }

    public String getOrderToPhoneFull() {
        return orderToPhoneFull;
    }

    public void setOrderToPhoneFull(String orderToPhoneFull) {
        this.orderToPhoneFull = orderToPhoneFull;
    }

    public String getOrderToAddr1() {
        return orderToAddr1;
    }

    public void setOrderToAddr1(String orderToAddr1) {
        this.orderToAddr1 = orderToAddr1;
    }

    public String getOrderToAddr2() {
        return orderToAddr2;
    }

    public void setOrderToAddr2(String orderToAddr2) {
        this.orderToAddr2 = orderToAddr2;
    }

    public String getOrderToAddrDetail() {
        return orderToAddrDetail;
    }

    public void setOrderToAddrDetail(String orderToAddrDetail) {
        this.orderToAddrDetail = orderToAddrDetail;
    }

    public String getOrderToAddrFull() {
        return orderToAddrFull;
    }

    public void setOrderToAddrFull(String orderToAddrFull) {
        this.orderToAddrFull = orderToAddrFull;
    }

    public String getOrderToZipCode() {
        return orderToZipCode;
    }

    public void setOrderToZipCode(String orderToZipCode) {
        this.orderToZipCode = orderToZipCode;
    }

    public int getOrderTotalPrice() {
        return orderTotalPrice;
    }

    public void setOrderTotalPrice(int orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }

    public String getOrderDeliveryNo() {
        return orderDeliveryNo;
    }

    public void setOrderDeliveryNo(String orderDeliveryNo) {
        this.orderDeliveryNo = orderDeliveryNo;
    }

    public String getOrderDeliveryComment() {
        return orderDeliveryComment;
    }

    public void setOrderDeliveryComment(String orderDeliveryComment) {
        this.orderDeliveryComment = orderDeliveryComment;
    }

    public String getOrderDeliveryCd() {
        return orderDeliveryCd;
    }

    public void setOrderDeliveryCd(String orderDeliveryCd) {
        this.orderDeliveryCd = orderDeliveryCd;
    }

    public String getUdtDt() {
        return udtDt;
    }

    public void setUdtDt(String udtDt) {
        this.udtDt = udtDt;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public List<Integer> getOrderSeqList() {
        return orderSeqList;
    }

    public void setOrderSeqList(List<Integer> orderSeqList) {
        this.orderSeqList = orderSeqList;
    }
}
