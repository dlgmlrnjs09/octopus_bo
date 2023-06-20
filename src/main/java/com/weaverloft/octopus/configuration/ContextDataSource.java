package com.weaverloft.octopus.configuration;

import org.apache.commons.dbcp2.BasicDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

/**
 * 데이터베이스 설정
 */
@Configuration
// 아노 테이션 기반 트랜잭션 관리를 사용  <tx:annotation-driven>
@EnableTransactionManagement
public class ContextDataSource {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 데이터소스 등록
     *
     * @return
     */
    @Bean(destroyMethod = "close")
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        try {
            dataSource.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
            dataSource.setUrl("jdbc:log4jdbc:postgresql://103.60.126.203:5432/gps?useUnicode=true&characterEncoding=utf8");
            dataSource.setUsername("apgps");
            dataSource.setPassword("wlvldpTm01!@#");
            dataSource.setDefaultAutoCommit(false);

        } catch (Exception e) {
            logger.error("exception", e);
        }
        return dataSource;
    }

    /**
     * 트랜잭션 매니저 등록
     *
     * @return
     */
    @Bean
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource());
    }
}
