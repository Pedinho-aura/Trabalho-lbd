/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.dao;

import br.com.entidade.Demanda;
import br.com.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class DemandaDAO {
       public int inserir(Demanda demanda) throws SQLException {
        String sql = "INSERT INTO demanda "
                   + "(status, data_hora_abertura, placa) "
                   + "VALUES (?, ?, ?)";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(
                     sql, Statement.RETURN_GENERATED_KEYS)) {

            comando.setString(1, demanda.getStatus());
            comando.setTimestamp(
                    2, Timestamp.valueOf(demanda.getDataHoraAbertura()));
            comando.setString(3, demanda.getPlaca());

            if (comando.executeUpdate() == 0) {
                throw new SQLException(
                        "Não foi possível cadastrar a demanda.");
            }

            try (ResultSet chaves = comando.getGeneratedKeys()) {
                if (chaves.next()) {
                    return chaves.getInt(1);
                }
            }

            throw new SQLException(
                    "Não foi possível obter o ID da demanda.");
        }
    }

    public List<Demanda> listarTodos() throws SQLException {
        String sql = "SELECT id_demanda, status, "
                   + "data_hora_abertura, placa "
                   + "FROM demanda ORDER BY id_demanda";

        List<Demanda> demandas = new ArrayList<>();

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {
                demandas.add(mapearDemanda(resultado));
            }
        }

        return demandas;
    }

    public Demanda buscarPorId(int idDemanda) throws SQLException {
        String sql = "SELECT id_demanda, status, "
                   + "data_hora_abertura, placa "
                   + "FROM demanda WHERE id_demanda = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idDemanda);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    return mapearDemanda(resultado);
                }
            }
        }
        return null;
    }

    public boolean atualizar(Demanda demanda) throws SQLException {
        String sql = "UPDATE demanda "
                   + "SET status = ?, data_hora_abertura = ?, placa = ? "
                   + "WHERE id_demanda = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, demanda.getStatus());
            comando.setTimestamp(
                    2, Timestamp.valueOf(demanda.getDataHoraAbertura()));
            comando.setString(3, demanda.getPlaca());
            comando.setInt(4, demanda.getIdDemanda());

            return comando.executeUpdate() > 0;
        }
    }

    public boolean excluir(int idDemanda) throws SQLException {
        String sql = "DELETE FROM demanda WHERE id_demanda = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idDemanda);

            return comando.executeUpdate() > 0;
        }
    }

    private Demanda mapearDemanda(ResultSet resultado)
            throws SQLException {

        Demanda demanda = new Demanda();

        demanda.setIdDemanda(resultado.getInt("id_demanda"));
        demanda.setStatus(resultado.getString("status"));

        Timestamp dataHora =
                resultado.getTimestamp("data_hora_abertura");

        if (dataHora != null) {
            demanda.setDataHoraAbertura(dataHora.toLocalDateTime());
        }

        demanda.setPlaca(resultado.getString("placa"));

        return demanda;
    }
}
