package br.ufsm.csi.sistemaadocaospring.controller;

import br.ufsm.csi.sistemaadocaospring.model.Usuario;
import br.ufsm.csi.sistemaadocaospring.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/usuario")
public class UsuarioController {

    // Rotas

    @GetMapping("/dashboard_admin")
    public String showAdminDashboard() {
        return "pages/dashboard_admin";
    }

    @GetMapping("/dashboard_usuario")
    public String showUserDashboard() {
        return "pages/dashboard_usuario";
    }

    @GetMapping("/listar")
    public String listarUsuarios(Model model) {
        model.addAttribute("usuarios", new UsuarioService().listar());
        return "pages/usuarios";
    }

    @GetMapping("/cadastro")
    public String showFormCadastro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "pages/cadastroUsuario";
    }

    // usuario comum publico
    @PostMapping("/cadastrar")
    public String cadastrarUsuario(Usuario usuario, RedirectAttributes redirectAttributes, Model model) {
        usuario.setAdmin(false); //garante que usuarios públicos não sejam admin
        String retorno = new UsuarioService().inserir(usuario);

        if (retorno.toLowerCase().contains("sucesso")) {
            redirectAttributes.addFlashAttribute("msg_cadastro_sucesso", "Cadastro realizado com sucesso! Faça o login.");
            return "redirect:/login";
        } else {
            model.addAttribute("msg_erro_cadastro", retorno);
            model.addAttribute("usuario", usuario); // Devolve o objeto para preencher o form novamente
            return "pages/cadastroUsuario";
        }
    }

    //  (ADMIN)
    @GetMapping("/editar/{id}")
    public String showFormEdicao(@PathVariable int id, Model model) {
        Usuario usuario = new UsuarioService().buscar(id);
        model.addAttribute("usuario", usuario);
        return "pages/alterarUsuario";
    }
    // busca o usuário com o id, coloca no model
    // e exibe a página alterarUsuario.jsp


    @PostMapping("/atualizar")
    public String atualizarUsuario(
            Usuario usuario,
            @RequestParam(name = "novaSenha", required = false) String novaSenha,
            RedirectAttributes redirectAttributes,
            HttpSession session
    ) {
        boolean alterarSenha = novaSenha != null && !novaSenha.isEmpty();
        if(alterarSenha) {
            usuario.setSenha(novaSenha);
        }

        String retorno = new UsuarioService().alterar(usuario, alterarSenha);

        // verifica se o usuario esta logado e se é admin e editou a si mesmo para remover a sessao
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado != null && usuarioLogado.getId() == usuario.getId()) {

            Usuario usuarioAtualizado = new UsuarioService ().buscar ( usuario.getId () );
            session.setAttribute ( "usuarioLogado", usuarioAtualizado );

            // Se o usuário removeu seu próprio privilégio de admin
            if (!usuarioAtualizado.isAdmin ()) {
                redirectAttributes.addFlashAttribute ( "mensagemGlobal", "Seu perfil foi atualizado. Como você não é mais um administrador, sua sessão foi encerrada." );
                return "redirect:/logout";
            }
        }
        redirectAttributes.addFlashAttribute("msg", retorno);
        return "redirect:/usuario/listar";
    }

    // cadastro de um NOVO ADMIN
    @GetMapping("/admin/cadastro")
    public String showFormCadastroAdmin(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "pages/cadastroAdmin";
    }

    @PostMapping("/admin/cadastrar")
    public String cadastrarAdmin(Usuario usuario, RedirectAttributes redirectAttributes, Model model) {
        usuario.setAdmin(true);
        String retorno = new UsuarioService().inserir(usuario);

        if (retorno.toLowerCase().contains("sucesso")) {
            redirectAttributes.addFlashAttribute("msg", "Administrador '" + usuario.getNome() + "' cadastrado com sucesso!");
            return "redirect:/usuario/listar";
        } else {
            model.addAttribute("msg_erro_cadastro_admin", retorno);
            model.addAttribute("usuario", usuario);

            return "pages/cadastroAdmin";
        }
    }

    // Eexclui um usuario (ADMIN)
    @GetMapping("/excluir/{id}")
    public String excluirUsuario(@PathVariable int id, RedirectAttributes redirectAttributes) {
        String retorno = new UsuarioService().excluir(id);
        redirectAttributes.addFlashAttribute("msg", retorno);
        return "redirect:/usuario/listar";
    }
}