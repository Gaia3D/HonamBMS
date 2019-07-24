package honam.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.zaxxer.hikari.HikariDataSource;

import honambms.security.Crypt;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@MapperScan("honam.persistence")
@Configuration
@ComponentScan(	basePackages = {"honam.service, honam.persistence"},
				includeFilters = {	@Filter(type = FilterType.ANNOTATION, value = Component.class),
									@Filter(type = FilterType.ANNOTATION, value = Service.class),
									@Filter(type = FilterType.ANNOTATION, value = Repository.class) },
				excludeFilters = @Filter(type = FilterType.ANNOTATION, value = Controller.class) )
public class RootConfig {
	
	@Value("${spring.datasource.driver-class-name}")
	private String postgresqlDriverClassName;
	@Value("${spring.datasource.url}")
	private String postgresqlUrl;
	@Value("${spring.datasource.user}")
	private String postgresqlUser;
	@Value("${spring.datasource.password}")
	private String postgresqlPassword;
	@Value("${spring.datasource.hikari.maximum-pool-size}")
	private Integer postgresqlMaximumPoolSize;
	@Value("${spring.datasource.hikari.minimum-idle}")
	private Integer postgresqlMinimumIdle;
	
	@Bean(name="datasourceAdmin")
	public DataSource dataSource() {
		
		// TODO hikari 에서는 min, max 를 동일값을 해 주길 권장
//		spring.datasource.hikari.minimum-idle=20
//		spring.datasource.hikari.maximum-pool-size=30
//		spring.datasource.hikari.idle-timeout=600000 (10분)
//		spring.datasource.hikari.max-lifetime=1800000 (30분)
//		spring.datasource.hikari.connection-timeout=15000
//		spring.datasource.hikari.validation-timeout=10000
		
		HikariDataSource dataSource = new HikariDataSource();
		//dataSource.setPoolName("mago3DAdminPool");
		dataSource.setDriverClassName(postgresqlDriverClassName);
//		dataSource.setJdbcUrl(Crypt.decrypt(postgresqlUrl));
//		dataSource.setUsername(Crypt.decrypt(postgresqlUser));
//		dataSource.setPassword(Crypt.decrypt(postgresqlPassword));
		dataSource.setJdbcUrl(postgresqlUrl);
		dataSource.setUsername(postgresqlUser);
		dataSource.setPassword(postgresqlPassword);
		dataSource.setMaximumPoolSize(postgresqlMaximumPoolSize);
		dataSource.setMinimumIdle(postgresqlMinimumIdle);
		
	    return dataSource;
	}
	
	@Bean
    public DataSourceTransactionManager transactionManager() {
		log.info(" ### RootConfig transactionManager ### ");
        final DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(dataSource());
        return transactionManager;
    }
	
	@Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
		log.info(" ### RootConfig sqlSessionFactory ### ");
		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/*.xml"));
		factory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("mybatis-config.xml"));
		return factory.getObject();
    }
}
