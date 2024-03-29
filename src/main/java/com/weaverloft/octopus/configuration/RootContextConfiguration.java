package com.weaverloft.octopus.configuration;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;


/**
 * 루트 컨텍스트 설정파일
 */
@Configuration
@Import({
        ContextDataSource.class
        , ContextSqlMapper.class
		, SecurityConfig.class
})
@ComponentScan(basePackages = {
	"com.weaverloft.octopus"
	,"com.weaverloft.octopus.configuration"
})
public class RootContextConfiguration {

}
