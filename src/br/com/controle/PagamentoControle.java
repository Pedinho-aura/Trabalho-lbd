/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.controle;

import br.com.dao.PagamentoDAO;
import br.com.entidade.Pagamento;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class PagamentoControle {
    private final PagamentoDAO pagamentoDAO;

    public PagamentoControle() {
        this.pagamentoDAO = new PagamentoDAO();
    }

    public int cadastrar(
            BigDecimal valorPagamento,
            LocalDateTime dataPagamento,
            int idDemanda,
            int idForma) throws SQLException {

        validarValor(valorPagamento);
        validarDataPagamento(dataPagamento);
        validarIdDemanda(idDemanda);
        validarIdForma(idForma);

        Pagamento pagamento = new Pagamento(
                valorPagamento, dataPagamento, idDemanda, idForma);

        return pagamentoDAO.inserir(pagamento);
    }

    public List<Pagamento> listarTodos() throws SQLException {
        return pagamentoDAO.listarTodos();
    }

    public Pagamento buscarPorId(int idPagamento)
            throws SQLException {

        validarIdPagamento(idPagamento);
        return pagamentoDAO.buscarPorId(idPagamento);
    }

    public List<Pagamento> listarPorDemanda(int idDemanda)
            throws SQLException {

        validarIdDemanda(idDemanda);
        return pagamentoDAO.listarPorDemanda(idDemanda);
    }

    public boolean atualizar(
            int idPagamento,
            BigDecimal valorPagamento,
            LocalDateTime dataPagamento,
            int idDemanda,
            int idForma) throws SQLException {

        validarIdPagamento(idPagamento);
        validarValor(valorPagamento);
        validarDataPagamento(dataPagamento);
        validarIdDemanda(idDemanda);
        validarIdForma(idForma);

        Pagamento pagamento = new Pagamento(
                valorPagamento, dataPagamento, idDemanda, idForma);

        pagamento.setIdPagamento(idPagamento);

        return pagamentoDAO.atualizar(pagamento);
    }

    public boolean excluir(int idPagamento) throws SQLException {
        validarIdPagamento(idPagamento);
        return pagamentoDAO.excluir(idPagamento);
    }

    private void validarValor(BigDecimal valorPagamento) {
        if (valorPagamento == null
                || valorPagamento.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException(
                    "O valor do pagamento deve ser maior que zero.");
        }
    }

    private void validarDataPagamento(LocalDateTime dataPagamento) {
        if (dataPagamento == null) {
            throw new IllegalArgumentException(
                    "A data e hora do pagamento são obrigatórias.");
        }

        if (dataPagamento.isAfter(LocalDateTime.now())) {
            throw new IllegalArgumentException(
                    "A data e hora do pagamento não podem ser futuras.");
        }
    }

    private void validarIdPagamento(int idPagamento) {
        if (idPagamento <= 0) {
            throw new IllegalArgumentException(
                    "O ID do pagamento deve ser maior que zero.");
        }
    }

    private void validarIdDemanda(int idDemanda) {
        if (idDemanda <= 0) {
            throw new IllegalArgumentException(
                    "O ID da demanda deve ser maior que zero.");
        }
    }

    private void validarIdForma(int idForma) {
        if (idForma <= 0) {
            throw new IllegalArgumentException(
                    "O ID da forma de pagamento deve ser maior que zero.");
        }
    }
}
