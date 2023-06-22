package com.weaverloft.octopus.basic.main.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public interface ExcelService {

	/** 엑셀 파일 저장을 실행한다. */
	public boolean down(Map<String, String> setting, List<Object> data, HttpServletResponse response, HttpServletRequest request, String file_name) throws Exception;

	/** 엑셀 파일 업로드를 실행한다. */
	public String[][] uploadProd(String strgFile) throws Exception;

	/** 엑셀 파일중 에러파일을 다운로드 */
	public boolean excelLogDown(Map<String, String> setting, String dataJson, HttpServletResponse response, HttpServletRequest request, String file_name) throws Exception;
}
