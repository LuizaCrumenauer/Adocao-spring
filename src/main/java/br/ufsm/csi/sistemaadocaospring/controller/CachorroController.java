package br.ufsm.csi.sistemaadocaospring.controller;

import br.ufsm.csi.sistemaadocaospring.model.Cachorro;
import br.ufsm.csi.sistemaadocaospring.service.CachorroService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cachorros")
public class CachorroController {

    //lida com o caminho dos arquivos
    private final ServletContext servletContext;
    public CachorroController(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @GetMapping
    public String listarCachorrosPublico(Model model, HttpSession session) {
        //mensagem de logout
        if (session.getAttribute("mensagemGlobal") != null) {
            model.addAttribute("mensagemGlobal", session.getAttribute("mensagemGlobal"));
            session.removeAttribute("mensagemGlobal");
        }
        List<Cachorro> cachorros = new CachorroService().listarDisponiveisParaAdocao();
        model.addAttribute("cachorrosDisponiveis", cachorros);

        return "index";
    }


    //admin

    @GetMapping("/gerenciar")
    public String gerenciar(Model model) {
        model.addAttribute("cachorros", new CachorroService().listar());
        return "pages/cachorros";
    }

    @PostMapping("/cadastrar")
    public String cadastrar(Cachorro cachorro, @RequestParam("novasImagens") List<MultipartFile> novasImagens, RedirectAttributes redirectAttributes) {
        Cachorro cachorroInserido = new CachorroService().inserir(cachorro);
        if (cachorroInserido != null) {
            if (novasImagens != null && !novasImagens.get(0).isEmpty()) {
                try {
                    List<String> nomesSalvos = salvarArquivos(novasImagens);
                    new CachorroService().salvarImagens(cachorroInserido.getId(), nomesSalvos);
                } catch (IOException e) {
                    redirectAttributes.addFlashAttribute("msg", "Erro ao salvar imagens.");
                    return "redirect:/cachorros/gerenciar";
                }
            }
            redirectAttributes.addFlashAttribute("msg", "Sucesso ao inserir cachorro!");
        } else {
            redirectAttributes.addFlashAttribute("msg", "Erro ao inserir cachorro.");
        }
        return "redirect:/cachorros/gerenciar";
    }


    @GetMapping("/excluir/{id}")
    public String excluir(@PathVariable int id, RedirectAttributes redirectAttributes) {
        String retorno = new CachorroService().excluir(id);
        redirectAttributes.addFlashAttribute("msg", retorno);
        return "redirect:/cachorros/gerenciar";
    }


    @GetMapping("/editar/{id}")
    public String showFormEdicao(@PathVariable int id, Model model) {
        Cachorro cachorro = new CachorroService().buscar(id);
        model.addAttribute("cachorro", cachorro);
        return "pages/alterarCachorro";
    }

    @PostMapping("/editar")
    public String editar(
            Cachorro cachorro,
            @RequestParam("novasImagens") List<MultipartFile> novasImagens,
            RedirectAttributes redirectAttributes
    ) {
        String retorno = new CachorroService().alterar(cachorro);

        // A lógica de salvar agora usa a variável 'novasImagens'
        if (novasImagens != null && !novasImagens.get(0).isEmpty()) {
            try {
                List<String> nomesSalvos = salvarArquivos(novasImagens);
                new CachorroService().salvarImagens(cachorro.getId(), nomesSalvos);
            } catch (IOException e) {
                redirectAttributes.addFlashAttribute("msg", "Dados alterados, mas houve erro ao salvar novas imagens.");
                return "redirect:/cachorros/gerenciar";
            }
        }

        redirectAttributes.addFlashAttribute("msg", retorno);
        return "redirect:/cachorros/gerenciar";
    }


    //metodo aux devolve a lista com nome dos arquivos
    private List<String> salvarArquivos(List<MultipartFile> files) throws IOException {
        String uploadPath = servletContext.getRealPath("") + File.separator + "imagens";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        List<String> nomesDosArquivosSalvos = new ArrayList<>();
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String nomeOriginal = file.getOriginalFilename();
                String nomeUnico = System.currentTimeMillis() + "_" + nomeOriginal;
                Files.copy(file.getInputStream(), Paths.get(uploadPath, nomeUnico));
                nomesDosArquivosSalvos.add(nomeUnico);
            }
        }
        return nomesDosArquivosSalvos;
    }

    @GetMapping("/imagem/excluir")
    public String excluirImagem(@RequestParam int idCachorro, @RequestParam String nomeImagem, RedirectAttributes redirectAttributes) {
        String uploadPath = servletContext.getRealPath("") + File.separator + "imagens";

        if (new CachorroService().excluirImagem(nomeImagem, uploadPath)) {
            redirectAttributes.addFlashAttribute("msg", "Imagem excluída com sucesso!");
        } else {
            redirectAttributes.addFlashAttribute("msg", "Erro ao excluir a imagem.");
        }

        return "redirect:/cachorros/editar/" + idCachorro;
    }
}