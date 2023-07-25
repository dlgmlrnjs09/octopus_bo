package com.weaverloft.octopus.api.service;

import com.weaverloft.octopus.api.dao.ApiMemberDao;
import com.weaverloft.octopus.basic.member.dao.MembershipDao;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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
public class ApiMemberServiceImpl implements ApiMemberService {
    @Autowired
    private ApiMemberDao apiMemberDao;

    @Autowired
    private MembershipDao membershipDao;

    public Map<String, Object> selectPointCouponInfo(Map<String, Object> map) {
        Map<String, Object> returnMap = new HashMap<>();
        int totalPoint = 0;
        int expirePoint = 0;
        int couponCount = 0;

        // 사용 가능 포인트 리스트
        List<Map<String, Object>> pointList = apiMemberDao.selectPointSumList(map);
        for (Map<String, Object> pointMap : pointList) {
            totalPoint += (int) pointMap.get("point");
        }

        // 소멸 예정 포인트 리스트
        map.put("pointType", "expire");
        List<Map<String, Object>> expirePointList = apiMemberDao.selectPointSumList(map);
        for (Map<String, Object> pointMap : expirePointList) {
            expirePoint += (int) pointMap.get("point");
        }

        // 보유햔 쿠폰 리스트
        List<Map<String, Object>> couponList = apiMemberDao.selectCouponList(map);
        couponCount = couponList.size();

        // 포인트 정보
        returnMap.put("pointList", pointList);
        returnMap.put("expirePointList", expirePointList);
        returnMap.put("totalPoint", totalPoint);
        returnMap.put("expirePoint", expirePoint);
        // 쿠폰 정보
        returnMap.put("couponCount", couponCount);
        returnMap.put("couponList", couponList);

        return returnMap;
    }

    public Map<String, Object> selectMembershipInfo(Map<String, Object> map) {
        Map<String, Object> returnMap = new HashMap<>();

        // 현재 멤버십 정보 조회
        Map<String, Object> currentMembershipMap = apiMemberDao.selectCurrentMembershipInfo(map);
        // 멤버십 혜택 정보 조회
        Map<String, Object> membershipInfo = membershipDao.selectMembershipInfo((int)currentMembershipMap.get("membership_seq"));

        String nextMembershipName = (String) currentMembershipMap.get("membership_name");
        int remainPrice = 0;

        // 수동 등급이거나, 고정 등급의 경우 다음 멤버십 등급 정보 불러오지 않음
        if((boolean)currentMembershipMap.get("membership_is_auto") || !(boolean)currentMembershipMap.get("is_membership_fixed")) {
            Map<String, Object> nextMembershipMap = apiMemberDao.selectNextMembershipInfo(currentMembershipMap);

            if(!MapUtils.isEmpty(nextMembershipMap)) {
                nextMembershipName = (String) nextMembershipMap.get("membership_name");
                remainPrice = (int) nextMembershipMap.get("membership_auto_amount") - (int) currentMembershipMap.get("total_order_price");
            }
        }

        returnMap.put("nextMembershipName", nextMembershipName);
        returnMap.put("remainPrice", remainPrice);
        returnMap.put("membershipInfo", membershipInfo);

        return returnMap;
    }
}
