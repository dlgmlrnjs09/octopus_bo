package com.weaverloft.octopus.basic.main.vo;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief File VO
 * @details 파일 관련 Model
 * @date 2023-05-23
 */
@Alias("fileVO")
public class FileVo {
	
	private static final long serialVersionUID = -1576075827829555851L;

	/** 첨부파일 아이디 */
    private String atchFileId;
    /** 파일 순번 */
    private int fileSeq;
    /** 원본 파일 명 */
    private String orginFileNm;
    /** 파일명 */
    private String realFileNm;
    /** 저장 파일 명 */
    private String strgeFileNm;
    /** 저장 경로 */
    private String strgePath;
    /** 파일 확장자 */
    private String fileExtsnmn;
    /** 파일 크기 */
    private String fileSize;
    /** 파일 설명 */
    private String fileDesc = "";
    /** 임시 여부 */
    private String tempYn;
    /** 등록 일자 */
    private String regDate;
    /** 삭제 여부 */
    private String delYn;
    /** 첨부변환 ID */
    private String docZoomId;
    
    /** 정렬순서 */
    private String orderBy;

    private File targetFile;

    private Integer seq;
    private String typeDepth1;
    private String typeDepth2;
    private String typeDepth3;
    private String filePath;
    private Integer foreignSeq;
    private boolean isUse;
    private String redDt;
    private String modDt;
    private String delDt;
    private List<Integer> menuSeqList;
    
    /* 이미지 CROP용 */
    private Integer imgX;
    private Integer imgY;
    private Integer imgW;
    private Integer imgH;
    private Integer oldImgW;
    private Integer oldImgH;
    private String cropImgID;
    private String cropNameSpace;

	public List<Integer> getMenuSeqList() {
		return menuSeqList;
	}

	public void setMenuSeqList(List<Integer> menuSeqList) {
		this.menuSeqList = menuSeqList;
	}

	public File getTargetFile() {
		return targetFile;
	}

	public void setTargetFile(File targetFile) {
		this.targetFile = targetFile;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getTypeDepth1() {
		return typeDepth1;
	}

	public void setTypeDepth1(String typeDepth1) {
		this.typeDepth1 = typeDepth1;
	}

	public String getTypeDepth2() {
		return typeDepth2;
	}

	public void setTypeDepth2(String typeDepth2) {
		this.typeDepth2 = typeDepth2;
	}

	public String getTypeDepth3() {
		return typeDepth3;
	}

	public void setTypeDepth3(String typeDepth3) {
		this.typeDepth3 = typeDepth3;
	}

	public Integer getForeignSeq() {
		return foreignSeq;
	}

	public void setForeignSeq(Integer foreignSeq) {
		this.foreignSeq = foreignSeq;
	}

	public boolean getIsUse() {
		return isUse;
	}

	public void setIsUse(boolean use) {
		isUse = use;
	}

	public String getRedDt() {
		return redDt;
	}

	public void setRedDt(String redDt) {
		this.redDt = redDt;
	}

	public String getModDt() {
		return modDt;
	}

	public void setModDt(String modDt) {
		this.modDt = modDt;
	}

	public String getDelDt() {
		return delDt;
	}

	public void setDelDt(String delDt) {
		this.delDt = delDt;
	}

	/**
	 * @return the orderBy
	 */
	public String getOrderBy() {
		return orderBy;
	}

	/**
	 * @param orderBy the orderBy to set
	 */
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public Integer getOldImgW() {
		return oldImgW;
	}

	public void setOldImgW(Integer oldImgW) {
		this.oldImgW = oldImgW;
	}

	public Integer getOldImgH() {
		return oldImgH;
	}

	public void setOldImgH(Integer oldImgH) {
		this.oldImgH = oldImgH;
	}

	public String getCropNameSpace() {
		return cropNameSpace;
	}

	public void setCropNameSpace(String cropNameSpace) {
		this.cropNameSpace = cropNameSpace;
	}

	public String getCropImgID() {
		return cropImgID;
	}

	public void setCropImgID(String cropImgID) {
		this.cropImgID = cropImgID;
	}

	public String getDocZoomId() {
		return docZoomId;
	}

	public void setDocZoomId(String docZoomId) {
		this.docZoomId = docZoomId;
	}

	public FileVo() {
    	
    }
    
    public String getRealFileNm() {
		return realFileNm;
	}

	public void setRealFileNm(String realFileNm) {
		this.realFileNm = realFileNm;
	}

	public FileVo(String atchFileId) {
    	this.atchFileId = atchFileId;
    }
    
    public FileVo(String atchFileId, int fileSeq) {
    	this.atchFileId = atchFileId;
    	this.fileSeq = fileSeq;
    }
    
    public FileVo(MultipartFile file) {
    	this.orginFileNm = file.getOriginalFilename();
    	this.fileExtsnmn = getFileExt(this.orginFileNm);
    	this.fileSize = Long.toString(file.getSize());
    }
    
    public FileVo(MultipartFile file, String strgeFileNm, String strgePath) {
    	this.orginFileNm = file.getOriginalFilename();	// file_org_name
    	this.fileExtsnmn = getFileExt(this.orginFileNm);	// file_extension
    	this.fileSize = Long.toString(file.getSize());	// file_size
    	this.strgeFileNm = strgeFileNm;	// file_saved_name
    	this.strgePath = strgePath;
		this.filePath = strgePath + strgeFileNm; // file_path
    }
    
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getOrginFileNm() {
		return orginFileNm;
	}
	public void setOrginFileNm(String orginFileNm) {
		this.orginFileNm = orginFileNm;
	}
	public String getStrgeFileNm() {
		return strgeFileNm;
	}
	public void setStrgeFileNm(String strgeFileNm) {
		this.strgeFileNm = strgeFileNm;
	}
	public String getStrgePath() {
		return strgePath;
	}
	public void setStrgePath(String strgePath) {
		this.strgePath = strgePath;
	}
	public String getFileExtsnmn() {
		return fileExtsnmn;
	}
	public void setFileExtsnmn(String fileExtsnmn) {
		this.fileExtsnmn = fileExtsnmn;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileDesc() {
		return fileDesc;
	}
	public void setFileDesc(String fileDesc) {
		this.fileDesc = fileDesc;
	}
	public String getTempYn() {
		return tempYn;
	}
	public void setTempYn(String tempYn) {
		this.tempYn = tempYn;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getFileExt(String orginFileName) {
		int index = orginFileName.lastIndexOf(".");
		String fileExt = orginFileName.substring(index + 1);
		return fileExt;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	public Integer getImgX() {
		return imgX;
	}

	public void setImgX(Integer imgX) {
		this.imgX = imgX;
	}

	public Integer getImgY() {
		return imgY;
	}

	public void setImgY(Integer imgY) {
		this.imgY = imgY;
	}

	public Integer getImgW() {
		return imgW;
	}

	public void setImgW(Integer imgW) {
		this.imgW = imgW;
	}

	public Integer getImgH() {
		return imgH;
	}

	public void setImgH(Integer imgH) {
		this.imgH = imgH;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}