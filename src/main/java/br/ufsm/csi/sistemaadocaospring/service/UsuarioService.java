package br.ufsm.csi.sistemaadocaospring.service;

import br.ufsm.csi.sistemaadocaospring.dao.UsuarioDAO;
import br.ufsm.csi.sistemaadocaospring.model.Usuario;

import java.util.ArrayList;

public class UsuarioService {

    private static UsuarioDAO dao = new UsuarioDAO();

    public String excluir(int id) {
        if (dao.excluir(id)) {
            return "Sucesso ao excluir usuário";
        } else {
            return "Erro ao excluir usuário";
        }
    }

    public ArrayList<Usuario> listar() {
        return dao.listar();
    }

    public Usuario buscar(int usuarioId) {
        return dao.buscar(usuarioId);
    }

    public String inserir(Usuario usuario) {

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        if (usuarioDAO.emailJaExiste(usuario.getEmail())) {
            return "Erro: O e-mail '" + usuario.getEmail() + "' já está cadastrado no sistema.";
        }

        System.out.println("Service - Inserindo Usuário: " + usuario.getEmail());
        if (dao.inserir(usuario)) {
            return "Sucesso ao inserir usuário";
        } else {
            return "Erro ao inserir usuário";
        }
    }


    public String alterar(Usuario usuario, boolean alterarSenha) {

        Usuario usuarioExistente = dao.buscar(usuario.getId());

        // verifica se o usuario está tentando remover seu proprio privilegio de admin
        if (usuarioExistente.isAdmin() && !usuario.isAdmin()) {
            //ve se é o unico admin
            long totalAdmins = dao.listar().stream().filter(Usuario::isAdmin).count();

            //se ele for o último admin, impede a alteração
            if (totalAdmins <= 1) {
                return "Erro: Não é possível remover o status de administrador do único admin existente no sistema.";
            }
        }

        if (!alterarSenha) {
            if(usuarioExistente != null) {
                usuario.setSenha(usuarioExistente.getSenha());
            } else {
                return "Erro: Usuário não encontrado para manter senha.";
            }
        }

        if (dao.alterar(usuario)) {
            return "Sucesso ao alterar usuário";
        } else {
            return "Erro ao alterar usuário";
        }
    }
}
