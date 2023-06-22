package com.weaverloft.octopus.basic.common.service;

import com.weaverloft.octopus.basic.common.dao.CommonDao;
import com.weaverloft.octopus.basic.member.dao.MemberDao;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import com.weaverloft.octopus.basic.security.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;

import javax.servlet.http.HttpServletRequest;
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
public class CommonServiceImpl implements CommonService{
    @Autowired
    private CommonDao commonDao;

    public int insertDownloadLog(String reason) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

        Map<String, Object> logMap = new HashMap<>();
        logMap.put("downloadRegId", user.getUsername());
        logMap.put("downloadLogIp", request.getRemoteAddr());
        logMap.put("downloadLogReason", reason);

        return commonDao.insertDownloadLog(logMap);
    }

    public int insertAdminLoginLog(Map<String, Object> map) { return commonDao.insertAdminLoginLog(map); }
}
