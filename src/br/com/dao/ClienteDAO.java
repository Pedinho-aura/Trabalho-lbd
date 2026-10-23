/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.dao;

import br.com.entidade.Cliente;
import br.com.util.Conexao;

import java.sql.Connection;
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
public class ClienteDAO {
    
    public int inserir(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (nome) VALUES (?)";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement( //Separa a instrução SQL dos valores fornecidos, ajudando a evitar SQL Injection, desde que não sejam concatenados na consulta
                     sql, Statement.RETURN_GENERATED_KEYS)) {

            comando.setString(1, cliente.getNome());

            int linhasAfetadas = comando.executeUpdate();

            if (linhasAfetadas == 0) {
                throw new SQLException("Não foi possível cadastrar o cliente.");
            }

            try (ResultSet chaves = comando.getGeneratedKeys()) {
                if (chaves.next()) {
                    return chaves.getInt(1);
                }
            }

            throw new SQLException(
                    "Cliente cadastrado, mas não foi possível obter seu ID.");
        }
    }

    public List<Cliente> listarTodos() throws SQLException {
        String sql = "SELECT id_cliente, nome FROM cliente ORDER BY id_cliente";

        List<Cliente> clientes = new ArrayList<>();

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {
                Cliente cliente = new Cliente();

                cliente.setIdCliente(resultado.getInt("id_cliente"));
                cliente.setNome(resultado.getString("nome"));

                clientes.add(cliente);
            }
        }

        return clientes;
    }

    public Cliente buscarPorId(int idCliente) throws SQLException {
        String sql = "SELECT id_cliente, nome "
                   + "FROM cliente WHERE id_cliente = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idCliente);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    Cliente cliente = new Cliente();

                    cliente.setIdCliente(resultado.getInt("id_cliente"));
                    cliente.setNome(resultado.getString("nome"));

                    return cliente;
                }
            }
        }

        return null; //retorna NULL, pois, o cliente pode não existir, a camada de controle deve tratar esse casoa antes de exibir
    }

    public boolean atualizar(Cliente cliente) throws SQLException {
        String sql = "UPDATE cliente SET nome = ? WHERE id_cliente = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, cliente.getNome());
            comando.setInt(2, cliente.getIdCliente());

            return comando.executeUpdate() > 0;//retorna booleano, indicando que alguma linha foi afetada
            //true : foi alterada ou removida; false: signfica que nenhuma linha foi afetada
        }
    }

    public boolean excluir(int idCliente) throws SQLException {
        String sql = "DELETE FROM cliente WHERE id_cliente = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, idCliente);

            return comando.executeUpdate() > 0; //mesma coisa de atualizar
        }
    }
}
