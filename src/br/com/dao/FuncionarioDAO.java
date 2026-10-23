/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.dao;

import br.com.entidade.Funcionario;
import br.com.util.Conexao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class FuncionarioDAO {
    public int inserir(Funcionario funcionario) throws SQLException {
        String sql = "INSERT INTO funcionario "
                   + "(nome, cpf, data_admissao, id_supervisor) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(
                     sql, Statement.RETURN_GENERATED_KEYS)) {

            comando.setString(1, funcionario.getNome());
            comando.setString(2, funcionario.getCpf());
            comando.setDate(3, Date.valueOf(
                    funcionario.getDataAdmissao()));

            if (funcionario.getIdSupervisor() == null) {
                comando.setNull(4, java.sql.Types.INTEGER);
            } else {
                comando.setInt(4, funcionario.getIdSupervisor());
            }

            if (comando.executeUpdate() == 0) {
                throw new SQLException(
                        "Não foi possível cadastrar o funcionário.");
            }

            try (ResultSet chaves = comando.getGeneratedKeys()) {
                if (chaves.next()) {
                    return chaves.getInt(1);
                }
            }

            throw new SQLException(
                    "Não foi possível obter o ID do funcionário.");
        }
    }

    public List<Funcionario> listarTodos() throws SQLException {
        String sql = "SELECT id_funcionario, nome, cpf, "
                   + "data_admissao, id_supervisor "
                   + "FROM funcionario ORDER BY id_funcionario";

        List<Funcionario> funcionarios = new ArrayList<>();

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {
                funcionarios.add(mapearFuncionario(resultado));
            }
        }

        return funcionarios;
    }

    public Funcionario buscarPorId(int idFuncionario)
            throws SQLException {

        String sql = "SELECT id_funcionario, nome, cpf, "
                   + "data_admissao, id_supervisor "
                   + "FROM funcionario WHERE id_funcionario = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idFuncionario);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    return mapearFuncionario(resultado);
                }
            }
        }

        return null;
    }

    public boolean atualizar(Funcionario funcionario)
            throws SQLException {

        String sql = "UPDATE funcionario "
                   + "SET nome = ?, cpf = ?, data_admissao = ?, "
                   + "id_supervisor = ? WHERE id_funcionario = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, funcionario.getNome());
            comando.setString(2, funcionario.getCpf());
            comando.setDate(3, Date.valueOf(
                    funcionario.getDataAdmissao()));

            if (funcionario.getIdSupervisor() == null) {
                comando.setNull(4, java.sql.Types.INTEGER);
            } else {
                comando.setInt(4, funcionario.getIdSupervisor());
            }

            comando.setInt(5, funcionario.getIdFuncionario());

            return comando.executeUpdate() > 0;
        }
    }

    public boolean excluir(int idFuncionario) throws SQLException {
        String sql = "DELETE FROM funcionario "
                   + "WHERE id_funcionario = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idFuncionario);

            return comando.executeUpdate() > 0;
        }
    }

    private Funcionario mapearFuncionario(ResultSet resultado)
            throws SQLException {

        Funcionario funcionario = new Funcionario();

        funcionario.setIdFuncionario(
                resultado.getInt("id_funcionario"));
        funcionario.setNome(resultado.getString("nome"));
        funcionario.setCpf(resultado.getString("cpf"));

        Date data = resultado.getDate("data_admissao");
        if (data != null) {
            funcionario.setDataAdmissao(data.toLocalDate());
        }

        int idSupervisor = resultado.getInt("id_supervisor");
        if (resultado.wasNull()) {
            funcionario.setIdSupervisor(null);
        } else {
            funcionario.setIdSupervisor(idSupervisor);
        }

        return funcionario;
    }
}
