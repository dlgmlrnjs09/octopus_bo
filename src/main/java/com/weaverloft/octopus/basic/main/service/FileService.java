package com.weaverloft.octopus.basic.main.service;

import com.weaverloft.octopus.basic.main.vo.FileVO;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief File Service
 * @details 파일 관련 메소드
 * @date 2023-05-23
 */
public interface FileService {

	/**
	 *  @brief 엑셀 업로드시 파일 저장
	 *  @date 2023-05-23
	 *  @return FileVO
	 *  @param MultipartFile, String
	 */
	public FileVO saveFileProduct(MultipartFile file, String targetPath) throws Exception;
}
