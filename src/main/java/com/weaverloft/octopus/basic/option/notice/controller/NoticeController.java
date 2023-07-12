package com.weaverloft.octopus.basic.option.notice.controller;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.option.notice.service.NoticeService;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-07-05
 */
@Controller
@RequestMapping("notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @Autowired
    protected FileService fileService;

    @RequestMapping("/list")
    public String showNoticeListPage(@RequestParam Map<String, Object> paramMap, Model model) {

        int currPage = CommonUtil.isEmpty((String) paramMap.get("curPage")) ? 1 : Integer.parseInt(paramMap.get("curPage").toString());
        int pageSize = CommonUtil.isEmpty((String) paramMap.get("pageSize")) ? 10 : Integer.parseInt(paramMap.get("pageSize").toString());

        int totalCnt = noticeService.selectNoticeListCnt(paramMap);

        PagingModel pagingModel = PagingModel.getPagingModel(Integer.toString(currPage), Integer.toString(pageSize), totalCnt);
        pagingModel.setListCnt(totalCnt);

        if (totalCnt > 0) {
            paramMap.put("pagingModel", pagingModel);
            model.addAttribute("noticeList", noticeService.selectNoticeList(paramMap));
        }

        model.addAttribute("pagingModel", pagingModel);
        model.addAttribute("startDate", paramMap.get("startDate"));
        model.addAttribute("endDate", paramMap.get("endDate"));
        model.addAttribute("searchKeyword", paramMap.get("searchKeyword"));
        model.addAttribute("searchType", paramMap.get("searchType"));

        return "/option/notice/notice-list.admin";
    }


    @GetMapping("/detail")
    public String showNoticeDetailPage(@RequestParam(required = false) String seq, HttpServletRequest request, Model model, Authentication authentication) {

        //Session
        CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
        String userId = user.getUsername();

        String flag = "insert";
        String regNm = user.getUserRealName();
        String regDt = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        try {
            //수정
            if (!CommonUtil.isEmpty(seq)) {
                int noticeSeq = Integer.parseInt(seq);


                Map<String, Object> noticeDetail = noticeService.selectNoticeDetail(noticeSeq);

                FileVo fileVo = new FileVo();
                fileVo.setTypeDepth1("notice");
                fileVo.setForeignSeqList(Arrays.asList(noticeSeq));
                List<Map<String, Object>> fileList = fileService.selectFileInfoList(fileVo);

                if (userId.equals(noticeDetail.get("reg_id"))) {
                    flag = "update";
                } else {
                    flag = "select";
                }

                regDt = (String) noticeDetail.get("reg_dt_str");
                regNm = (String) noticeDetail.get("reg_nm");
                model.addAttribute("noticeDetail", noticeDetail);
                model.addAttribute("fileList", fileList);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("flag", flag);
        model.addAttribute("regNm", regNm);
        model.addAttribute("regDt", regDt);
        model.addAttribute("pageSize", request.getParameter("pageSize"));
        model.addAttribute("curPage", request.getParameter("curPage"));

        return "/option/notice/notice-detail.admin";
    }

    @ResponseBody
    @PostMapping("/submit/{flag}")
    public Map<String, Object> submitNotice(@RequestParam Map<String, Object> paramMap, Authentication authentication,
                                            MultipartHttpServletRequest multiPartRequest, HttpServletRequest request, @PathVariable String flag) throws Exception {

        //Session
        CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
        String memberId = user.getUsername();

        Map<String, Object> resultMap = new HashMap<>();
        int isSuccess = 0;

        try {

            if ("insert".equals(flag) || "update".equals(flag)) {
                if (CommonUtil.isEmpty(paramMap.get("noticeTitle"))) {
                    resultMap.put("result", "NO-TITLE");
                    resultMap.put("popupMsg", "제목을 입력해주세요.");
                    return resultMap;
                }
            };

            paramMap.put("memberId", memberId);

            switch (flag) {
                case "insert":
                    isSuccess = noticeService.insertNotice(paramMap);
                    break;
                case "update":
                    isSuccess = noticeService.updateNotice(paramMap);
                    break;
                case "delete":
                    isSuccess = noticeService.deleteNotice(paramMap);
                    break;
            }

            if (isSuccess > 0) {
                resultMap.put("result", "OK");

                //첨부파일 등록
                if ("update".equals(flag) || "insert".equals(flag) ){

                    String filePath = request.getServletContext().getRealPath("asset/upload/img");
                    File dir = new File(filePath);
                    if (!dir.isDirectory()) {
                        dir.mkdirs();
                    }

                    List<MultipartFile> files = multiPartRequest.getFiles("files");

                    for (MultipartFile file : files) {

                        FileVo fileVo = new FileVo();
                        if (file.getSize() > 0) {
                            int noticeSeq = Integer.parseInt((String) paramMap.get("noticeSeq"));
                            fileVo = fileService.saveFileProduct(file, filePath);

                            fileVo.setTypeDepth1("notice");
                            fileVo.setForeignSeq(noticeSeq);
                        }

                        fileService.insertFileInfo(fileVo);
                    }
                }

                //첨부파일 삭제
                String[] delSeqArr = request.getParameterValues("removeFiles");
                if (delSeqArr != null && delSeqArr.length > 0) {

                    for(String seq : delSeqArr) {
                        int fileSeq = Integer.parseInt(seq);
                        Map<String, Object> fileMap = getFileObject(request, fileSeq);
                        File file = (File) fileMap.get("file");

                        file.delete();
                        fileService.deleteFileInfo(fileSeq);
                    }
                }

            } else {
                resultMap.put("result", "FAILED");
                resultMap.put("popupMsg", "처리에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", "FAILED");
            resultMap.put("popupMsg", "처리에 실패했습니다.");
        }

        return resultMap;
    }

    @ResponseBody
    @PostMapping("/image")
    public Map<String, Object> iamgeUpload(MultipartHttpServletRequest request) throws Exception {

        Map<String, Object> resultMap = new HashMap<>();
        int successCnt = 1;
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
            e.printStackTrace();
            successCnt = 0;
        }

        resultMap.put("uploaded", successCnt);

        return resultMap;
    }

    @RequestMapping("/downloadFile/{fileSeq}")
    public void downloadFile(@PathVariable int fileSeq, HttpServletRequest request, HttpServletResponse response) throws Exception {

        try {

            Map<String, Object> fileMap = getFileObject(request, fileSeq);
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

    @ResponseBody
    @GetMapping("/detail-ajax/{offsetNum}")
    public Map<String, Object> selectDetailAjax(@PathVariable int offsetNum) {

        try {

            int maxNum = noticeService.selectNoticeListCnt(null) -1;

            if (offsetNum < 0) {
                offsetNum = maxNum;
            } else if (offsetNum > maxNum) {
                offsetNum = 0;
            }

            Map<String, Object> noticeMap = noticeService.selectNoticeForMainPage(offsetNum);
            noticeMap.put("offsetNum", offsetNum);

            return noticeMap;

        } catch (Exception e) {
            return null;
        }
    }

    private Map<String, Object> getFileObject(HttpServletRequest request, int fileSeq) {

        Map<String, Object> resultMap = new HashMap<>();

        try {

            FileVo fileVo = new FileVo();
            fileVo.setFileSeq(fileSeq);

            Map<String, Object> fileInfo = fileService.selectFileInfo(fileVo);
            String realPath = request.getServletContext().getRealPath("asset/upload/img");
            String filePath = (String) fileInfo.get("file_path");
            String originName = (String) fileInfo.get("file_org_name");

            File file = new File(realPath + filePath);

            resultMap.put("originName", originName);
            resultMap.put("file", file);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultMap;
    }
}
