package com.weaverloft.octopus.basic.admin.vo;

import com.weaverloft.octopus.basic.main.vo.PagingVo;

import java.util.List;

public class AdminVo extends PagingVo {
    private int adminSeq;
    private String adminId;
    private String adminPw;
    private String adminName;
    private String adminPhone1;
    private String adminPhone2;
    private String adminPhone3;
    private String adminPhoneFull;
    private String adminBirth;
    private String adminEmailId;
    private String adminEmailDomain;
    private String adminEmailFull;
    private boolean isDormant;
    private String adminRole;
    private String adminRoleId;
    private String adminRoleName;
    private String regDt;
    private String udtDt;
    private List<Integer> adminSeqList;

    public int getAdminSeq() {
        return adminSeq;
    }

    public void setAdminSeq(int adminSeq) {
        this.adminSeq = adminSeq;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminPw() {
        return adminPw;
    }

    public void setAdminPw(String adminPw) {
        this.adminPw = adminPw;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPhone1() {
        return adminPhone1;
    }

    public void setAdminPhone1(String adminPhone1) {
        this.adminPhone1 = adminPhone1;
    }

    public String getAdminPhone2() {
        return adminPhone2;
    }

    public void setAdminPhone2(String adminPhone2) {
        this.adminPhone2 = adminPhone2;
    }

    public String getAdminPhone3() {
        return adminPhone3;
    }

    public void setAdminPhone3(String adminPhone3) {
        this.adminPhone3 = adminPhone3;
    }

    public String getAdminPhoneFull() {
        return adminPhoneFull;
    }

    public void setAdminPhoneFull(String adminPhoneFull) {
        this.adminPhoneFull = adminPhoneFull;
    }

    public String getAdminBirth() {
        return adminBirth;
    }

    public void setAdminBirth(String adminBirth) {
        this.adminBirth = adminBirth;
    }

    public String getAdminEmailId() {
        return adminEmailId;
    }

    public void setAdminEmailId(String adminEmailId) {
        this.adminEmailId = adminEmailId;
    }

    public String getAdminEmailDomain() {
        return adminEmailDomain;
    }

    public void setAdminEmailDomain(String adminEmailDomain) {
        this.adminEmailDomain = adminEmailDomain;
    }

    public String getAdminEmailFull() {
        return adminEmailFull;
    }

    public void setAdminEmailFull(String adminEmailFull) {
        this.adminEmailFull = adminEmailFull;
    }

    public boolean getIsDormant() {
        return isDormant;
    }

    public void setIsDormant(boolean dormant) {
        isDormant = dormant;
    }

    public String getAdminRole() {
        return adminRole;
    }

    public void setAdminRole(String adminRole) {
        this.adminRole = adminRole;
    }

    public String getAdminRoleId() {
        return adminRoleId;
    }

    public void setAdminRoleId(String adminRoleId) {
        this.adminRoleId = adminRoleId;
    }

    public String getAdminRoleName() {
        return adminRoleName;
    }

    public void setAdminRoleName(String adminRoleName) {
        this.adminRoleName = adminRoleName;
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

    public List<Integer> getAdminSeqList() {
        return adminSeqList;
    }

    public void setAdminSeqList(List<Integer> adminSeqList) {
        this.adminSeqList = adminSeqList;
    }
}
