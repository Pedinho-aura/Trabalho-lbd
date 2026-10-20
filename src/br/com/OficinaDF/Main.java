/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.OficinaDF;

import br.com.util.Conexao;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author tharlis.agrario
 */
public class Main {
//teste da silva
    public static void main(String[] args) {
        try (Connection conexao = Conexao.abrirBanco()) {
            System.out.println("Conexão estabelecida com sucesso!");
            System.out.println("Banco conectado: "
                    + conexao.getCatalog());
        } catch (SQLException e) {
            System.err.println("Falha ao conectar ao banco de dados.");
            System.err.println("Motivo: " + e.getMessage());
        }
    }
}


