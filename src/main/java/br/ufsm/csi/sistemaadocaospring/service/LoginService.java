package br.ufsm.csi.sistemaadocaospring.service;

import br.ufsm.csi.sistemaadocaospring.dao.UsuarioDAO;
import br.ufsm.csi.sistemaadocaospring.model.Usuario;

public class LoginService {

    public Usuario autenticar(String email, String senha) {

        Usuario usuario = new UsuarioDAO ().buscar ( email );

        if (usuario != null && usuario.getSenha() != null) {
            if (usuario.getSenha().equals(senha)) {
                //autenticação bem sucedida
                usuario.setSenha(null);
                return usuario;
            }
        }
        // falha na autenticação ou usuário não encontrado
        return null;
    }
}
