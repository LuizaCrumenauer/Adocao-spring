package br.ufsm.csi.sistemaadocaospring.config;

import br.ufsm.csi.sistemaadocaospring.security.AdminAutorizadorInterceptor;
import br.ufsm.csi.sistemaadocaospring.security.AutorizadorInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class AppConfig implements WebMvcConfigurer {

    private final AutorizadorInterceptor autorizadorInterceptor;
    private final AdminAutorizadorInterceptor adminAutorizadorInterceptor;

    // injeta os interceptors
    public AppConfig(AutorizadorInterceptor autorizadorInterceptor, AdminAutorizadorInterceptor adminAutorizadorInterceptor) {
        this.autorizadorInterceptor = autorizadorInterceptor;
        this.adminAutorizadorInterceptor = adminAutorizadorInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(adminAutorizadorInterceptor)
                .addPathPatterns("/cachorros/gerenciar", "/cachorros/cadastrar", "/cachorros/editar/**", "/cachorros/excluir/**", "/usuario/listar", "/usuario/editar/**", "/usuario/excluir/**", "/usuario/dashboard_admin");

        registry.addInterceptor(autorizadorInterceptor)
                .addPathPatterns("/adocao/**", "/usuario/dashboard_usuario")
                .excludePathPatterns("/css/**", "/js/**", "/imagens/**");
    }
}