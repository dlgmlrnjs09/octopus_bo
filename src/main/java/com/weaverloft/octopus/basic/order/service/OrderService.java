package com.weaverloft.octopus.basic.order.service;

import com.weaverloft.octopus.basic.order.vo.OrderVo;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
public interface OrderService {
    int selectOrderCount(OrderVo orderVo);

    Map<String, Object> selectOrderCountForMainPage(OrderVo orderVo);

    List<OrderVo> selectOrderList(OrderVo orderVo);

    OrderVo getOrderDetail(OrderVo orderVo);

    int updateOrderDelivery(OrderVo orderVo);

    int updateReturnDelivery(OrderVo orderVo);

    int updateOrderAddress(OrderVo orderVo);

    int updateOrderStatus(OrderVo orderVo);

    List<?> selectExcelOrderList(OrderVo orderVo);

    List<Map<String, Object>> selectOrderProductList(OrderVo orderVo);

    Map<String, Object> selectOrderProductOne(OrderVo orderVo);

    List<String> selectOrderNoList(OrderVo orderVo);

    int updateOrderDeliveryByDeliveryNo(OrderVo orderVo);
}
