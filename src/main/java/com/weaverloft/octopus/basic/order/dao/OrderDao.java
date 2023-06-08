package com.weaverloft.octopus.basic.order.dao;

import com.weaverloft.octopus.basic.order.vo.OrderVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-05-16
 */
@Mapper
public interface OrderDao {
    int selectOrderCount(OrderVo orderVo);

    List<OrderVo> selectOrderList(OrderVo orderVo);

    OrderVo getOrderDetail(OrderVo orderVo);

    int updateOrderDelivery(OrderVo orderVo);

    int updateReturnDelivery(OrderVo orderVo);

    int updateOrderStatus(OrderVo orderVo);

    List<?> selectExcelOrderList(OrderVo orderVo);

    int insertOrderDownloadLog(Map<String, Object> map);

    List<Map<String, Object>> selectOrderProductList(OrderVo orderVo);

    Map<String, Object> selectOrderProductOne(OrderVo orderVo);
}
