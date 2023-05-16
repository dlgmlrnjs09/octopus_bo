package com.weaverloft.octopus.configuration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import java.util.Properties;

/**
 * 웹 컨텍스트 설정파일
 * @author PENTODE
 *
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.weaverloft.octopus")
public class WebContextConfiguration implements WebMvcConfigurer {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
     * Exception Resolver를 설정한다.
     */
//    @Bean
//    public SimpleMappingExceptionResolver getExceptionResolver() {
//        SimpleMappingExceptionResolver smer = new SimpleMappingExceptionResolver();
//
//		// 지정되지 않은 예외에 대한 기본 에러페이지 입니다.
//		smer.setDefaultErrorView("common/error/error");
//		// 상태코드 맵핑이 없는 예외를 위한 기본 상태값 입니다.
//		smer.setDefaultStatusCode(200);
//		// 기본값이 "exception" 입니다. 예외 모돌 속성의 키값입니다. ${exception.message}
//		smer.setExceptionAttribute("exception");
//
//		// 예외 클래스에 대해 에러 페이지를 지정합니다.
//		Properties mappings = new Properties();
//		mappings.setProperty("com.weaverloft.octopus.DatabaseException", "common/error/databaseError");
//		mappings.setProperty("com.weaverloft.octopus.SecurityException", "common/error/securityError");
//		mappings.setProperty("com.weaverloft.octopus.BusinessException", "common/error/businessError");
//		mappings.setProperty("com.weaverloft.octopus.AjaxException", "common/error/ajaxError");
//		smer.setExceptionMappings(mappings);
//
//		// 에러페이지에 상태코드를 지정합니다.
//		Properties statusCodes = new Properties();
//		statusCodes.setProperty("common/error/databaseError", "500");
//		statusCodes.setProperty("common/error/securityError", "403");
//		statusCodes.setProperty("common/error/businessError", "200");
//		statusCodes.setProperty("common/error/ajaxError", "200");
//		smer.setStatusCodes(statusCodes);
//		logger.error("##ERROR {}", smer.getStatusCodesAsMap());
//		return smer;
//    }

    
    /**
	 * 메세지 소스를 생성한다.
	 */
//	@Bean
//    public ReloadableResourceBundleMessageSource messageSource() {
//		ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();
//		// 메세지 프로퍼티파일의 위치와 이름을 지정한다.
//        source.setBasename("classpath:/messages/message");
//        // 기본 인코딩을 지정한다.
//        source.setDefaultEncoding("UTF-8");
//        // 프로퍼티 파일의 변경을 감지할 시간 간격을 지정한다.
//        source.setCacheSeconds(60);
//        // 없는 메세지일 경우 예외를 발생시키는 대신 코드를 기본 메세지로 한다.
//        source.setUseCodeAsDefaultMessage(true);
//        return source;
//    }
	
	/**
	 * 변경된 언어 정보를 기억할 로케일 리졸버를 생성한다.
	 * 여기서는 세션에 저장하는 방식을 사용한다.
	 * @return
	 */
//	@Bean
//	public SessionLocaleResolver localeResolver() {
//		return new SessionLocaleResolver();
//	}
    
	/**
	 * 언어 변경을 위한 인터셉터를 생성한다.
	 */
//	@Bean
//	public LocaleChangeInterceptor localeChangeInterceptor() {
//		LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
//		interceptor.setParamName("lang");
//		return interceptor;
//	}
	
	/**
	 * 인터셉터를 등록한다.
	 */
//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(customInterceptor())
//		.excludePathPatterns("/login/logout.do");
//    }
//
//     @Bean
//    public CmInterceptor customInterceptor() {
//        return new CmInterceptor();
//    }
    
    /**
     * jar, resources 설정
     * */
//    @Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/WEB-INF/asset/**").addResourceLocations("classpath:/META-INF/resources/webjars/").setCachePeriod(31556926);
//        registry.addResourceHandler("/WEB-INF/asset/**").addResourceLocations("/asset/");
//        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
//    }

    /**
	 * 매핑되는 컨트롤러를 찾지 못할 시, 해당하는 경로의 정적 리소스를 찾는다. (<mvc:default-servlet-handler /> 와 동일한 기능)
    */
	@Override
	public void configureDefaultServletHandling(
			DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
    
    /**
     * 파일업로드 설정
     * 
     * */
//    @Bean
//    public MultipartResolver multipartResolver() {
//    	CommonsMultipartResolver commonMultipartResolver = new CommonsMultipartResolver();
//		commonMultipartResolver.setMaxUploadSize(2048576000);
//		commonMultipartResolver.setMaxInMemorySize(2048576000);
//    	commonMultipartResolver.setDefaultEncoding("UTF-8");
//       return commonMultipartResolver;
//    }

	/**
	 * Tiles 설정
	 */
	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer configurer = new TilesConfigurer();
		configurer.setDefinitions(new String[]{
				"/WEB-INF/tiles/tiles-config.xml"
		});
		configurer.setCheckRefresh(true);
		return configurer;
	}

	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		tilesViewResolver.setOrder(1);
		return tilesViewResolver;
	}

	/**
	 * 뷰 리졸버를 설정한다.
	 * @return
	 */
	@Bean
	public ViewResolver getViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/view/");
		resolver.setSuffix(".jsp");
		resolver.setOrder(2);
		return resolver;
	}

	/**
	 * 메일 발송 bean
	 * @return
	 */
	@Bean
	public JavaMailSender naverMailBean() {
		JavaMailSenderImpl jms = new JavaMailSenderImpl();
		jms.setHost("smtp.gmail.com");
		jms.setUsername("dlgmlrnjs09@gmail.com");
		jms.setPassword("npluznoqjlqdicbu");
		jms.setPort(587);
		jms.setDefaultEncoding("utf-8");

		Properties p = new Properties();
		p.setProperty("mail.transport.protocol", "smtp");		// 프로토콜 설정
		p.setProperty("mail.smtp.auth", "true");				// smtp 인증 여부
		p.setProperty("mail.smtp.starttls.enable", "true");		// smtp strattles 사용 여부
		p.setProperty("mail.debug", "true"); 					// 디버그 사용 여부
		p.setProperty("mail.smtp.ssl.trust","smtp.gmail.com"); 	// ssl 인증 서버
		p.setProperty("mail.smtp.ssl.protocols","TLSv1.2"); 			// ssl 사용 여부

		jms.setJavaMailProperties(p);
		return jms;
	}
    
}
