/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.entidade;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author tharlis.agrario
 */
public class Pagamento {
    private int idPagamento;
    private BigDecimal valorPagamento;
    private LocalDateTime dataPagamento;
    private int idDemanda;
    private int idForma;

    public Pagamento() {
    }

    public Pagamento(
            BigDecimal valorPagamento,
            LocalDateTime dataPagamento,
            int idDemanda,
            int idForma) {

        this.valorPagamento = valorPagamento;
        this.dataPagamento = dataPagamento;
        this.idDemanda = idDemanda;
        this.idForma = idForma;
    }

    public int getIdPagamento() {
        return idPagamento;
    }

    public void setIdPagamento(int idPagamento) {
        this.idPagamento = idPagamento;
    }

    public BigDecimal getValorPagamento() {
        return valorPagamento;
    }

    public void setValorPagamento(BigDecimal valorPagamento) {
        this.valorPagamento = valorPagamento;
    }

    public LocalDateTime getDataPagamento() {
        return dataPagamento;
    }

    public void setDataPagamento(LocalDateTime dataPagamento) {
        this.dataPagamento = dataPagamento;
    }

    public int getIdDemanda() {
        return idDemanda;
    }

    public void setIdDemanda(int idDemanda) {
        this.idDemanda = idDemanda;
    }

    public int getIdForma() {
        return idForma;
    }

    public void setIdForma(int idForma) {
        this.idForma = idForma;
    }
}
