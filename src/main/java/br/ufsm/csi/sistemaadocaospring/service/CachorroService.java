package br.ufsm.csi.sistemaadocaospring.service;

import br.ufsm.csi.sistemaadocaospring.dao.CachorroDAO;
import br.ufsm.csi.sistemaadocaospring.dao.ImagemCachorroDAO;
import br.ufsm.csi.sistemaadocaospring.model.Cachorro;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class CachorroService {

    private CachorroDAO cachorroDAO = new CachorroDAO();
    private ImagemCachorroDAO imagemDAO = new ImagemCachorroDAO();

    public Cachorro inserir(Cachorro cachorro) {
        // Regra de negocio, td cachorro novo começa como 'não adotado'.
        cachorro.setAdotado(false);

        return cachorroDAO.inserirCachorro(cachorro);
    }

    public void salvarImagens(int cachorroId, List<String> nomesArquivos) {
        imagemDAO.inserirImagens(cachorroId, nomesArquivos);
    }


    public String alterar(Cachorro cachorro) {

        if (cachorroDAO.alterarCachorro(cachorro)) {

            //se for marcado como nao adotado, deve-se remover o vinculo de adocao
            // Se alterou e o novo status do cachorro é 'não adotado'
            if (!cachorro.isAdotado()) {
                System.out.println("SERVICE: Cachorro ID " + cachorro.getId() + " marcado como 'não adotado'. Removendo vínculo de adoção...");
                new AdocaoService().removerVinculoAdocao(cachorro.getId());
            }
            return "Sucesso ao alterar cachorro";
        } else {
            return "Erro ao alterar cachorro";
        }
    }

    public String excluir(int id) {
        if (cachorroDAO.excluirCachorro(id)) {
            return "Sucesso ao excluir cachorro";
        } else {
            return "Erro ao excluir cachorro";
        }
    }

    //lista adotads e nao adotados
    public ArrayList<Cachorro> listar() {
        return cachorroDAO.listarCachorro();
    }

    public List<Cachorro> listarDisponiveisParaAdocao() {
        return cachorroDAO.listarCachorrosDisponiveis();
    }


    public Cachorro buscar(int id) {
        return cachorroDAO.buscarCachorroPorId(id);
    }

    public boolean excluirImagem(String nomeImagem, String caminhoAbsolutoParaPastaImagens) {
        //exclui no banco
        if (imagemDAO.excluirImagem(nomeImagem)) {
            //exclui arquivo fisico
            try {
                File arquivoParaExcluir = new File(caminhoAbsolutoParaPastaImagens + File.separator + nomeImagem);
                if (arquivoParaExcluir.exists()) {
                    return arquivoParaExcluir.delete();
                }
                return true;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        return false; //falso se nao apagou no banco
    }
}