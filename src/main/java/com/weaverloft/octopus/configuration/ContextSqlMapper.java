package com.weaverloft.octopus.configuration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Properties;

@Configuration
@MapperScan(basePackages = {"com.weaverloft.octopus.**.dao"})
public class ContextSqlMapper {

    @Autowired
    ApplicationContext applicationContext;

//    @Bean
//    public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource) throws IOException {
//        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
//        factoryBean.setDataSource(dataSource);
//        factoryBean.setMapperLocations(applicationContext.getResources("classpath:/postgresql/mapper/*.xml"));
////        factoryBean.setTypeAliases(new Class<?>[] {CustomUserDetailVO.class});
//        // Select 컬럼명 스네이크 케이스 -> 카멜케이스 자동변환
//        Properties properties = new Properties();
//        properties.put("mapUnderscoreToCamelCase", true);
//        factoryBean.setConfigurationProperties(properties);
//        return factoryBean;
//    }
//
//    @Bean
//    public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) {
//        return new SqlSessionTemplate(sqlSessionFactory);
//    }
}
