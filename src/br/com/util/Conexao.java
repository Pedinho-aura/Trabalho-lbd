/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author tharlis.agrario
 */
public class Conexao {
     // Construtor privado: a classe oferece apenas métodos utilitários
    private Conexao() {
    }

    // Abre uma conexão com o banco de dados
    public static Connection abrirBanco() throws SQLException {

        Properties propriedades = new Properties();

        try (FileInputStream arquivo =
                     new FileInputStream("config.properties")) {

            propriedades.load(arquivo);

        } catch (IOException e) {
            throw new SQLException(
                    "Não foi possível carregar a configuração do banco.",
                    e
            );
        }

        String url = propriedades.getProperty("db.url");
        String usuario = propriedades.getProperty("db.user");
        String senha = propriedades.getProperty("db.password");

        if (url == null || usuario == null || senha == null
                || url.isBlank() || usuario.isBlank()) {

            throw new SQLException(
                    "A configuração do banco está incompleta."
            );
        }

        return DriverManager.getConnection(url, usuario, senha);
    }
}


