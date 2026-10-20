/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.OficinaDF;

import br.com.controle.TransacaoControle;
import br.com.util.Conexao;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author tharlis.agrario
 */
public class Main {
    public static void main(String[] args) {
        // Teste de conexão existente
        try (Connection conexao = Conexao.abrirBanco()) {
            System.out.println("Conexão estabelecida com sucesso!");
            System.out.println("Banco conectado: " + conexao.getCatalog());
        } catch (SQLException e) {
            System.err.println("Falha ao conectar ao banco de dados.");
            System.err.println("Motivo: " + e.getMessage());
            return; // Se falhar a conexão, interrompe a execução
        }

        // Teste da transação de quitação e finalização
        System.out.println("\n--- A testar a transação de quitação e finalização ---");
        TransacaoControle transacaoControle = new TransacaoControle();
        
        try {
            // IDs válidos baseados no script SQL fornecido (Demanda 37 está ABERTA, Forma 2 é PIX)[cite: 20]
            int idDemanda = 37; 
            double valorPago = 150.00;
            int idFormaPagamento = 2; 

            // Executa o método transacional com controlo de commit/rollback
            transacaoControle.quitarDemandaEFinalizar(idDemanda, valorPago, idFormaPagamento);
            
            System.out.println("Sucesso! Transação executada e confirmada (Commit realizado).");
        } catch (Exception e) {
            System.err.println("Erro detetado na transação! O mecanismo de rollback reverteu as alterações.");
            e.printStackTrace();
        }
    }
}