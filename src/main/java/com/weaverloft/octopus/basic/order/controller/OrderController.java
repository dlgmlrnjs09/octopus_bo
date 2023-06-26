package com.weaverloft.octopus.basic.order.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.service.CommonService;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.ExcelService;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.main.vo.FileVo;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.order.service.OrderService;
import com.weaverloft.octopus.basic.order.vo.OrderVo;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.time.LocalDate;
import java.util.*;
import java.util.regex.Pattern;

/**
 * @author hyojeong kim
 * @version 0.0.1
 * @brief 주문 관리
 * @details 주문 조회
 * @date 2023-06-01
 */
@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CommonService commonService;

    /** File Service */
    @Autowired
    protected FileService fileService;

    /** ExcelService */
    @Autowired
    ExcelService excelService;

    @GetMapping("/main")
    public String showOrderMainPage(Model model) {
        Map<String, String> statusMap = new LinkedHashMap<>();
        statusMap.put("PP", "상품준비중");
        statusMap.put("OC", "주문취소");
        statusMap.put("RR", "반품요청");
        statusMap.put("RP", "반품처리");
        statusMap.put("RD", "반품완료");
        statusMap.put("FR", "환불요청");
        statusMap.put("FD", "환불완료");
        statusMap.put("DP", "배송준비중");
        statusMap.put("DS", "배송중");
        statusMap.put("DD", "배송완료");

        model.addAttribute("statusMap", statusMap);

        return "/order/order-main.admin";
    }

    @PostMapping("/select-order-list")
    @ResponseBody
    public ModelAndView selectOrderList(Model model, @RequestBody OrderVo orderVo) {
        ModelAndView mv = new ModelAndView();

        try{
            int count = orderService.selectOrderCount(orderVo);

            PagingModel pagingModel = PagingModel.getPagingModel(orderVo.getCurPage(), orderVo.getPageSize(), count);
            orderVo.setPagingModel(pagingModel);

            List<OrderVo> orderList = orderService.selectOrderList(orderVo);

            for(OrderVo order : orderList) {
                // 개인정보 마스킹
                if(order.getMemberNm() != null) {
                    order.setMemberNm(CommonUtil.maskingName(order.getMemberNm()));
                }
                if(order.getMemberPhoneFull() != null) {
                    order.setMemberPhoneFull(CommonUtil.maskingPhone(order.getMemberPhoneFull()));
                }

                // 상품 목록 조회
                List<Map<String, Object>> productList = orderService.selectOrderProductList(order);
                order.setProductList(productList);
            }

            mv.setViewName("/order/setOrderList");
            mv.addObject("orderList", orderList);
            mv.addObject("pagingModel", pagingModel);
        }catch (Exception e) {
            System.out.println(e);

            mv.setViewName("404");
            return mv;
        }

        return mv;
    }

    @PostMapping("/select-order-count")
    @ResponseBody
    public Map<String, Object> selectOrderCount(Model model, @RequestBody OrderVo orderVo) {
        Map<String, Object> countMap = new HashMap<>();

        try{
            countMap = orderService.selectOrderCountForMainPage(orderVo);
        }catch (Exception e) {
            System.out.println(e);
        }

        return countMap;
    }

    @GetMapping("/order-detail")
    public String loadOrderDetail(Model model, @ModelAttribute OrderVo orderVo) {

        try{
            String returnYn = "N";

            OrderVo order = orderService.getOrderDetail(orderVo);

            // 상품 목록 조회
            List<Map<String, Object>> productList = orderService.selectOrderProductList(order);
            order.setProductList(productList);

            if(order.getOrderStatus().equals("반품처리") || order.getOrderStatus().equals("반품완료")) {
                returnYn = "Y";
            }

            //스마트택배 > 발급받은 KEY
			model.addAttribute("key", "xm01oSiYQQJp7QFmEZFf3Q");
            model.addAttribute("order", order);
            model.addAttribute("returnYn", returnYn);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "/order/order-detail.admin";
    }

    @GetMapping("/order-delivery-update")
    @ResponseBody
    public String updateOrderDelivery(Model model, @ModelAttribute OrderVo orderVo) {

        try{
            // 배송중 상태로 변경
            orderVo.setOrderStatus("DS");

            orderService.updateOrderDelivery(orderVo);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "success";
    }

    @GetMapping("/return-delivery-update")
    @ResponseBody
    public String updateReturnDelivery(Model model, @ModelAttribute OrderVo orderVo) {

        try{
            orderService.updateReturnDelivery(orderVo);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "success";
    }

    @PostMapping(value = "/order-status-update", produces = "application/text; charset=UTF-8")
    @ResponseBody
    public String updateOrderStatus(Model model, @RequestBody OrderVo orderVo, HttpServletRequest request) {

        try{
            List<String> statusList = Arrays.asList("상품준비중", "반품요청", "환불요청", "배송준비중");

            List<OrderVo> orderList = orderService.selectOrderList(orderVo);

            for (OrderVo order : orderList) {
                if(!statusList.contains(order.getOrderStatus())) {
                    request.setCharacterEncoding("UTF-8");
                    return order.getOrderStatus() + " 상태에선 주문 상태를 변경할 수 없습니다!";
                }
            }

            orderService.updateOrderStatus(orderVo);
        }catch (Exception e) {
            System.out.println(e);
            return "404";
        }

        return "success";
    }

    @RequestMapping("/excel/download-order-excel")
    public void downloadOrderExcel(@RequestParam("dataJson") String dataJson, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        OrderVo orderVo =  new ObjectMapper().readValue(dataJson, OrderVo.class);

        List<Object> excelOrderList = (List<Object>) orderService.selectExcelOrderList(orderVo);

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>();
        setting.put("번호", "seq");
        setting.put("주문 번호", "OrderNo");
        setting.put("주문 상태", "OrderStatus");
        setting.put("운송장번호", "OrderDeliveryNo");
        setting.put("택배사 코드", "OrderDeliveryCd");
        setting.put("상품명", "ProductName");
        setting.put("상품 옵션", "OrderOption");
        setting.put("주문자 아이디", "MemberId");
        setting.put("주문자 이름", "MemberNm");
        setting.put("수령인", "OrderToName");
        setting.put("수령인 전화번호", "OrderToPhoneFull");
        setting.put("수령인 우편번호", "OrderToZipCode");
        setting.put("수령인 주소", "OrderToAddrFull");
        setting.put("상품 가격", "ProductPrice");
        setting.put("주문 수량", "OrderProductStock");
        setting.put("배송 요청사항", "OrderDeliveryComment");
        setting.put("주문 일시", "RegDt");
        setting.put("반품 운송장번호", "ReturnDeliveryNo");
        setting.put("반품 택배사 코드", "ReturnDeliveryCd");

        // 개인정보 다운로드 로그 저장
        commonService.insertDownloadLog("[주문 관리] 주문 정보 다운로드");

        excelService.down(setting, excelOrderList, response , request, fileSetting);
    }

    @GetMapping("/insert-delivery-list-popup")
    public String insertDeliveryListPopup(Model model) {
        return "/popup/insert-delivery-list-popup.admin";
    }

    @PostMapping("/insert-delivery-list")
    @ResponseBody
    public ModelAndView insertDeliveryList(Model model, @ModelAttribute OrderVo orderVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
        mv.setView(jsonView);

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        String filePath = request.getServletContext().getRealPath("/asset/upload");
        File dir = new File(filePath);
        if (!dir.isDirectory()) {
            dir.mkdirs();
        }

        CommonsMultipartFile fileExcel = (CommonsMultipartFile) multipartRequest.getFile("fileExcel");

        FileVo fileExcelVO = new FileVo();
        String excelFile = "";
        model.addAttribute("result",true);

        if(fileExcel.getSize()!=0){
            fileExcelVO = fileService.saveFileProduct(fileExcel, filePath);
            excelFile = filePath + fileExcelVO.getStrgePath() + "/" + fileExcelVO.getStrgeFileNm();
        }

        int totalCnt = 0;
        int succesCnt = 0;
        int failCnt = 0;

        // 주문번호 존재하는지 체크
        List<String> orderNoList = orderService.selectOrderNoList(orderVo);
        // 택배사 코드 맞는지 체크
        List<String> deliveryCodeList = Arrays.asList("04", "08", "05", "01", "23", "06", "56", "11", "22", "00");
        // 운송장번호가 숫자로만 이루어져 있는지 체크
        String deliveryNoRegex = "^[0-9]*$";

        // 벨리데이션 check result
        List<Map<String, Object>> validateList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> validateDataList = new ArrayList<Map<String, Object>>();

        if(!"".equals(excelFile)){

            String excelData[][] = excelService.uploadProd(excelFile);
            totalCnt = excelData.length-1 ;
            System.out.println(totalCnt);

            for(int i = 1; i < excelData.length; i++) {
                OrderVo excelVo = new OrderVo();
                Map<String, Object> validate = new HashMap<String, Object>();
                Map<String, Object> validateData = new HashMap<String, Object>();

                boolean validateResult = true;

                excelVo.setOrderNo((excelData[i][0] == null || "".equals(excelData[i][0])) ? "" : excelData[i][0]); 		// 주문 번호
                excelVo.setOrderDeliveryCd((excelData[i][1] == null || "".equals(excelData[i][1])) ? "" : excelData[i][1]); // 택배사 코드
                excelVo.setOrderDeliveryNo((excelData[i][2] == null || "".equals(excelData[i][2])) ? "" : excelData[i][2]); // 운송장 번호

                validateData.put("orderNo", excelVo.getOrderNo());
                if("".equals(excelVo.getOrderNo())){
                    validate.put("orderNo", "주문 번호를 입력해 주세요.");
                    validateData.put("orderNo", excelVo.getOrderNo());
                    validateResult = false;
                } else if(!orderNoList.contains(excelVo.getOrderNo())) {
                    validate.put("orderNo", "주문 번호가 존재하지 않습니다.");
                    validateData.put("orderNo", excelVo.getOrderNo());
                    validateResult = false;
                }

                validateData.put("orderDeliveryCd", excelVo.getOrderDeliveryCd());
                if("".equals(excelVo.getOrderDeliveryCd())){
                    validate.put("orderDeliveryCd", "택배사 코드를 입력해 주세요.");
                    validateData.put("orderDeliveryCd", excelVo.getOrderDeliveryCd());
                    validateResult = false;
                } else if(!deliveryCodeList.contains(excelVo.getOrderDeliveryCd())) {
                    validate.put("orderDeliveryCd", "유효하지 않은 택배사 코드입니다.");
                    validateData.put("orderDeliveryCd", excelVo.getOrderDeliveryCd());
                    validateResult = false;
                }

                validateData.put("orderDeliveryNo", excelVo.getOrderDeliveryNo());
                if("".equals(excelVo.getOrderDeliveryNo())){
                    validate.put("orderDeliveryNo", "운송장 번호를 입력해 주세요.");
                    validateData.put("orderDeliveryNo", excelVo.getOrderDeliveryNo());
                    validateResult = false;
                } else if(!Pattern.matches(deliveryNoRegex, excelVo.getOrderDeliveryNo())) {
                    validate.put("orderDeliveryNo", "운송장 번호는 숫자로만 입력해 주세요.");
                    validateData.put("orderDeliveryNo", excelVo.getOrderDeliveryNo());
                    validateResult = false;
                }

                //필수 값이 모두 있으면
                if(validateResult){
                    excelVo.setOrderStatus("DS");   // 배송중으로 상태 변경
                    orderService.updateOrderDeliveryByDeliveryNo(excelVo);
                    succesCnt++;
                }else{
                    model.addAttribute("result",false);
                    validateDataList.add(validateData);
                    validateList.add(validate);
                    failCnt++;
                }

            }

        }
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("succesCnt", succesCnt);
        model.addAttribute("failCnt", failCnt);
        model.addAttribute("validateList",validateList);
        model.addAttribute("validateDataList",validateDataList);
        return mv;
    }

    @RequestMapping(value = "/excel/insert-delivery-excel-log", produces = "application/text; charset=utf-8")
    public void insertDeliveryExcelLog(@RequestParam("dataJson") String dataJson, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LocalDate nowDate = LocalDate.now();
        String fileSetting = nowDate+".xls";

        LinkedHashMap<String, String> setting = new LinkedHashMap<String, String>() ;
        setting.put("주문 번호", "orderNo");
        setting.put("택배사 코드", "orderDeliveryCd");
        setting.put("운송장 번호", "orderDeliveryNo");

        excelService.excelLogDown(setting, dataJson,  response , request, fileSetting);
    }
    
}
