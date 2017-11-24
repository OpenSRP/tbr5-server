/**
 * 
 */
package com.ihsinformatics.app;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsMultiFormatView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsViewResolver;

/**
 * @author Muhammad Ahmed
 */
@Configuration
@EnableWebMvc
public class AdditionalConfig extends WebMvcConfigurerAdapter {
	
	@Bean
    public JasperReportsViewResolver getJasperReportsViewResolver() {

        JasperReportsViewResolver jasperReportsViewResolver = new JasperReportsViewResolver();
        jasperReportsViewResolver.setPrefix("classpath:jasperreports/");
        jasperReportsViewResolver.setSuffix(".jrxml");

        jasperReportsViewResolver.setReportDataKey("datasource");
        jasperReportsViewResolver.setViewNames("*rpt_*");
        jasperReportsViewResolver.setViewClass(JasperReportsMultiFormatView.class);
        jasperReportsViewResolver.setOrder(0);
        return jasperReportsViewResolver;
    } 

    @Bean
    public ViewResolver htmlViewResolver() {

        InternalResourceViewResolver internalResourceViewResolver = new InternalResourceViewResolver();
       // internalResourceViewResolver.setViewClass(JstlView.class);
        internalResourceViewResolver.setPrefix("/WEB-INF/pages/");
        internalResourceViewResolver.setSuffix(".jsp");
        internalResourceViewResolver.setOrder(1);
     
        return internalResourceViewResolver;
    }
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurerAdapter() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
        /*       // registry.addMapping("/*").allowedOrigins("http://localhost:8000");
                registry.addMapping("/*").allowedOrigins("http://199.172.1.228.:3000");
                registry.addMapping("/*").allowedOrigins("http://localhost:3000");*/
            	registry.addMapping("/**");
            }
        };
    }
    
    @Override
    public void configureDefaultServletHandling(final DefaultServletHandlerConfigurer configurer) {

        configurer.enable();
    }

    
   

}
