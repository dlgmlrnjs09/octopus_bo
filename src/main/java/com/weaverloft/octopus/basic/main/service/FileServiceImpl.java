package com.weaverloft.octopus.basic.main.service;

import com.weaverloft.octopus.basic.main.dao.FileDao;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
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

	@Autowired
    private FileDao fileDao;

    public int insertFileInfo(FileVo fileVo) {
        return fileDao.insertFileInfo(fileVo);
    }

	@Override
	public FileVo saveFileProduct(MultipartFile file, String targetPath) throws Exception {
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
		File targetFile = new File(targetPath + strgePath + strgeFileNm);
		if (!targetFile.exists() || targetFile.isFile()) {
			targetFile.mkdirs();
		}
		file.transferTo(targetFile);
		FileVo vo = new FileVo(file, strgeFileNm, strgePath);
		return vo;
	}

	public Map<String, Object> selectFileInfo(FileVo fileVo) {
    	return fileDao.selectFileInfo(fileVo);
	}

	public int updateFileInfo(FileVo fileVo) {
    	return fileDao.updateFileInfo(fileVo);
	}

	public List<Map<String, Object>> selectFileInfoList(FileVo fileVo) {
    	return fileDao.selectFileInfoList(fileVo);
	}

	@Override
	public int deleteFileInfo(int fileSeq) {
		return fileDao.deleteFileInfo(fileSeq);
	}

	public void createThumbnailFile(File saveFile, String saveName) throws IOException {

//        try{
//            // thumbnailaotor 라이브러리 사용
//            File thumbnailFile = new File(uploadPath, "s_" + saveName);
//
//            BufferedImage bo_image = ImageIO.read(saveFile);
//
//            /* 비율 */
//            double ratio = 3;
//            /*넓이 높이*/
//            int width = (int) (bo_image.getWidth() / ratio);
//            int height = (int) (bo_image.getHeight() / ratio);
//
//            Thumbnails.of(saveFile)
//                    .size(width, height)
//                    .toFile(thumbnailFile);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
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
