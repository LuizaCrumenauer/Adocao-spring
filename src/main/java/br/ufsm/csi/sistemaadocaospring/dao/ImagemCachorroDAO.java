
package br.ufsm.csi.sistemaadocaospring.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ImagemCachorroDAO {

    public void inserirImagens(int cachorroId, List<String> nomesArquivos) {
        String sql = "INSERT INTO cachorro_imagens (id_cachorro, caminho_imagem) VALUES (?, ?)";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress()) {
            for (String nomeArquivo : nomesArquivos) {
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, cachorroId);
                    stmt.setString(2, nomeArquivo);
                    stmt.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<String> buscarImagensPorCachorroId(int cachorroId) {
        List<String> imagens = new ArrayList<>();
        String sql = "SELECT caminho_imagem FROM cachorro_imagens WHERE id_cachorro = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cachorroId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    imagens.add(rs.getString("caminho_imagem"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return imagens;
    }


    public boolean excluirImagem(String nomeImagem) {

        String sql = "DELETE FROM cachorro_imagens WHERE caminho_imagem = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nomeImagem);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}