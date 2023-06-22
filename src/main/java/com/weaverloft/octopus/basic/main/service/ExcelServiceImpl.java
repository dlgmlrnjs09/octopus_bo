package com.weaverloft.octopus.basic.main.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.util.ExcelUtil;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("Duplicates")
@Service("excelService")
public class ExcelServiceImpl implements ExcelService {

	/**
	 *  @brief 엑셀파일로 저장해준다.
	 *  @date 2023-05-23
	 *  @return boolean
	 *  @param setting, data, response
	 */
	@Override
	public boolean down(
			Map<String, String> setting,
			List<Object> data,
			HttpServletResponse response,
			HttpServletRequest request,
			String file_name
			) throws Exception {

		String userAgent = request.getHeader("User-Agent");
		response.setContentType("application/vnd.ms-excel; charset=euc-kr");
		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { //MS IE 5.5 이하
			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(file_name, "UTF-8") + ";");
		}else{
			 response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(file_name, "UTF-8") + ";");
		}
		String sheetName = "first";
		
		ExcelUtil excelUtil = new ExcelUtil();
		
		WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
		WritableSheet mySheet = wwb.createSheet(sheetName, 0);

		int seq = 0;
		// 타이틀 설정
		for (Map.Entry<String, String> entry : setting.entrySet()) {
			switch (entry.getKey()) {
				case "주소" :
				case "수령인 주소" :
				case "상품명" :
					mySheet.setColumnView(seq, 60);
					break;
				case "이메일" :
				case "배송 요청사항" :
				case "상품 옵션" :
					mySheet.setColumnView(seq, 30);
					break;
				case "등록일" :
				case "주문 일시" :
					mySheet.setColumnView(seq, 20);
					break;
				default :
					mySheet.setColumnView(seq, 15);
					break;
			}

			excelUtil.excelInsert(seq, 0, mySheet, 0, entry.getKey());
			seq++;
		}
		for (int i=0; i<data.size();i++) {
			int k = 0;
			String value = "";
			for (Map.Entry<String, String> entry : setting.entrySet()) {
				//data 로 넘겨온 클래스 찾는다.
				Class<?> clazz = data.get(i).getClass();
				
				//setting객체에서 필요한 컬럼만 가지고 온다.
				String method1 = entry.getValue();

				if(method1.equals("seq")) {
					value = Integer.toString(i+1);	// 넘버링
				} else {
					//VO 에서 get 해올 메소드 만듬
					Method method =  clazz.getMethod("get" + method1, new Class<?>[0]);

					value = method.invoke(data.get(i))==null?"": String.valueOf(method.invoke(data.get(i)));
				}

				excelUtil.excelInsert(k, i+1, mySheet, 0, value);
				k++;
			}
		}
		return excelUtil.close(wwb);
	}

	/**
	 *  @brief 엑셀 업로드 기능 에러 로그 다운로드
	 *  @date 2023-05-23
	 *  @return boolean
	 *  @param setting, data, response
	 */
	@Override
	public boolean excelLogDown(Map<String, String> setting, String dataJson, HttpServletResponse response, HttpServletRequest request, String file_name ) throws Exception {

		Map<String, Object> jsonObj = new ObjectMapper().readValue(dataJson, HashMap.class);
		String userAgent = request.getHeader("User-Agent");
		response.setContentType("application/vnd.ms-excel; charset=euc-kr");
		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { //MS IE 5.5 이하
			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(file_name, "UTF-8") + ";");
		}else{
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(file_name, "UTF-8") + ";");
		}

		String sheetName = "first";

		ExcelUtil excelUtil = new ExcelUtil();

		WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
		WritableSheet mySheet = wwb.createSheet(sheetName, 0);


		int seq = 0;
		// 타이틀 설정
		for (Map.Entry<String, String> entry : setting.entrySet()) {
			excelUtil.excelMemberInsert(seq, 0, mySheet, 0, entry.getKey(), "", false);
			seq++;
		}

		// 엑셀 데이터 목록
		List<Map<String, Object>> validateDataList = (List<Map<String, Object>>) jsonObj.get("validateDataList");
		// 엑셀 벨리데이트 목록
		List<Map<String, Object>> validateList = (List<Map<String, Object>>) jsonObj.get("validateList");

		for (int i=0; i<validateDataList.size();i++) {
			int k = 0;
			String value = "";
			String validateStr = "";
			Boolean validateValue = false;
			for (Map.Entry<String, String> entry : setting.entrySet()) {
				//data 로 넘겨온 클래스 찾는다.
				// Map 객체에서 필요한 컬럼만 가지고 온다.
				String method1 = entry.getValue();
				//VO 에서 get 해올 메소드 만듬
				value = (String) validateDataList.get(i).get(method1);
				validateStr = (String)validateList.get(i).get(method1);
//				if(validateStr != null) {
//					validateStr = new String(validateStr.getBytes("ISO-8859-1"), "UTF-8");	// 한글 인코딩 (web.xml 내 encodingFilter 추가 후 주석처리)
//				}
				if( validateStr != null && !"".equals(validateStr)){
					validateValue = true;
				}else{
					validateValue = false;
				}
				excelUtil.excelMemberInsert(k, i+1, mySheet, 0, value, validateStr, validateValue);
				k++;
			}
		}

		return excelUtil.close(wwb);
	}	

	/* 엑셀파일 업로드 */
	@Override
	public String[][] uploadProd(String excelFile) throws Exception {
		
		Workbook wb = null;
		Sheet sheet = null;
        String[][] data = null;
        
        try {
        	wb = Workbook.getWorkbook(new File(excelFile));
        	sheet = wb.getSheet(0); // 첫번째 시트
            
            int rowLength = sheet.getRows();  //총 행의 수
            int colLength = sheet.getColumns();  //총 열의 수

            if(rowLength <= 0) {
                throw new Exception("해당 엑셀파일에서 읽어들일 데이터가 존재하지 않습니다.");
            }
            
            data = new String[rowLength][colLength];
            
            //엑셀데이터를 배열에 저장
            for(int i = 0; i < rowLength; i++) {
                for(int k = 0 ; k < colLength ; k++) {
                    Cell cell =sheet.getCell(k, i); 
                    if(cell == null) continue;
                    data[i][k] = cell.getContents();
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if(wb != null) wb.close();
            } catch (Exception e) {
                 
            }
        }
        
		return data;
	}
	

}