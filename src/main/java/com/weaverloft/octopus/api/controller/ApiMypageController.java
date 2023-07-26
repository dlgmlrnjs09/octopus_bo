package com.weaverloft.octopus.api.controller;

import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.weaverloft.octopus.api.service.ApiMemberService;

@Controller
@RequestMapping("api")
public class ApiMypageController {

	@Autowired
    private ApiMemberService apiMemberService;

    /**
     *  사용자별 포인트, 쿠폰, 멤버십 정보 조회
     * @param paramMap
     * @param memberSeq
     * @return
     */
    @GetMapping("/v1/members/{memberSeq}/benefits")
    public ResponseEntity<Map<String, Object>> selectMemberBenefitsInfo(@RequestParam Map<String, Object> paramMap, @PathVariable int memberSeq) {
        HttpHeaders headers= new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        paramMap.put("memberSeq", memberSeq);

        // 사용자 포인트&쿠폰 조회
        Map<String, Object> pointCouponMap = apiMemberService.selectPointCouponInfo(paramMap);
        // 사용자 멤버십 정보 조회
        Map<String, Object> membershipMap = apiMemberService.selectMembershipInfo(paramMap);

        Map<String, Object> map = new HashMap<>();
        map.put("memberSeq", memberSeq);
        map.put("pointCouponMap", pointCouponMap);
        map.put("membershipMap", membershipMap);

        return new ResponseEntity<>(map, headers, HttpStatus.OK);
    }
}
