/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.OficinaDF;

import br.com.dao.ClienteDAO;
import br.com.dao.VeiculoDAO;
import br.com.entidade.Cliente;
import br.com.entidade.Veiculo;

import java.sql.SQLException;
import java.util.List;
/**
 *
 * @author tharlis.agrario
 */
public class TesteVeiculo {
     public static void main(String[] args) {

        ClienteDAO clienteDAO = new ClienteDAO();
        VeiculoDAO veiculoDAO = new VeiculoDAO();

        int idCliente = 0;
        String placa = "TST" + (System.currentTimeMillis() % 1000000);
        boolean veiculoCadastrado = false;

        try {
            System.out.println("=== TESTE DO VEICULODAO ===");

            // 1. Criar cliente para satisfazer a chave estrangeira
            Cliente cliente = new Cliente();
            cliente.setNome("Cliente Teste Veiculo");

            idCliente = clienteDAO.inserir(cliente);

            System.out.println("[OK] Cliente de teste criado: " + idCliente);

            // 2. Inserir veículo
            Veiculo veiculo = new Veiculo();
            veiculo.setPlaca(placa);
            veiculo.setModelo("Modelo Teste");
            veiculo.setIdCliente(idCliente);

            boolean inserido = veiculoDAO.inserir(veiculo);
            veiculoCadastrado = inserido;

            if (!inserido) {
                throw new SQLException("O veículo não foi inserido.");
            }

            System.out.println("[OK] Inserção de veículo");

            // 3. Buscar veículo pela placa
            Veiculo encontrado = veiculoDAO.buscarPorPlaca(placa);

            if (encontrado == null) {
                throw new SQLException("Veículo não encontrado após inserção.");
            }

            System.out.println("[OK] Busca por placa");

            // 4. Listar veículos
            List<Veiculo> veiculos = veiculoDAO.listarTodos();

            boolean constaNaLista = veiculos.stream()
                    .anyMatch(v -> placa.equals(v.getPlaca()));

            if (!constaNaLista) {
                throw new SQLException("Veículo não encontrado na listagem.");
            }

            System.out.println("[OK] Listagem de veículos");

            // 5. Atualizar veículo
            veiculo.setModelo("Modelo Atualizado");

            boolean atualizado = veiculoDAO.atualizar(veiculo);

            if (!atualizado) {
                throw new SQLException("A atualização não foi realizada.");
            }

            Veiculo atualizadoNoBanco =
                    veiculoDAO.buscarPorPlaca(placa);

            if (atualizadoNoBanco == null
                    || !"Modelo Atualizado".equals(
                            atualizadoNoBanco.getModelo())) {
                throw new SQLException(
                        "O modelo atualizado não foi confirmado.");
            }

            System.out.println("[OK] Atualização de veículo");

            // 6. Excluir veículo
            boolean excluido = veiculoDAO.excluir(placa);

            if (!excluido) {
                throw new SQLException("O veículo não foi excluído.");
            }

            veiculoCadastrado = false;

            if (veiculoDAO.buscarPorPlaca(placa) != null) {
                throw new SQLException(
                        "O veículo ainda existe após a exclusão.");
            }

            System.out.println("[OK] Exclusão de veículo");

            System.out.println("\n=== TODOS OS TESTES PASSARAM ===");

        } catch (Exception e) {
            System.err.println("\n[ERRO] " + e.getMessage());
            e.printStackTrace();

        } finally {
            // Limpeza dos registros criados pelo teste
            try {
                if (veiculoCadastrado) {
                    veiculoDAO.excluir(placa);
                }

                if (idCliente > 0) {
                    clienteDAO.excluir(idCliente);
                }

                System.out.println(
                        "Limpeza dos registros de teste concluída.");

            } catch (SQLException e) {
                System.err.println(
                        "Atenção: não foi possível concluir a limpeza: "
                        + e.getMessage());
            }
        }
    }
}
