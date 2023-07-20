package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.admin.service.AdminService;
import com.weaverloft.octopus.basic.admin.vo.AdminVo;
import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    AdminService adminService;

    @Override
    public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException {
        // loginId에 해당하는 정보를 데이터베이스에서 읽어 AdminVo객체에 저장한다.
        // 해당 정보를 CustomUserDetails객체에 저장한다.
        AdminVo loginUser = new AdminVo();
        loginUser.setAdminId(loginId);

        AdminVo customUser = adminService.getAdminRole(loginUser);
        if(customUser == null)
            throw new InternalAuthenticationServiceException("입력한 아이디에 해당하는 계정을 찾을 수 없습니다.");
        if(customUser.getIsDormant())
            throw new DisabledException("계정이 비활성화 되어있습니다. 관리자에게 문의하세요.");

        CustomUserDetails customUserDetails = new CustomUserDetails();
        customUserDetails.setUsername(customUser.getAdminId());
        customUserDetails.setPassword(customUser.getAdminPw());
        customUserDetails.setUserRealName(customUser.getAdminName());
        customUserDetails.setUserRole(customUser.getAdminRoleId());

//        List<MemberRoleVo> customRoles = memberService.getMemberRoles(loginId);

        // 로그인 한 사용자의 권한 정보를 GrantedAuthority를 구현하고 있는 SimpleGrantedAuthority객체에 담아
        // 리스트에 추가한다. MemberRole 이름은 "ROLE_"로 시작되야 한다.
        List<GrantedAuthority> authorities = new ArrayList<>();
//        if(customRoles != null) {
//            for (MemberRoleVo customRole : customRoles) {
//                authorities.add(new SimpleGrantedAuthority(customRole.getRoleName()));
//            } //for
//        } //if
        authorities.add(new SimpleGrantedAuthority("ROLE_" + customUser.getAdminRoleId()));    // 유저별 권한 하나

        // CustomUserDetails객체에 권한 목록 (authorities)를 설정한다.
        customUserDetails.setAuthorities(authorities);
        customUserDetails.setEnabled(true);
        customUserDetails.setAccountNonExpired(true);
        customUserDetails.setAccountNonLocked(true);
        customUserDetails.setCredentialsNonExpired(true);
        return customUserDetails;
    }
}
