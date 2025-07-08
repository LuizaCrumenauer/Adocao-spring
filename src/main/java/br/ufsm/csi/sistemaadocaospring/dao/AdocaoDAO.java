package br.ufsm.csi.sistemaadocaospring.dao;

import br.ufsm.csi.sistemaadocaospring.model.Adocao;
import br.ufsm.csi.sistemaadocaospring.model.Cachorro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdocaoDAO {

    public boolean inserirAdocao( Adocao adocao) {
        String sql = "INSERT INTO adocao (cachorro_id, adotante_id, informacoes) VALUES (?, ?, ?)";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adocao.getCachorroId ());
            stmt.setInt(2, adocao.getAdotanteId());
            stmt.setString(3, adocao.getInformacoes ());

            stmt.execute();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao inserir adoção: " + e.getMessage());
        }
        return false;
    }

    //usada apenas para teste, na pag a exclusao foi feita por id do cachorro
    public boolean excluirAdocao(int id) {
        String sql = "DELETE FROM adocao WHERE id = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            stmt.execute();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao excluir adoção: " + e.getMessage());
        }
        return true;
    }

    public boolean excluirPorIdCachorro(int cachorro_id) {

        String sql = "DELETE FROM adocao WHERE cachorro_id = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cachorro_id);

            stmt.execute();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao excluir adoção: " + e.getMessage());
        }
        return true;

    }

    public boolean atualizarInformacoesAdocao(int adocaoId, String novasInformacoes) {
        String sql = "UPDATE adocao SET informacoes = ? WHERE id = ?";
        System.out.println("DAO: Tentando atualizar informações para adocao ID: " + adocaoId);
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, novasInformacoes);
            stmt.setInt(2, adocaoId);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("DAO: Informações da adoção ID " + adocaoId + " atualizadas com sucesso.");
                return true;
            } else {
                System.out.println("DAO: Nenhuma linha atualizada para adoção ID " + adocaoId + ". Adoção não encontrada ou informações já eram as mesmas.");
                return false;
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("DAO: Erro ao atualizar informações da adoção ID " + adocaoId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public List<Adocao> listarAdocoes() {
        List<Adocao> lista = new ArrayList<> ();
        String sql = "SELECT * FROM adocao";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Adocao a = new Adocao();
                a.setId(rs.getInt("id"));
                a.setCachorroId(rs.getInt("cachorro_id"));
                a.setAdotanteId(rs.getInt("adotante_id"));
                a.setInformacoes (rs.getString("informacoes"));

                lista.add(a);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao listar adoções: " + e.getMessage());
        }
        return lista;
    }


    public Adocao buscarAdocaoPorId(int id) {
        String sql = "SELECT a.id as adocao_id, a.cachorro_id, a.adotante_id, a.informacoes, " +
                "c.nome as nome_cachorro, c.raca as raca_cachorro, c.porte as porte_cachorro " +
                "FROM adocao a " +
                "JOIN cachorro c ON a.cachorro_id = c.id " +
                "WHERE a.id = ?";
        Adocao adocao = null;
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    adocao = new Adocao();
                    adocao.setId(rs.getInt("adocao_id"));
                    adocao.setCachorroId(rs.getInt("cachorro_id"));
                    adocao.setAdotanteId(rs.getInt("adotante_id"));
                    adocao.setInformacoes (rs.getString("informacoes"));

                    //o objeto Cachorro dentro de Adocao
                    Cachorro cachorro = new Cachorro();
                    cachorro.setId(rs.getInt("cachorro_id"));
                    cachorro.setNome(rs.getString("nome_cachorro"));
                    cachorro.setRaca(rs.getString("raca_cachorro"));
                    cachorro.setPorte(rs.getString("porte_cachorro"));

                    adocao.setCachorro(cachorro);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao buscar adoção por ID com detalhes do cachorro: " + e.getMessage());
            e.printStackTrace(); // Adicionado
        }
        return adocao;
    }

    public List<Adocao> listarAdocoesPorUsuario(int idUsuario) {
        List<Adocao> lista = new ArrayList<>();
        //já busca o id do cachorro e o nome do cachorro.
        String sql = "SELECT a.id as adocao_id, a.cachorro_id, a.adotante_id, a.informacoes, " +
                "c.nome as nome_cachorro, c.raca as raca_cachorro, c.porte as porte_cachorro " +
                "FROM adocao a " +
                "JOIN cachorro c ON a.cachorro_id = c.id " +
                "WHERE a.adotante_id = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Adocao a = new Adocao();
                    a.setId(rs.getInt("adocao_id"));
                    a.setAdotanteId(rs.getInt("adotante_id"));
                    a.setInformacoes(rs.getString("informacoes"));

                    Cachorro c = new Cachorro ();
                    c.setId(rs.getInt("cachorro_id"));
                    c.setNome(rs.getString("nome_cachorro"));
                    c.setRaca(rs.getString("raca_cachorro"));
                    c.setPorte(rs.getString("porte_cachorro"));

                    a.setCachorro(c); //associa o objeto Cachorro ao Adocao
                    lista.add(a);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao listar adoções do usuário: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
}
