package com.weaverloft.octopus.basic.order.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.common.util.PagingModel;
import com.weaverloft.octopus.basic.main.service.ExcelService;
import com.weaverloft.octopus.basic.main.service.FileService;
import com.weaverloft.octopus.basic.order.service.OrderService;
import com.weaverloft.octopus.basic.order.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
//        setting.put("상품 카테고리", "ProductCategory");
        setting.put("상품명", "ProductName");
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
        Map<String, Object> logMap = new HashMap<>();
        logMap.put("downloadRegId", "다운로드 사용자 아이디");
        logMap.put("downloadLogIp", request.getRemoteAddr());
        logMap.put("downloadLogReason", "[주문 관리] 주문 정보 다운로드");
        // TODO 다운로드 로그 저장 공통으로 빼기
        orderService.insertOrderDownloadLog(logMap);

        excelService.down(setting, excelOrderList, response , request, fileSetting);
    }

    // TODO 정규식 체크 함수 공통으로 빼기
    // 전화번호 형식 체크
    public boolean isValidPhone(String phone) {
        String phoneRegex = "^\\d{3}-\\d{3,4}-\\d{4}$";

        if(Pattern.matches(phoneRegex, phone)) {
            return true;
        } else {
            return false;
        }
    }

    // 이메일 형식 체크
    public boolean isValidEmail(String email) {
        String emailRegex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";

        if(Pattern.matches(emailRegex, email)) {
            return true;
        } else {
            return false;
        }
    }

}
