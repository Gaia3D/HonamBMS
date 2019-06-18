package HonamBMS.config;

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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@MapperScan("HonamBMS.persistence.postgresql")
@ComponentScan(	basePackages = {"HonamBMS.service, HonamBMS.persistence.postgresql"},
				includeFilters = {	@Filter(type = FilterType.ANNOTATION, value = Component.class),
									@Filter(type = FilterType.ANNOTATION, value = Service.class),
									@Filter(type = FilterType.ANNOTATION, value = Repository.class) },
				excludeFilters = @Filter(type = FilterType.ANNOTATION, value = Controller.class) )
public class RootConfig {

	@Value("${spring.datasource.postgresql.driver-class-name}")
	private String postgresqlDriverClassName;
	@Value("${spring.datasource.postgresql.url}")
	private String postgresqlUrl;
	@Value("${spring.datasource.postgresql.user}")
	private String postgresqlUser;
	@Value("${spring.datasource.postgresql.password}")
	private String postgresqlPassword;
	@Value("${spring.datasource.postgresql.hikari.maximum-pool-size}")
	private Integer postgresqlMaximumPoolSize;
	@Value("${spring.datasource.postgresql.hikari.minimum-idle}")
	private Integer postgresqlMinimumIdle;

	@Bean(name="datasourceAdmin")
	public DataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource();
		//dataSource.setPoolName("mago3DAdminPool");
		dataSource.setDriverClassName(postgresqlDriverClassName);
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
		factory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/postgresql/*.xml"));
		factory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("mybatis-config-postgresql.xml"));
		return factory.getObject();
	}
}
