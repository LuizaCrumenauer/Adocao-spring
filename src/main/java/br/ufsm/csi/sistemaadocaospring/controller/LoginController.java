package br.ufsm.csi.sistemaadocaospring.controller;

import br.ufsm.csi.sistemaadocaospring.model.Usuario;
import br.ufsm.csi.sistemaadocaospring.service.LoginService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {

    @GetMapping("/")
    public String index() {
        return "redirect:/cachorros";
    }

    @GetMapping("/login")
    public String showLoginPage(Model model, HttpSession session,
                                @RequestParam(required = false) String redirectTo,
                                @RequestParam(required = false) String cachorroId) {

        if (session.getAttribute("msg_login") != null) {
            model.addAttribute("msg", session.getAttribute("msg_login"));
            session.removeAttribute("msg_login");
        }
        if (session.getAttribute("msg_cadastro_sucesso") != null) {
            model.addAttribute("msg_cadastro_sucesso", session.getAttribute("msg_cadastro_sucesso"));
            session.removeAttribute("msg_cadastro_sucesso");
        }
        if (redirectTo != null) {
            model.addAttribute("redirectTo", redirectTo);
        }
        if (cachorroId != null) {
            model.addAttribute("cachorroId", cachorroId);
        }
        return "pages/paginaLogin";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam String email, @RequestParam String senha, HttpSession session, Model model) {
        Usuario usuario = new LoginService().autenticar(email, senha);

        if (usuario != null) {
            session.setAttribute("usuarioLogado", usuario);

            if (usuario.isAdmin()) {
                return "redirect:/usuario/dashboard_admin";
            } else {
                return "redirect:/usuario/dashboard_usuario";
            }
        } else {
            model.addAttribute("msg", "Login ou senha incorretos!");
            model.addAttribute("email", email);
            return "pages/paginaLogin";
        }
    }

    @GetMapping("/logout")
    public String handleLogout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        // Usa RedirectAttributes para enviar uma mensagem que sobrevive ao redirect
        redirectAttributes.addFlashAttribute("mensagemGlobal", "Logout realizado com sucesso!");
        return "redirect:/";
    }
}