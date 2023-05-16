package com.weaverloft.octopus.basic.common.util;

public class PagingModel {

    /**
     * 한 페이지당 게시글 수
     **/
    private int pageSize = 10;

    /**
     * 한 블럭(range)당 페이지 수
     **/
    private int rangeSize = 5;

    /**
     * 현재 페이지
     **/
    private int curPage = 1;

    /**
     * 현재 블럭(range)
     **/
    private int curRange = 1;

    /**
     * 총 게시글 수
     **/
    private int listCnt;

    /**
     * 총 페이지 수
     **/
    private int pageCnt;

    /**
     * 총 블럭(range) 수
     **/
    private int rangeCnt;

    /**
     * 시작 페이지
     **/
    private int startPage = 1;

    /**
     * 끝 페이지
     **/
    private int endPage = 1;

    /**
     * 시작 index
     **/
    private int startIndex = 0;

    private int endIndex = 0;

    /**
     * 이전 페이지
     **/
    private int prevPage;

    /**
     * 다음 페이지
     **/
    private int nextPage;

    /**
     * 첫 페이지
     **/
    private int firstPage = 1;

    public int getPageSize() {
        return pageSize;
    }

    public int getFirstPage() {
        return firstPage;
    }

    public void setFirstPage(int firstPage) {
        this.firstPage = (int) 1;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getRangeSize() {
        return rangeSize;
    }

    public void setRangeSize(int rangeSize) {
        this.rangeSize = rangeSize;
    }

    public int getCurPage() {
        return curPage;
    }

    public void setCurPage(int curPage) {
        this.curPage = curPage;
    }

    public int getCurRange() {
        return curRange;
    }

    public void setCurRange(int curRange) {
        this.curRange = (int) ((curPage - 1) / rangeSize) + 1;
    }

    public int getListCnt() {
        return listCnt;
    }

    public void setListCnt(int listCnt) {
        this.listCnt = listCnt;
    }

    public int getPageCnt() {
        return pageCnt;
    }

    public void setPageCnt(int pageCnt) {
        this.pageCnt = (int) Math.ceil(listCnt * 1.0 / pageSize);
    }

    public int getRangeCnt() {
        return rangeCnt;
    }

    public void setRangeCnt(int rangeCnt) {
        this.rangeCnt = (int) Math.ceil(pageCnt * 1.0 / rangeSize);
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(int startIndex) {
        this.startIndex = (curPage - 1) * pageSize + 1;
    }

    public int getEndIndex() {
        return endIndex;
    }

    public void setEndIndex(int endIndex) {
        this.endIndex = curPage * pageSize;
    }

    public int getPrevPage() {
        return prevPage;
    }

    public void setPrevPage(int prevPage) {
        this.prevPage = prevPage;
    }

    public int getNextPage() {
        return nextPage;
    }

    public void setNextPage(int nextPage) {
        this.nextPage = nextPage;
    }

    public void rangeSetting(int curPage) {

        setCurRange(curPage);
        this.startPage = (curRange - 1) * rangeSize + 1;
        this.endPage = startPage + rangeSize - 1;

        if (endPage > pageCnt) {
            this.endPage = pageCnt;
        }

        int prevDiv = (curPage % 5 == 0) ? 5 : curPage % 5 ;

        int nextDiv = 0;
        if(curPage % 5 == 0){
            nextDiv = 1;
        }else if(curPage % 5 == 1){
            nextDiv = 5;
        }else if(curPage % 5 == 2){
            nextDiv = 4;
        }else if(curPage % 5 == 3){
            nextDiv = 3;
        }else if(curPage % 5 == 4){
            nextDiv = 2;
        }

        this.prevPage = curPage - prevDiv;
        this.nextPage = curPage + nextDiv;

        if (prevPage < firstPage) {
            this.prevPage = firstPage;
        }

        if (nextPage > pageCnt) {
            this.nextPage = pageCnt;
        }
    }

    public static PagingModel getPagingModel(String curPage, String pageSize, int totalCnt) {
        int currPage = CommonUtil.isEmpty(curPage) ? 1 : Integer.parseInt(curPage);
        int pgSize = CommonUtil.isEmpty(pageSize) ? 10 : Integer.parseInt(pageSize);
        return new PagingModel(totalCnt, totalCnt <= 10 ? 1 : currPage, pgSize);
    }

    /**
     * 페이징 처리 순서 1. 총 페이지수 2. 총 블럭(range)수 3. range setting
     *
     * @return
     */
    public PagingModel(int listCnt, int curPage, int setPage) {

        // 총 게시물 수와 현재 페이지를 Controller로 부터 받아온다.
        /** 한페이지내 보여줄 갯수**/
        setPageSize(setPage);

        /** 현재페이지 **/
        setCurPage(curPage);

        /** 총 게시물 수 **/
        setListCnt(listCnt);

        /** 1. 총 페이지 수 **/
        setPageCnt(listCnt);

        /** 2. 총 블럭(range)수 **/
        setRangeCnt(pageCnt);

        /** 3. 블럭(range) setting **/
        rangeSetting(curPage);

        /** DB 질의를 위한 startIndex 설정 **/
        setStartIndex(curPage);
        setEndIndex(curPage);

    }
}
