package com.weaverloft.octopus.basic.member.vo;

import com.weaverloft.octopus.basic.main.vo.PagingVo;

import java.util.List;

public class MemberVo extends PagingVo {
    private int memberSeq;
    private String memberId;
    private String memberPw;
    private String memberNm;
    private String memberPhone1;
    private String memberPhone2;
    private String memberPhone3;
    private String memberPhoneFull;
    private String memberBirth;
    private String memberAddr1;
    private String memberAddr2;
    private String memberAddrDetail;
    private String memberAddrFull;
    private String memberZipCode;
    private String memberEmailId;
    private String memberEmailDomain;
    private String memberEmailFull;
    private int membershipSeq;
    private boolean isMembershipFixed;
    private String membershipName;
    private String flag;
    private String regDt;
    private boolean isUse;

    private List<Integer> membershipSeqList;

    private List<Integer> memberSeqList;

    public boolean getIsUse() {
        return isUse;
    }

    public void setIsUse(boolean isUse) {
        this.isUse = isUse;
    }

    public List<Integer> getMemberSeqList() {
        return memberSeqList;
    }

    public void setMemberSeqList(List<Integer> memberSeqList) {
        this.memberSeqList = memberSeqList;
    }

    public int getMemberSeq() {
        return memberSeq;
    }

    public void setMemberSeq(int memberSeq) {
        this.memberSeq = memberSeq;
    }

    public String getMemberPw() {
        return memberPw;
    }

    public void setMemberPw(String memberPw) {
        this.memberPw = memberPw;
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

    public String getMemberPhone1() {
        return memberPhone1;
    }

    public void setMemberPhone1(String memberPhone1) {
        this.memberPhone1 = memberPhone1;
    }

    public String getMemberPhone2() {
        return memberPhone2;
    }

    public void setMemberPhone2(String memberPhone2) {
        this.memberPhone2 = memberPhone2;
    }

    public String getMemberPhone3() {
        return memberPhone3;
    }

    public void setMemberPhone3(String memberPhone3) {
        this.memberPhone3 = memberPhone3;
    }

    public String getMemberPhoneFull() {
        return memberPhoneFull;
    }

    public void setMemberPhoneFull(String memberPhoneFull) {
        this.memberPhoneFull = memberPhoneFull;
    }

    public String getMemberBirth() {
        return memberBirth;
    }

    public void setMemberBirth(String memberBirth) {
        this.memberBirth = memberBirth;
    }

    public String getMemberAddr1() {
        return memberAddr1;
    }

    public void setMemberAddr1(String memberAddr1) {
        this.memberAddr1 = memberAddr1;
    }

    public String getMemberAddr2() {
        return memberAddr2;
    }

    public void setMemberAddr2(String memberAddr2) {
        this.memberAddr2 = memberAddr2;
    }

    public String getMemberAddrDetail() {
        return memberAddrDetail;
    }

    public void setMemberAddrDetail(String memberAddrDetail) {
        this.memberAddrDetail = memberAddrDetail;
    }

    public String getMemberAddrFull() {
        return memberAddrFull;
    }

    public void setMemberAddrFull(String memberAddrFull) {
        this.memberAddrFull = memberAddrFull;
    }

    public String getMemberZipCode() {
        return memberZipCode;
    }

    public void setMemberZipCode(String memberZipCode) {
        this.memberZipCode = memberZipCode;
    }

    public String getMemberEmailId() {
        return memberEmailId;
    }

    public void setMemberEmailId(String memberEmailId) {
        this.memberEmailId = memberEmailId;
    }

    public String getMemberEmailDomain() {
        return memberEmailDomain;
    }

    public void setMemberEmailDomain(String memberEmailDomain) {
        this.memberEmailDomain = memberEmailDomain;
    }

    public String getMemberEmailFull() {
        return memberEmailFull;
    }

    public void setMemberEmailFull(String memberEmailFull) {
        this.memberEmailFull = memberEmailFull;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public int getMembershipSeq() { return membershipSeq; }

    public void setMembershipSeq(int membershipSeq) { this.membershipSeq = membershipSeq; }

    public String getMembershipName() {
        return membershipName;
    }

    public void setMembershipName(String membershipName) {
        this.membershipName = membershipName;
    }

    public List<Integer> getMembershipSeqList() {
        return membershipSeqList;
    }
    public void setMembershipSeqList(List<Integer> membershipSeqList) {
        this.membershipSeqList = membershipSeqList;
    }

    public boolean getIsMembershipFixed() { return isMembershipFixed; }

    public void setIsMembershipFixed(boolean isMembershipFixed) { this.isMembershipFixed = isMembershipFixed; }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
}
