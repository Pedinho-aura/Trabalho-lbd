/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.controle;

import br.com.dao.ClienteDAO;
import br.com.entidade.Cliente;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class ClienteControle {
    private final ClienteDAO clienteDAO;

    public ClienteControle() {
        this.clienteDAO = new ClienteDAO();
    }

    public int cadastrar(String nome) throws SQLException {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "O nome do cliente é obrigatório.");
        }

        Cliente cliente = new Cliente();
        cliente.setNome(nome.trim());

        return clienteDAO.inserir(cliente);
    }

    public List<Cliente> listarTodos() throws SQLException {
        return clienteDAO.listarTodos();
    }

    public Cliente buscarPorId(int idCliente) throws SQLException {
        if (idCliente <= 0) {
            throw new IllegalArgumentException(
                    "O ID do cliente deve ser maior que zero.");
        }

        return clienteDAO.buscarPorId(idCliente);
    }

    public boolean atualizar(int idCliente, String nome)
            throws SQLException {
        if (idCliente <= 0) {
            throw new IllegalArgumentException(
                    "O ID do cliente deve ser maior que zero.");
        }

        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "O nome do cliente é obrigatório.");
        }

        Cliente cliente = new Cliente();
        cliente.setIdCliente(idCliente);
        cliente.setNome(nome.trim());

        return clienteDAO.atualizar(cliente);
    }

    public boolean excluir(int idCliente) throws SQLException {
        if (idCliente <= 0) {
            throw new IllegalArgumentException(
                    "O ID do cliente deve ser maior que zero.");
        }

        return clienteDAO.excluir(idCliente);
    }
}
