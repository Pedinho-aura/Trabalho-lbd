/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.OficinaDF;

import br.com.dao.ClienteDAO;
import br.com.entidade.Cliente;

import java.sql.SQLException;
import java.util.List;
/**
 *
 * @author tharlis.agrario
 */
public class TesteClienteDAO {
     public static void main(String[] args) {
        ClienteDAO dao = new ClienteDAO();
        int idCliente = 0;

        try {
            System.out.println("=== TESTE DO CLIENTEDAO ===");

            // 1. Inserção
            Cliente cliente = new Cliente();
            cliente.setNome("Cliente Teste DAO");

            idCliente = dao.inserir(cliente);

            System.out.println("[OK] Inserção de cliente: " + idCliente);

            // 2. Busca por ID
            Cliente encontrado = dao.buscarPorId(idCliente);

            if (encontrado == null
                    || !"Cliente Teste DAO".equals(encontrado.getNome())) {
                throw new SQLException("Falha na busca por ID.");
            }

            System.out.println("[OK] Busca por ID");

            // 3. Listagem
            List<Cliente> clientes = dao.listarTodos();
            boolean encontradoNaLista = false;

            for (Cliente c : clientes) {
                if (c.getIdCliente() == idCliente) {
                    encontradoNaLista = true;
                    break;
                }
            }

            if (!encontradoNaLista) {
                throw new SQLException("Cliente ausente da listagem.");
            }

            System.out.println("[OK] Listagem de clientes");

            // 4. Atualização
            cliente.setIdCliente(idCliente);
            cliente.setNome("Cliente Teste Atualizado");

            if (!dao.atualizar(cliente)) {
                throw new SQLException("Falha ao atualizar cliente.");
            }

            Cliente atualizado = dao.buscarPorId(idCliente);

            if (atualizado == null
                    || !"Cliente Teste Atualizado".equals(atualizado.getNome())) {
                throw new SQLException("Nome não foi atualizado corretamente.");
            }

            System.out.println("[OK] Atualização de cliente");

            // 5. Exclusão
            if (!dao.excluir(idCliente)) {
                throw new SQLException("Falha ao excluir cliente.");
            }

            if (dao.buscarPorId(idCliente) != null) {
                throw new SQLException("Cliente ainda existe após exclusão.");
            }

            idCliente = 0;
            System.out.println("[OK] Exclusão de cliente");

            System.out.println("\n=== TODOS OS TESTES PASSARAM ===");

        } catch (Exception e) {
            System.err.println("\n[ERRO] " + e.getMessage());
            e.printStackTrace();

        } finally {
            try {
                if (idCliente > 0) {
                    dao.excluir(idCliente);
                }

                System.out.println("Limpeza dos registros de teste concluída.");

            } catch (SQLException e) {
                System.err.println(
                        "Atenção: verifique a limpeza: " + e.getMessage());
            }
        }
    }
}
