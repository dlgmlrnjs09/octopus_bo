package com.weaverloft.octopus.basic.main.vo;

import com.weaverloft.octopus.basic.common.util.PagingModel;

public class PagingVo {
    private String pageSize;
    private String curPage;
    private PagingModel pagingModel;

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
