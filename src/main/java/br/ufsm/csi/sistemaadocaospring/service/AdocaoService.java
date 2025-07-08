package br.ufsm.csi.sistemaadocaospring.service;

import br.ufsm.csi.sistemaadocaospring.dao.AdocaoDAO;
import br.ufsm.csi.sistemaadocaospring.dao.CachorroDAO;
import br.ufsm.csi.sistemaadocaospring.model.Adocao;
import br.ufsm.csi.sistemaadocaospring.model.Cachorro;

import java.util.List;


public class AdocaoService {

    private AdocaoDAO adocaoDAO;
    private CachorroDAO cachorroDAO;

    public AdocaoService() {
        this.adocaoDAO = new AdocaoDAO();
        this.cachorroDAO = new CachorroDAO();
    }

    public String registrarAdocao(Adocao adocao) {


        Cachorro cachorro = cachorroDAO.buscarCachorroPorId(adocao.getCachorroId ());
        if (cachorro == null) {
            return "Erro: Cachorro não encontrado.";
        }
        if (cachorro.isAdotado()) {
            return "Erro: Este cachorro já foi adotado.";
        }

        adocaoDAO.inserirAdocao(adocao);

        boolean cachorroAtualizado = cachorroDAO.marcarComoAdotado(adocao.getCachorroId ());
        if (cachorroAtualizado) {
                return "Adoção registrada com sucesso!";
        }else {
            return "Erro ao registrar a adoção no banco de dados.";
        }
    }

    public List<Adocao> listarMinhasAdocoes(int idUsuario) {

        return adocaoDAO.listarAdocoesPorUsuario(idUsuario);
    }


    public Adocao obterAdocaoParaEdicao(int adocaoId) {
        return adocaoDAO.buscarAdocaoPorId(adocaoId);
    }


    public String salvarAlteracoesInformacoesAdocao(int adocaoId, String novasInformacoes) {

        if (novasInformacoes == null || novasInformacoes.trim().isEmpty()) {
            return "Erro: O campo 'Informações' não pode estar vazio.";
        }

        if (adocaoDAO.atualizarInformacoesAdocao(adocaoId, novasInformacoes.trim())) {
            return "Informações da adoção atualizadas com sucesso!";
        } else {
            return "Erro ao atualizar as informações da adoção. Verifique se a adoção existe ou tente novamente.";
        }
    }

    public boolean removerVinculoAdocao(int idCachorro) {
        if (adocaoDAO.excluirPorIdCachorro(idCachorro)){
            return true;
        }
        return false;
    }

}
