/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.controle;

/**
 *
 * @author Vinicius Andrade
 */

import br.com.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TransacaoControle {

    public void quitarDemandaEFinalizar(int idDemanda, double valorPagamento, int idFormaPagamento) throws SQLException {
        // Consultas baseadas exatamente nas suas tabelas do script SQL
        String sqlPagamento = "INSERT INTO pagamento (valor_pagamento, data_pagamento, id_demanda, id_forma) VALUES (?, NOW(), ?, ?)";
        String sqlAtualizaDemanda = "UPDATE demanda SET status = 'Finalizado' WHERE id_demanda = ?";
        
        Connection conexao = null;
        try {
            // Abre a conexão utilizando o seu config.properties
            conexao = Conexao.abrirBanco();
            
            // 1. Início da transação explícita (Desativa o auto-commit)
            conexao.setAutoCommit(false);
            
            // 2. Operação 1: Regista o pagamento na tabela 'pagamento'
            try (PreparedStatement stmtPag = conexao.prepareStatement(sqlPagamento)) {
                stmtPag.setDouble(1, valorPagamento);
                stmtPag.setInt(2, idDemanda);
                stmtPag.setInt(3, idFormaPagamento);
                stmtPag.executeUpdate();
            }
            
            // --- SIMULAÇÃO DE FALHA (Exigido pelo Requisito B3 para provar o ROLLBACK) ---
            // Descomente a linha abaixo durante os testes/apresentação para forçar a falha:
            // if (true) { throw new SQLException("Simulação de falha proposital no meio da transação!"); }
            
            // 3. Operação 2: Atualiza o status da demanda para 'Finalizado' na tabela 'demanda' (RN02)
            try (PreparedStatement stmtDem = conexao.prepareStatement(sqlAtualizaDemanda)) {
            stmtDem.setInt(1, idDemanda);
            stmtDem.executeUpdate();
            }
            
            // 4. Se tudo correu bem, consolida as alterações no banco de dados
            conexao.commit();
            System.out.println("Transação concluída com sucesso! Pagamento registado e demanda finalizada.");
            
        } catch (SQLException e) {
            // 5. Em caso de qualquer erro, desfaz tudo (Garante a integridade exigida no projeto)
            if (conexao != null) {
                try {
                    conexao.rollback();
                    System.err.println("Erro detetado na transação. Executado ROLLBACK com sucesso.");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e; // Repassa o erro para a camada de visão tratar e exibir a mensagem amigável
        } finally {
            // Fecha a conexão com segurança
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}