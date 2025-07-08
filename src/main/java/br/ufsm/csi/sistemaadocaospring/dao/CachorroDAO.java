package br.ufsm.csi.sistemaadocaospring.dao;

import br.ufsm.csi.sistemaadocaospring.model.Cachorro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CachorroDAO {

    private ImagemCachorroDAO imagemDAO = new ImagemCachorroDAO();

    public Cachorro inserirCachorro(Cachorro cachorro) {
        String sql = "INSERT INTO cachorro (nome, raca, sexo, porte, adotado) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, cachorro.getNome());
            stmt.setString(2, cachorro.getRaca());
            stmt.setString(3, cachorro.getSexo());
            stmt.setString(4, cachorro.getPorte());
            stmt.setBoolean(5, cachorro.isAdotado());

            int affectedRows = stmt.executeUpdate();

            //se a inserção funcionou
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        //define o id no objeto cachorro
                        cachorro.setId(generatedKeys.getInt(1));
                        // Retorna o objeto completo, agora com o ID
                        System.out.println("-----> DAO: ID do cachorro gerado pelo banco: " + cachorro.getId());
                        return cachorro;
                    }
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Erro ao inserir cachorro: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }


    public boolean excluirCachorro(int id) {
        String sql = "DELETE FROM cachorro WHERE id = ?";

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Erro ao excluir cachorro: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public boolean alterarCachorro(Cachorro cachorro) {
        String sql = "UPDATE cachorro SET nome = ?, raca = ?, sexo = ?, porte = ?, adotado = ? WHERE id = ?";

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cachorro.getNome());
            stmt.setString(2, cachorro.getRaca());
            stmt.setString(3, cachorro.getSexo());
            stmt.setString(4, cachorro.getPorte());
            stmt.setBoolean(5, cachorro.isAdotado());
            stmt.setInt(6, cachorro.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Erro SQL ao atualizar cachorro: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean marcarComoAdotado(int idCachorro) {
        String sql = "UPDATE cachorro SET adotado = TRUE WHERE id = ?";

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idCachorro);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("DAO: Erro ao marcar cachorro ID " + idCachorro + " como adotado: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public ArrayList<Cachorro> listarCachorro() {
        ArrayList<Cachorro> cachorros = new ArrayList<>();
        String sql = "SELECT * FROM cachorro ORDER BY nome";

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Cachorro c = new Cachorro();
                c.setId(rs.getInt("id"));
                c.setNome(rs.getString("nome"));
                c.setRaca(rs.getString("raca"));
                c.setSexo(rs.getString("sexo"));
                c.setPorte(rs.getString("porte"));
                c.setAdotado(rs.getBoolean("adotado"));

                //busca a lista d imagens
                List<String> imagens = imagemDAO.buscarImagensPorCachorroId(c.getId());
                c.setImagens(imagens);

                cachorros.add(c);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao listar todos os cachorros: " + e.getMessage());
            e.printStackTrace();
        }
        return cachorros;
    }

    public ArrayList<Cachorro> listarCachorrosDisponiveis() {
        ArrayList<Cachorro> cachorros = new ArrayList<>();
        String sql = "SELECT * FROM cachorro WHERE adotado = false ORDER BY nome";

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Cachorro c = new Cachorro();
                c.setId(rs.getInt("id"));
                c.setNome(rs.getString("nome"));
                c.setRaca(rs.getString("raca"));
                c.setSexo(rs.getString("sexo"));
                c.setPorte(rs.getString("porte"));
                c.setAdotado(rs.getBoolean("adotado"));

                List<String> imagens = imagemDAO.buscarImagensPorCachorroId(c.getId());
                c.setImagens(imagens);

                cachorros.add(c);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao listar cachorros disponíveis: " + e.getMessage());
            e.printStackTrace();
        }
        return cachorros;
    }

    public Cachorro buscarCachorroPorId(int id) {
        String sql = "SELECT * FROM cachorro WHERE id = ?";
        Cachorro cachorro = new Cachorro();

        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cachorro.setId(rs.getInt("id"));
                    cachorro.setNome(rs.getString("nome"));
                    cachorro.setRaca(rs.getString("raca"));
                    cachorro.setSexo(rs.getString("sexo"));
                    cachorro.setPorte(rs.getString("porte"));
                    cachorro.setAdotado(rs.getBoolean("adotado"));

                    List<String> imagens = imagemDAO.buscarImagensPorCachorroId(cachorro.getId());
                    cachorro.setImagens(imagens);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao buscar cachorro por ID: " + e.getMessage());
            e.printStackTrace();
        }
        return cachorro;
    }
}