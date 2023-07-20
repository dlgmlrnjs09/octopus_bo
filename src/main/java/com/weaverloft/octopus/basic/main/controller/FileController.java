package com.weaverloft.octopus.basic.main.controller;

import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("file")
public class FileController {

    @Autowired
    FileService fileService;

    /**
     *  @brief 샘플 엑셀 다운로드
     *  @date 2023-06-21
     *  @return void
     *  @param Request, Response
     */
    @RequestMapping("/sampleExcelDown/{target}")
    public void sampleExcelDown(HttpServletRequest request, HttpServletResponse response, @PathVariable String target) throws Exception {

        String fileName = "";

        switch (target) {
            case "member":
                fileName = "memberExcelSample.xls";
                break;
            case "delivery":
                fileName = "deliveryExcelSample.xls";
                break;
        }

        String uploadDir = request.getServletContext().getRealPath("/asset/excel");
        String path = uploadDir + File.separator + fileName;

        File file = new File(path);

        String mimeType = "application/download; utf-8";
        int fileLength  = (int)file.length();
        setDisposition (fileName ,request, response);
        response.setContentType (mimeType);
        response.setContentLength (fileLength);
        if (fileLength > 0) {
            BufferedInputStream in = null;
            BufferedOutputStream out = null;
            try {
                in = new BufferedInputStream (new FileInputStream(file));
                out = new BufferedOutputStream (response.getOutputStream());
                FileCopyUtils.copy(in, out);
                out.flush();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (in != null) {
                    try {
                        in.close ();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                if (out != null) {
                    try {
                        in.close ();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    /**
     *  @brief 브라우저 별 컨텐츠 설정
     *  @date 2023-05-22
     *  @return void
     *  @param Request, Response, String
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String browser = getBrowser(request);

        String dispositionPrefix = "attachment; filename=";
        String encodedFilename = null;

        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Trident")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else {
            throw new IOException("Not supported browser");
        }

        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
        response.setHeader("Content-Transfer-Encoding", "binary");

        if ("Opera".equals(browser)){
            response.setContentType("application/octet-stream;charset=UTF-8");
        }
    }

    /**
     *  @brief 브라우저 정보
     *  @date 2023-05-22
     *  @return String
     *  @param Request
     */
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        //
        JFileChooser jtc = new JFileChooser();
        jtc.setFileFilter(new FileNameExtensionFilter("txt","txt"));

        //
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Trident") > -1) {
            return "Trident";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }

    /**
     * 에디터 이미지 업로드
     * @param request
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/image-upload")
    @ResponseBody
    public Map<String, Object> image(MultipartHttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int isSuccessUpload = 1;
        String realPath = "/asset/upload/img";

        try {
            MultipartFile uploadFile = request.getFile("upload");
            FileVo fileVo = fileService.saveFileProduct(uploadFile, request.getServletContext().getRealPath(realPath));
            fileVo.setIsUse(false);
            fileService.insertFileInfo(fileVo);

            String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + realPath + fileVo.getFilePath();
            resultMap.put("url", url);
            resultMap.put("fileName", fileVo.getOrginFileNm());
        } catch (Exception e) {
            isSuccessUpload = 0;
        }

        resultMap.put("uploaded", isSuccessUpload);
        return resultMap;
    }

    /**
     * 파일 다운로드
     * @param fileSeq
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/download/{fileSeq}")
    public void downloadFile(@PathVariable int fileSeq, HttpServletRequest request, HttpServletResponse response) throws Exception {

        try {

            Map<String, Object> fileMap = fileService.getFileObject(request, fileSeq);
            File file = (File) fileMap.get("file");
            String originName = (String) fileMap.get("originName");
            originName = new String(originName.getBytes("utf-8"), "iso-8859-1"); //파일명에 한글이 있는 경우 처리

            //다운로드 헤더 생성
            response.setHeader("Content-Type", "application/octet-stream;");
            response.setHeader("Content-Disposition", "attachment;filename=\"" + originName + "\";");
            response.setHeader("Content-Transfer-Encoding", "binary;");
            response.setContentLength((int) file.length());
            response.setHeader("Pragma", "no-cache;");
            response.setHeader("Expires", "-1;");

            FileUtils.copyFile(file, response.getOutputStream());
            response.getOutputStream().close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
