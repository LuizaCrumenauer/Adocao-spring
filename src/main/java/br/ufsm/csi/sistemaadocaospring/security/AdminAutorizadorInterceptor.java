package br.ufsm.csi.sistemaadocaospring.security;

import br.ufsm.csi.sistemaadocaospring.model.Usuario;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminAutorizadorInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");

        // Se o usuário não for admin, nega o acesso
        if (usuario == null || !usuario.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/"); //volta p home
            return false;
        }

        // Se for admin, permite o acesso
        return true;
    }
}