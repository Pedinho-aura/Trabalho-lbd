/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.dao;

import br.com.entidade.Pagamento;
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
public class PagamentoDAO {
    public int inserir(Pagamento pagamento) throws SQLException {
        String sql = "INSERT INTO pagamento "
                   + "(valor_pagamento, data_pagamento, id_demanda, id_forma) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(
                     sql, Statement.RETURN_GENERATED_KEYS)) {

            comando.setBigDecimal(1, pagamento.getValorPagamento());
            comando.setTimestamp(
                    2, Timestamp.valueOf(pagamento.getDataPagamento()));
            comando.setInt(3, pagamento.getIdDemanda());
            comando.setInt(4, pagamento.getIdForma());

            if (comando.executeUpdate() == 0) {
                throw new SQLException(
                        "Não foi possível cadastrar o pagamento.");
            }

            try (ResultSet chaves = comando.getGeneratedKeys()) {
                if (chaves.next()) {
                    return chaves.getInt(1);
                }
            }

            throw new SQLException(
                    "Pagamento cadastrado, mas não foi possível obter seu ID.");
        }
    }

    public List<Pagamento> listarTodos() throws SQLException {
        String sql = "SELECT id_pagamento, valor_pagamento, "
                   + "data_pagamento, id_demanda, id_forma "
                   + "FROM pagamento ORDER BY id_pagamento";

        List<Pagamento> pagamentos = new ArrayList<>();

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {
                pagamentos.add(mapearPagamento(resultado));
            }
        }

        return pagamentos;
    }

    public Pagamento buscarPorId(int idPagamento) throws SQLException {
        String sql = "SELECT id_pagamento, valor_pagamento, "
                   + "data_pagamento, id_demanda, id_forma "
                   + "FROM pagamento WHERE id_pagamento = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idPagamento);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    return mapearPagamento(resultado);
                }
            }
        }

        return null;
    }

    public List<Pagamento> listarPorDemanda(int idDemanda)
            throws SQLException {

        String sql = "SELECT id_pagamento, valor_pagamento, "
                   + "data_pagamento, id_demanda, id_forma "
                   + "FROM pagamento WHERE id_demanda = ? "
                   + "ORDER BY data_pagamento";

        List<Pagamento> pagamentos = new ArrayList<>();

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idDemanda);

            try (ResultSet resultado = comando.executeQuery()) {
                while (resultado.next()) {
                    pagamentos.add(mapearPagamento(resultado));
                }
            }
        }

        return pagamentos;
    }

    public boolean atualizar(Pagamento pagamento) throws SQLException {
        String sql = "UPDATE pagamento SET valor_pagamento = ?, "
                   + "data_pagamento = ?, id_demanda = ?, id_forma = ? "
                   + "WHERE id_pagamento = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setBigDecimal(1, pagamento.getValorPagamento());
            comando.setTimestamp(
                    2, Timestamp.valueOf(pagamento.getDataPagamento()));
            comando.setInt(3, pagamento.getIdDemanda());
            comando.setInt(4, pagamento.getIdForma());
            comando.setInt(5, pagamento.getIdPagamento());

            return comando.executeUpdate() > 0;
        }
    }

    public boolean excluir(int idPagamento) throws SQLException {
        String sql = "DELETE FROM pagamento WHERE id_pagamento = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idPagamento);

            return comando.executeUpdate() > 0;
        }
    }

    private Pagamento mapearPagamento(ResultSet resultado)
            throws SQLException {

        Pagamento pagamento = new Pagamento();

        pagamento.setIdPagamento(resultado.getInt("id_pagamento"));
        pagamento.setValorPagamento(resultado.getBigDecimal("valor_pagamento"));

        Timestamp dataPagamento = resultado.getTimestamp("data_pagamento");
        if (dataPagamento != null) {
            pagamento.setDataPagamento(dataPagamento.toLocalDateTime());
        }

        pagamento.setIdDemanda(resultado.getInt("id_demanda"));
        pagamento.setIdForma(resultado.getInt("id_forma"));

        return pagamento;
    }
}
