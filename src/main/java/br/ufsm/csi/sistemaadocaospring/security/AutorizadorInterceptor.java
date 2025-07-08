package br.ufsm.csi.sistemaadocaospring.security;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AutorizadorInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // Se a sessão n existir ou n houver usuario logado
        if (request.getSession().getAttribute("usuarioLogado") == null) {
            // Envia para a pag de login
            response.sendRedirect(request.getContextPath() + "/login");
            return false; // bloqueia o acesso
        }

        // Se chegou até aqui, o usuário está logado, então permite o acesso
        return true;
    }
}