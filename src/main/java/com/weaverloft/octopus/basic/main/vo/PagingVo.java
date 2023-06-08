package com.weaverloft.octopus.basic.main.vo;

import com.weaverloft.octopus.basic.common.util.PagingModel;

public class PagingVo {
    private String pageSize;
    private String curPage;
    private PagingModel pagingModel;

    private String startDate;
    private String endDate;
    private String searchType;
    private String searchKeyword;

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public PagingModel getPagingModel() {
        return pagingModel;
    }

    public void setPagingModel(PagingModel pagingModel) {
        this.pagingModel = pagingModel;
    }

    public String getPageSize() {
        return pageSize;
    }

    public void setPageSize(String pageSize) {
        this.pageSize = pageSize;
    }

    public String getCurPage() {
        return curPage;
    }

    public void setCurPage(String curPage) {
        this.curPage = curPage;
    }
}
