 package com.weaverloft.octopus.configuration;
//
// import org.springframework.web.WebApplicationInitializer;
// import org.springframework.web.context.ContextLoaderListener;
// import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
// import org.springframework.web.servlet.DispatcherServlet;
// import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
//
// import javax.naming.Context;
// import javax.servlet.ServletContext;
// import javax.servlet.ServletContextListener;
// import javax.servlet.ServletException;
// import javax.servlet.ServletRegistration;

import javax.servlet.ServletContext;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import com.weaverloft.octopus.configuration.RootContextConfiguration;
import com.weaverloft.octopus.configuration.WebContextConfiguration;

/**
 * 스프링프레임워크 시동파일
 *
 * @author PENTODE
 */
public class SpringStarter implements WebApplicationInitializer {

    /**
     * 컨텍스트를 시작한다.
     */
    @Override
    public void onStartup(ServletContext servletContext) {

        // Root Context
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(RootContextConfiguration.class);
        servletContext.addListener(new ContextLoaderListener(rootContext));

        // Web Context
        AnnotationConfigWebApplicationContext dispatcherContext = new AnnotationConfigWebApplicationContext();
        dispatcherContext.register(WebContextConfiguration.class);

        ServletRegistration.Dynamic dispatcher = servletContext
            .addServlet("dispatcher", new DispatcherServlet(dispatcherContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
    }
}
