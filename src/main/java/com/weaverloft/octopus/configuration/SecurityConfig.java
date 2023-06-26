package com.weaverloft.octopus.configuration;

import com.weaverloft.octopus.basic.security.CustomUserDetailsService;
import com.weaverloft.octopus.basic.security.LoginFailureHandler;
import com.weaverloft.octopus.basic.security.LoginSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@ComponentScan(basePackages = "com.weaverloft.octopus")
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	CustomUserDetailsService customUserDetailsService;

	@Autowired
	LoginSuccessHandler authenticationSuccessHandler;

	@Autowired
	LoginFailureHandler authenticationFailureHandler;

	/*
	* 스프링 시큐리티 룰을 무시할 URL 규칙 설정
	* 정적 자원에 대해서는 Security 설정을 적용하지 않음
	*/
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring()
			.antMatchers("/resources/**")
			.antMatchers("/css/**")
			.antMatchers("/fonts/**")
			.antMatchers("/excel/**")
			.antMatchers("/js/**")
			.antMatchers("/publishing/**")
			.antMatchers("/favicon*/**")
			.antMatchers("/img/**")
			.antMatchers("/asset/**");
	}

	@Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(customUserDetailsService).passwordEncoder(encoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

		// 로그인 설정
        http
                .csrf().disable()
                .authorizeRequests()
				.antMatchers("/", "/main/main-page", "/main/login-error", "/main/denied").permitAll()
				.anyRequest().authenticated()
                .and()
                    .formLogin()
                    .loginPage("/main/login-form")
                    .usernameParameter("userId")
                    .passwordParameter("password")
                    .loginProcessingUrl("/authenticate")
					.successHandler(authenticationSuccessHandler)
                	.failureHandler(authenticationFailureHandler)
                    .permitAll()
                .and()
                    .logout()
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/main/main-page")
				.and()
					.exceptionHandling()
//				   	.authenticationEntryPoint( new AuthenticationEntryPoint() {	//인증실패
//						@Override
//						public void commence(HttpServletRequest request, HttpServletResponse response,
//											 AuthenticationException authException) throws IOException, ServletException {
//							response.sendRedirect("/main/login-form");
//					 	}
//				  	})
				  	.accessDeniedHandler( new AccessDeniedHandler() {	//인가실패
						@Override
						public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
							response.sendRedirect("/main/denied");
						}
				 	});
    }

    @Bean
    public PasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }

}
