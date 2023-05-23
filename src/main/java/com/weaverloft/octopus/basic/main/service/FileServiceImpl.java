package com.weaverloft.octopus.basic.main.service;

import com.weaverloft.octopus.basic.main.vo.FileVO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.UUID;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief File Service
 * @details 파일 관련 메소드
 * @date 2023-05-23
 */
@SuppressWarnings("Duplicates")
@Service("fileService")
public class FileServiceImpl implements FileService{
	
	@Override
	public FileVO saveFileProduct(MultipartFile file, String targetPath) throws Exception {
		String strgeFileNm = UUID.randomUUID().toString();
		String strgePath = getDatePath();
		String ext = "";
		if(file.getOriginalFilename().indexOf(".") != -1){
			ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			if(ext != null && !"".equals(ext)){
				ext = ext.toLowerCase();
				strgeFileNm = strgeFileNm + ext;
			}
		}
		File targetFile = new File(targetPath + strgePath +strgeFileNm);
		if (!targetFile.exists() || targetFile.isFile()) {
			targetFile.mkdirs();
		}
		file.transferTo(targetFile);
		FileVO vo = new FileVO(file, strgeFileNm, strgePath);
		return vo;
	}

	private String getDatePath() {
		Calendar calVal = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String today = dateFormat.format(calVal.getTime());

		StringBuffer datePath = new StringBuffer();
		datePath.append("/")
			.append(today.substring(0, 4)).append("/")
			.append(today.substring(4, 6)).append("/")
			.append(today.substring(6, 8)).append("/");

		return datePath.toString();
	}

	
}
