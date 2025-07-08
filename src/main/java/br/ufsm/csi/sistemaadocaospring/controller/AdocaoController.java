package br.ufsm.csi.sistemaadocaospring.controller;

import br.ufsm.csi.sistemaadocaospring.model.Adocao;
import br.ufsm.csi.sistemaadocaospring.model.Cachorro;
import br.ufsm.csi.sistemaadocaospring.model.Usuario;
import br.ufsm.csi.sistemaadocaospring.service.AdocaoService;
import br.ufsm.csi.sistemaadocaospring.service.CachorroService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/adocao")
public class AdocaoController {

    @GetMapping
    public String showFormNovaAdocao(@RequestParam("id_cachorro") int idCachorro, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            redirectAttributes.addFlashAttribute("msg_login", "Você precisa estar logado para adotar.");
            return "redirect:/login?redirectTo=adocao&cachorroId=" + idCachorro;
        }

        Cachorro cachorro = new CachorroService().buscar(idCachorro);
        model.addAttribute("cachorroParaAdotar", cachorro);
        return "pages/formAdocao";
    }

    @PostMapping("/registrar")
    public String registrarAdocao(Adocao adocao, HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        adocao.setAdotanteId(usuarioLogado.getId());
        String retorno = new AdocaoService().registrarAdocao(adocao);

        redirectAttributes.addFlashAttribute("msg_adocao_status", retorno);
        return "redirect:/adocao/minhas";
    }


    @GetMapping("/minhas")
    public String listarMinhasAdocoes(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            redirectAttributes.addFlashAttribute("msg_login", "Sessão expirada. Faça login novamente.");
            return "redirect:/login";
        }

        model.addAttribute("minhasAdocoes", new AdocaoService().listarMinhasAdocoes(usuarioLogado.getId()));
        return "pages/minhasAdocoes";
    }

    // Rota para exibir o formulário de EDIÇÃO de uma adoção
    @GetMapping("/editar/{id}")
    public String showFormEdicao(@PathVariable int id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        Adocao adocao = new AdocaoService().obterAdocaoParaEdicao(id);

        if (adocao != null && adocao.getAdotanteId() == usuarioLogado.getId()) {
            model.addAttribute("adocao", adocao);
            return "pages/editarAdocao";
        } else {
            redirectAttributes.addFlashAttribute("msg_adocao_status", "Adoção não encontrada ou acesso negado.");
            return "redirect:/adocao/minhas";
        }
    }

    @PostMapping("/editar")
    public String editarAdocao(Adocao adocao, HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            return "redirect:/login";
        }

        String retorno = new AdocaoService().salvarAlteracoesInformacoesAdocao(adocao.getId(), adocao.getInformacoes());

        redirectAttributes.addFlashAttribute("msg_adocao_status", retorno);
        return "redirect:/adocao/minhas";
    }
}