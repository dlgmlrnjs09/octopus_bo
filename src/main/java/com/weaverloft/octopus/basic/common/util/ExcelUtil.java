package com.weaverloft.octopus.basic.common.util;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.Boolean;


/**
 * jxl API를 이용한 엑셀 조회 및 수정, 생성 모듈
 * 
 * @author 김규선
 * 
 *         readSheet()를 실행시켜 Sheet를 먼저 읽지 않으면 Cell을 읽거나 수정할 수 없다. 쓰기 작업을 수행할 경우
 *         writeWorkbook() 후에 반드시 close()를 수행해야 실제 파일이 생성된다.
 */
@SuppressWarnings("Duplicates")
public class ExcelUtil {

	// 객체&변수 초기화
	Sheet sheet = null;
	Cell cell = null;

	int sheetNum = 0; // 읽어들일 시트 번호(첫번째 시트부터 0)
	int numberOfSheet = 0; // 통합 문서의 총 시트 수
	String sheetName = ""; // 읽은 시트의 이름
	int col = 0; // 읽어들인 시트의 마지막 Column
	int row = 0; // 읽어들인 시트의 마지막 Row

	public ExcelUtil() {
	}

	/**
	 * 엑셀 파일을 수정하거나 쓰기 작업을 할 때, Workbook 생성 해당 메소드를 사용하여 파일을 작성한 후, 반드시 close()
	 * 메소드를 수행해야 실제 파일이 써짐
	 * 
	 * @param Workbook
	 *            , WritableWorkbook, 파일 경로, 파일명
	 * @return WritableWorkbook
	 */
	public WritableWorkbook writeWorkbook(Workbook wb, WritableWorkbook wwb,
										  String path, String fName) {

		File f;
		// 엑셀 2003 이후 버전(.xlsx)파일은 쓰기 불가(jxl API에서 지원하지 않음)
		try {
			f = new File(path + fName);
			wwb = Workbook.createWorkbook(f, wb);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return wwb;
	}
	/**
	 * 엑셀 파일에서 셀병합
	 * 
	 * @param col1, row1, col2, row2
	 *            
	 * @return Boolean
	 */
	public boolean mergeCells (int col1, int row1, int col2, int row2, WritableSheet sheet) {
		try {
			sheet.mergeCells(col1, row1, col2, row2);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 엑셀 파일에서 셀의 내용을 입력(셀 포멧 지정)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값 , writablecellFormat
	 * @return Boolean
	 */
	public boolean excelFormat(int cols, int rows, WritableSheet sheet,
                               int sheetnum, String labelstr, WritableCellFormat cellformat)
			throws Exception {

		//WritableCell cell = sheet.getWritableCell(cols, rows);
		Label label = new Label(cols, rows, labelstr, cellformat);
		sheet.addCell(label);

		return true;
	}

	/**
	 * 엑셀 파일에서 셀의 내용을 입력(문자열 셀 입력)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelInsert(int cols, int rows, WritableSheet sheet,
			int sheetnum, String labelstr) throws Exception {

		WritableCell cell = sheet.getWritableCell(cols, rows);
		WritableCellFormat textFormat = new WritableCellFormat();
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
		textFormat.setAlignment(jxl.format.Alignment.CENTRE);

		if (cell.getType() == jxl.CellType.LABEL) {
			// 방식 1
			Label label = new Label(cols, rows, labelstr, textFormat);
			sheet.addCell(label);
			// 방식 2
			// Label label = (Label) cell;
			// label.setString(labelstr);
		} else if (cell.getType() == jxl.CellType.LABEL
				|| cell.getType() == jxl.CellType.NUMBER
				|| cell.getType() == jxl.CellType.BOOLEAN
				|| cell.getType() == jxl.CellType.DATE) {

			Formula f = new Formula(cols, rows, labelstr, textFormat);
			sheet.addCell(f);
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			Label label = new Label(cols, rows, labelstr, textFormat);
			sheet.addCell(label);
		} else {
			System.out.println(sheetnum + "번째 시트의 (" + cols + "," + rows
					+ ") 셀은 문자열 혹은 수식 셀이 아닙니다.");
		}
		return true;
	}
	
	
	/**
	 * 15.07.21 김대우 대리.
	 * 엑셀 파일에서 셀의 내용을 입력(문자열 셀 입력)
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelInsert2(int cols, int rows, WritableSheet sheet,
			int sheetnum, String labelstr) throws Exception {

		// 폰트 생성
		WritableFont.FontName mgodik = WritableFont.createFont("맑은 고딕");
		// 폰트 포맷
		WritableFont mg9bold = new WritableFont(mgodik, 9);
		
		WritableCellFormat textFormat = new WritableCellFormat(mg9bold);
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
		textFormat.setAlignment(jxl.format.Alignment.CENTRE);

		//행 높이. 15.07.21 김대우 대리 추가.
		sheet.setRowView(cols, 450);
		// 아이디
		if (cols == 1){
			textFormat.setAlignment(jxl.format.Alignment.LEFT);
		}
		Label label = new Label(cols, rows, labelstr, textFormat);
		sheet.addCell(label);			
		return true;
	}
	

	/**
	 * 엑셀 파일에서 셀의 내용을 입력(문자열 셀 입력)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelMemberInsert(int cols, int rows, WritableSheet sheet,
                                      int sheetnum, String labelstr, String validateStr, Boolean validateValue) throws Exception {
		WritableCell cell = sheet.getWritableCell(cols, rows);
		WritableCellFormat textFormat = new WritableCellFormat();
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
		textFormat.setAlignment(jxl.format.Alignment.CENTRE);
		sheet.setColumnView(cols, 30);
		if(validateValue){
			textFormat.setBackground(Colour.RED);
		}
		if (cell.getType() == jxl.CellType.LABEL) {
			// 방식 1
			Label label = new Label(cols, rows, labelstr, textFormat);
			if(validateValue){
				WritableCellFeatures wcf = new WritableCellFeatures();
				wcf.setComment(validateStr);
				label.setCellFeatures(wcf);
			}				
			sheet.addCell(label);
			// 방식 2
			// Label label = (Label) cell;
			// label.setString(labelstr);
		} else if (cell.getType() == jxl.CellType.LABEL || cell.getType() == jxl.CellType.NUMBER || cell.getType() == jxl.CellType.BOOLEAN || cell.getType() == jxl.CellType.DATE) {
			Formula f = new Formula(cols, rows, labelstr, textFormat);
			if(validateValue){
				WritableCellFeatures wcf = new WritableCellFeatures();
				wcf.setComment(validateStr);
				f.setCellFeatures(wcf);
			}				
			
			sheet.addCell(f);
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			Label label = new Label(cols, rows, labelstr, textFormat);
			if(validateValue){
				WritableCellFeatures wcf = new WritableCellFeatures();
				wcf.setComment(validateStr);
				label.setCellFeatures(wcf);
			}				
			
			sheet.addCell(label);
		} else {
			System.out.println(sheetnum + "번째 시트의 (" + cols + "," + rows + ") 셀은 문자열 혹은 수식 셀이 아닙니다.");
		}
		
		return true;
	}	
	
	/**
	 * 엑셀 파일에서 셀의 내용을 입력(문자열 셀 입력)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelCustomInsert(int cols, int rows, WritableSheet sheet,
			int sheetnum, String labelstr) throws Exception {

		WritableCell cell = sheet.getWritableCell(cols, rows);
		WritableCellFormat textFormat = new WritableCellFormat();
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
		textFormat.setAlignment(jxl.format.Alignment.CENTRE);
		textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
		
		if(rows == 0){
			textFormat.setBackground(Colour.GRAY_25);
			sheet.setRowView(rows, 400);
		}else{
			sheet.setRowView(rows, 350); 
		}
		
		if (cell.getType() == jxl.CellType.LABEL) {
			// 방식 1
			Label label = new Label(cols, rows, labelstr, textFormat);
			sheet.addCell(label);
			// 방식 2
			// Label label = (Label) cell;
			// label.setString(labelstr);
		} else if (cell.getType() == jxl.CellType.LABEL
				|| cell.getType() == jxl.CellType.NUMBER
				|| cell.getType() == jxl.CellType.BOOLEAN
				|| cell.getType() == jxl.CellType.DATE) {

			Formula f = new Formula(cols, rows, labelstr, textFormat);
			sheet.addCell(f);
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			Label label = new Label(cols, rows, labelstr, textFormat);
			sheet.addCell(label);
		} else {
			System.out.println(sheetnum + "번째 시트의 (" + cols + "," + rows
					+ ") 셀은 문자열 혹은 수식 셀이 아닙니다.");
		}
		return true;
	}
	
	

	/**
	 * 엑셀 파일에서 셀의 내용을 입력(숫자열 셀 입력)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelInsert(int cols, int rows, WritableSheet sheet,
			int sheetnum, double numd) throws Exception {

		WritableCell cell = sheet.getWritableCell(cols, rows);
		WritableCellFormat textFormat = new WritableCellFormat();
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
		textFormat.setAlignment(jxl.format.Alignment.CENTRE);
		sheet.setColumnView(cols, 30);
		if (cell.getType() == jxl.CellType.NUMBER) {
			jxl.write.Number n = (jxl.write.Number) cell;
			n.setCellFormat(textFormat);
			n.setValue(numd);
			// System.out.println("셀에 값 추가 완료 : " + cols + "," + rows + "셀에 " +
			// numd + "입력");
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			jxl.write.Number n = new jxl.write.Number(cols, rows, numd, textFormat);
			// System.out.println("셀에 값 추가 완료 : " + cols + "," + rows + "셀에 " +
			// numd + "입력");
			sheet.addCell(n);
		} else { // System.out.println(cell);
			System.out.println(sheetNum + "번째 시트의 (" + cols + "," + rows
					+ ") 셀은 숫자 셀이 아닙니다." + cell.getType());
		}
		return true;
	}
	
	/**
	 * 셀 내용 리턴
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook
	 * @return String
	 */
	public String excelContent(int cols, int rows, WritableSheet sheet) throws Exception {
		WritableCell cell = sheet.getWritableCell(cols, rows);
		return cell.getContents();
	}

	/**
	 * 기존 엑셀 파일에서 셀의 내용을 수정(문자열 셀 수정)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelModify(int cols, int rows, WritableWorkbook copy,
			int sheetnum, String labelstr) throws Exception {
		WritableSheet sheet = copy.getSheet(sheetnum);
		WritableCell cell = sheet.getWritableCell(cols, rows);

		if (cell.getType() == jxl.CellType.LABEL) {
			// 방식 1
			// jxl.write.Label label = new jxl.write.Label(cols, rows,
			// labelstr);
			// sheet.addCell(label);
			// 방식 2
			Label label = (Label) cell;
			label.setString(labelstr);
		} else if (cell.getType() == jxl.CellType.LABEL
				|| cell.getType() == jxl.CellType.NUMBER
				|| cell.getType() == jxl.CellType.BOOLEAN
				|| cell.getType() == jxl.CellType.DATE) {

			Formula f = new Formula(cols, rows, labelstr);
			sheet.addCell(f);
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			Label label = new Label(cols, rows, labelstr);
			sheet.addCell(label);
		} else {
			System.out.println(sheetnum + "번째 시트의 (" + cols + "," + rows
					+ ") 셀은 문자열 혹은 수식 셀이 아닙니다." + cell.getType());
		}
		return true;
	}

	/**
	 * 기존 엑셀 파일에서 셀의 내용을 수정(숫자 셀 수정)
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값
	 * @return Boolean
	 */
	public boolean excelModify(int cols, int rows, WritableWorkbook copy,
			int sheetNum, double numd) throws Exception {
		WritableSheet sheet = copy.getSheet(sheetNum);
		WritableCell cell = sheet.getWritableCell(cols, rows);
		
		if (cell.getType() == jxl.CellType.NUMBER) {
			jxl.write.Number n = (jxl.write.Number) cell;
			n.setValue(numd);
			// System.out.println("셀에 값 추가 완료 : " + cols + "," + rows + "셀에 " +
			// numd + "입력");
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			jxl.write.Number n = new jxl.write.Number(cols, rows, numd);
			// System.out.println("셀에 값 추가 완료 : " + cols + "," + rows + "셀에 " +
			// numd + "입력");
			sheet.addCell(n);
		} else { // System.out.println(cell);
			System.out.println(sheetNum + "번째 시트의 (" + cols + "," + rows
					+ ") 셀은 숫자 셀이 아닙니다." + cell.getType());
		}
		return true;
	}

	/**
	 * 기존 엑셀 파일에서 셀의 내용을 수정(숫자 셀 수정 후, 세 자리마다 쉼표(,)스타일 적용
	 * 
	 * @param 열
	 *            번호, 행 번호, WritableWorkbook, 시트번호, 변경할 값, 숫자포맷(#,###)
	 * @return Boolean
	 */
	public boolean excelModify(int cols, int rows, WritableWorkbook copy,
			int sheetnum, double numd, String numberformat) throws Exception {
		WritableSheet sheet = copy.getSheet(sheetnum);
		WritableCell cell = sheet.getWritableCell(cols, rows);

		NumberFormat fivedps = new NumberFormat(numberformat);
		WritableCellFormat cellFormat = new WritableCellFormat(fivedps);

		if (cell.getType() == jxl.CellType.NUMBER) {
			cell.setCellFormat(cellFormat);
			jxl.write.Number n = (jxl.write.Number) cell;
			n.setValue(numd);
		} else if (cell.getType() == jxl.CellType.EMPTY) {
			jxl.write.Number n = new jxl.write.Number(cols, rows, numd,
					cellFormat);
			sheet.addCell(n);
		} else {
			System.out.println(sheetnum + "번째 시트의 (" + cols + "," + rows
					+ ") 셀은 숫자 셀이 아닙니다.");
		}
		return true;
	}

	/**
	 * 수정한 Workbook 쓰기
	 * 
	 * @param WritableWorkbook wwb
	 * @return void
	 */
	public boolean close(WritableWorkbook wwb) {
//		System.out.println("wwb : "+wwb.toString());
		try {
			wwb.write();
			wwb.close();
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} catch (WriteException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	
	
	/**
	 * 엑셀 파일에서 셀의 타이틀 병합
	 * @author sh.song
	 * @param WritableWorkbook, 시트번호, 구분값
	 * @return int
	 */
	public int excelHeaderMerge(WritableSheet sheet, int sheetnum, String gubun) throws Exception {

		int cols = 0;
		int rows = 0;
		String cellNm = "";
		jxl.write.Label label;
		if(gubun.equals("person")){
			
			sheet.mergeCells(0, 0, 0, 1);
			label = new jxl.write.Label(0, 0, "번호");
			sheet.addCell(label);
			sheet.mergeCells(1, 0, 1, 1);
			label = new jxl.write.Label(1, 0, "이름");
			sheet.addCell(label);
			sheet.mergeCells(2, 0, 2, 1);
			label = new jxl.write.Label(2, 0, "ID");
			sheet.addCell(label);
			sheet.mergeCells(3, 0, 3, 1);
			label = new jxl.write.Label(3, 0, "근무처");
			sheet.addCell(label);
			sheet.mergeCells(4, 0, 4, 1);
			label = new jxl.write.Label(4, 0, "매장");
			sheet.addCell(label);
			sheet.mergeCells(5, 0, 5, 1);
			label = new jxl.write.Label(5, 0, "직급");
			sheet.addCell(label);
			sheet.mergeCells(6, 0, 8, 0);
			label = new jxl.write.Label(6, 0, "오설록 아카데미");
			sheet.addCell(label);
			sheet.mergeCells(9, 0, 11, 0);
			label = new jxl.write.Label(9, 0, "상품 아카데미");
			sheet.addCell(label);
			sheet.mergeCells(12, 0, 12, 1);
			label = new jxl.write.Label(12, 0, "전체강좌수");
			sheet.addCell(label);
			sheet.mergeCells(13, 0, 13, 1);
			label = new jxl.write.Label(13, 0, "전체수료수");
			sheet.addCell(label);
			sheet.mergeCells(14, 0, 14, 1);
			label = new jxl.write.Label(14, 0, "전체수료율");
			sheet.addCell(label);
			
			//오설록 아카데미
			label = new jxl.write.Label(6, 1, "강좌수");
			sheet.addCell(label);
			label = new jxl.write.Label(7, 1, "수료");
			sheet.addCell(label);
			label = new jxl.write.Label(8, 1, "수료율");
			sheet.addCell(label);
			//상품 아카데미
			label = new jxl.write.Label(9, 1, "강좌수");
			sheet.addCell(label);
			label = new jxl.write.Label(10, 1, "수료");
			sheet.addCell(label);
			label = new jxl.write.Label(11, 1, "수료율");
			sheet.addCell(label);
			
			rows = 1;
		}else if(gubun.equals("stor")){
			
			sheet.mergeCells(0, 0, 0, 1);
			label = new jxl.write.Label(0, 0, "번호");
			sheet.addCell(label);
			sheet.mergeCells(1, 0, 1, 1);
			label = new jxl.write.Label(1, 0, "근무처");
			sheet.addCell(label);
			sheet.mergeCells(2, 0, 2, 1);
			label = new jxl.write.Label(2, 0, "매장");
			sheet.addCell(label);
			sheet.mergeCells(3, 0, 3, 1);
			label = new jxl.write.Label(3, 0, "점원수");
			sheet.addCell(label);
			sheet.mergeCells(4, 0, 6, 0);
			label = new jxl.write.Label(4, 0, "오설록 아카데미");
			sheet.addCell(label);
			sheet.mergeCells(7, 0, 9, 0);
			label = new jxl.write.Label(7, 0, "상품 아카데미");
			sheet.addCell(label);
			sheet.mergeCells(10, 0, 10, 1);
			label = new jxl.write.Label(10, 0, "전체강좌수");
			sheet.addCell(label);
			sheet.mergeCells(11, 0, 11, 1);
			label = new jxl.write.Label(11, 0, "전체수료수");
			sheet.addCell(label);
			sheet.mergeCells(12, 0, 12, 1);
			label = new jxl.write.Label(12, 0, "전체수료율");
			sheet.addCell(label);
			
			//서비스아카데미
			label = new jxl.write.Label(4, 1, "강좌수");
			sheet.addCell(label);
			label = new jxl.write.Label(5, 1, "수료");
			sheet.addCell(label);
			label = new jxl.write.Label(6, 1, "수료율");
			sheet.addCell(label);
			//상품 아카데미
			label = new jxl.write.Label(7, 1, "강좌수");
			sheet.addCell(label);
			label = new jxl.write.Label(8, 1, "수료");
			sheet.addCell(label);
			label = new jxl.write.Label(9, 1, "수료율");
			sheet.addCell(label);
			
			rows = 1;
			
		}
		

		return rows;
	}
	
}
