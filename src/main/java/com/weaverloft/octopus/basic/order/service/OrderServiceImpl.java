package com.weaverloft.octopus.basic.order.service;

import com.weaverloft.octopus.basic.common.util.CommonUtil;
import com.weaverloft.octopus.basic.order.dao.OrderDao;
import com.weaverloft.octopus.basic.order.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    private OrderDao orderDao;

    public int selectOrderCount(OrderVo orderVo) { return orderDao.selectOrderCount(orderVo); }

    public Map<String, Object> selectOrderCountForMainPage(OrderVo orderVo) {
        LocalDate currentDate = LocalDate.now();

        if(CommonUtil.isEmpty(orderVo)) {
            orderVo = new OrderVo();
            orderVo.setStartDate(currentDate.format(DateTimeFormatter.ISO_DATE));
            orderVo.setEndDate(currentDate.format(DateTimeFormatter.ISO_DATE));
            orderVo.setSearchType("day");
        }

        Map<String, Object> countMap = orderDao.selectOrderCountForMainPage(orderVo);

        countMap.put("year", currentDate.getYear());
        countMap.put("type", "order");
        List<Integer> orderList = orderDao.selectOrderCountForStat(countMap);

        countMap.put("type", "sales");
        List<Float> salesPriceList = orderDao.selectSalesPriceForStat(countMap);

        int compare = Integer.parseInt(String.valueOf(countMap.get("curr_count"))) - Integer.parseInt(String.valueOf(countMap.get("prev_count")));

        countMap.put("now", currentDate.format(DateTimeFormatter.ofPattern("YY.MM.dd")));
        countMap.put("compare", compare);
        countMap.put("orderList", orderList);
        countMap.put("salesPriceList", salesPriceList);

        return countMap;
    }

    public List<OrderVo> selectOrderList(OrderVo orderVo) { return orderDao.selectOrderList(orderVo); }

    public OrderVo getOrderDetail(OrderVo orderVo) { return orderDao.getOrderDetail(orderVo); }

    public int updateOrderDelivery(OrderVo orderVo) { return orderDao.updateOrderDelivery(orderVo); }

    public int updateReturnDelivery(OrderVo orderVo) { return orderDao.updateReturnDelivery(orderVo); }

    public int updateOrderAddress(OrderVo orderVo) { return orderDao.updateOrderAddress(orderVo); }

    public int updateOrderStatus(OrderVo orderVo) { return orderDao.updateOrderStatus(orderVo); }

    public List<?> selectExcelOrderList(OrderVo orderVo) { return orderDao.selectExcelOrderList(orderVo); }

    public List<Map<String, Object>> selectOrderProductList(OrderVo orderVo) { return orderDao.selectOrderProductList(orderVo); }

    public Map<String, Object> selectOrderProductOne(OrderVo orderVo) { return orderDao.selectOrderProductOne(orderVo); }

    public List<String> selectOrderNoList(OrderVo orderVo) { return orderDao.selectOrderNoList(orderVo); }

    public int updateOrderDeliveryByDeliveryNo(OrderVo orderVo) { return orderDao.updateOrderDeliveryByDeliveryNo(orderVo); }
}
