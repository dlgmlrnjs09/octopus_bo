package com.weaverloft.octopus.basic.security;

import com.weaverloft.octopus.basic.member.service.MemberService;
import com.weaverloft.octopus.basic.member.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    MemberService memberService;

    @Override
    public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException {
        // loginId에 해당하는 정보를 데이터베이스에서 읽어 MemberVo객체에 저장한다.
        // 해당 정보를 CustomUserDetails객체에 저장한다.
        MemberVo loginUser = new MemberVo();
        loginUser.setMemberId(loginId);

        MemberVo customUser = memberService.getMemberRole(loginUser);
        if(customUser == null)
            throw new UsernameNotFoundException("사용자가 입력한 아이디에 해당하는 사용자를 찾을 수 없습니다.");
        if(!customUser.getIsUse())
            throw new AuthenticationCredentialsNotFoundException("계정이 비활성화 되어있습니다. 관리자에게 문의하세요.");

        CustomUserDetails customUserDetails = new CustomUserDetails();
        customUserDetails.setUsername(customUser.getMemberId());
        customUserDetails.setPassword(customUser.getMemberPw());
        customUserDetails.setUserRealName(customUser.getMemberNm());
        customUserDetails.setUserRole(customUser.getMemberRole());

//        List<MemberRoleVo> customRoles = memberService.getMemberRoles(loginId);

        // 로그인 한 사용자의 권한 정보를 GrantedAuthority를 구현하고 있는 SimpleGrantedAuthority객체에 담아
        // 리스트에 추가한다. MemberRole 이름은 "ROLE_"로 시작되야 한다.
        List<GrantedAuthority> authorities = new ArrayList<>();
//        if(customRoles != null) {
//            for (MemberRoleVo customRole : customRoles) {
//                authorities.add(new SimpleGrantedAuthority(customRole.getRoleName()));
//            } //for
//        } //if
        authorities.add(new SimpleGrantedAuthority("ROLE_" + customUser.getMemberRole()));    // 유저별 권한 하나

        // CustomUserDetails객체에 권한 목록 (authorities)를 설정한다.
        customUserDetails.setAuthorities(authorities);
        customUserDetails.setEnabled(true);
        customUserDetails.setAccountNonExpired(true);
        customUserDetails.setAccountNonLocked(true);
        customUserDetails.setCredentialsNonExpired(true);
        return customUserDetails;
    }
}
