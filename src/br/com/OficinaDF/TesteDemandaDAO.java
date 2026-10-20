/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.OficinaDF;

import br.com.dao.ClienteDAO;
import br.com.dao.VeiculoDAO;
import br.com.dao.DemandaDAO;
import br.com.entidade.Cliente;
import br.com.entidade.Veiculo;
import br.com.entidade.Demanda;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
/**
 *
 * @author tharlis.agrario
 */
public class TesteDemandaDAO {
    public static void main(String[] args) {
        ClienteDAO clienteDAO = new ClienteDAO();
        VeiculoDAO veiculoDAO = new VeiculoDAO();
        DemandaDAO demandaDAO = new DemandaDAO();

        int idCliente = 0;
        String placa = "T" + (System.currentTimeMillis() % 1000000);
        int idDemanda = 0;

        try {
            System.out.println("=== TESTE DO DEMANDADAO ===");

            // 1. Criar cliente de teste
            Cliente cliente = new Cliente();
            cliente.setNome("Cliente Teste Demanda");

            idCliente = clienteDAO.inserir(cliente);

            System.out.println("[OK] Cliente de teste criado: " + idCliente);

            // 2. Criar veículo de teste
            Veiculo veiculo = new Veiculo();
            veiculo.setPlaca(placa);
            veiculo.setModelo("Veículo Teste");
            veiculo.setIdCliente(idCliente);

            if (!veiculoDAO.inserir(veiculo)) {
                throw new SQLException("Falha ao inserir veículo.");
            }

            System.out.println("[OK] Veículo de teste criado: " + placa);

            // 3. Inserir demanda
            Demanda demanda = new Demanda();
            demanda.setStatus("Pendente");
            demanda.setDataHoraAbertura(
                    LocalDateTime.now().minusMinutes(1));
            demanda.setPlaca(placa);

            idDemanda = demandaDAO.inserir(demanda);

            System.out.println("[OK] Inserção de demanda: " + idDemanda);

            // 4. Buscar demanda por ID
            Demanda encontrada = demandaDAO.buscarPorId(idDemanda);

            if (encontrada == null
                    || !placa.equals(encontrada.getPlaca())
                    || !"Pendente".equals(encontrada.getStatus())) {
                throw new SQLException("Falha na busca da demanda.");
            }

            System.out.println("[OK] Busca por ID");

            // 5. Listar demandas
            List<Demanda> demandas = demandaDAO.listarTodos();
            boolean encontradaNaLista = false;

            for (Demanda d : demandas) {
                if (d.getIdDemanda() == idDemanda) {
                    encontradaNaLista = true;
                    break;
                }
            }

            if (!encontradaNaLista) {
                throw new SQLException("Demanda ausente da listagem.");
            }

            System.out.println("[OK] Listagem de demandas");

            // 6. Atualizar data, mantendo o status Pendente
            LocalDateTime novaData =
                    encontrada.getDataHoraAbertura().minusMinutes(1);

            encontrada.setDataHoraAbertura(novaData);

            if (!demandaDAO.atualizar(encontrada)) {
                throw new SQLException("Falha ao atualizar demanda.");
            }

            Demanda atualizada = demandaDAO.buscarPorId(idDemanda);

            if (atualizada == null
                    || !novaData.equals(atualizada.getDataHoraAbertura())) {
                throw new SQLException(
                        "A data de abertura não foi atualizada corretamente.");
            }

            System.out.println("[OK] Atualização da demanda");

            // 7. Excluir demanda
            if (!demandaDAO.excluir(idDemanda)) {
                throw new SQLException("Falha ao excluir demanda.");
            }

            if (demandaDAO.buscarPorId(idDemanda) != null) {
                throw new SQLException("Demanda ainda existe após exclusão.");
            }

            idDemanda = 0;
            System.out.println("[OK] Exclusão da demanda");

            System.out.println("\n=== TODOS OS TESTES PASSARAM ===");

        } catch (Exception e) {
            System.err.println("\n[ERRO] " + e.getMessage());
            e.printStackTrace();

        } finally {
            // Limpar na ordem inversa dos relacionamentos
            try {
                if (idDemanda > 0) {
                    demandaDAO.excluir(idDemanda);
                }

                if (veiculoDAO.buscarPorPlaca(placa) != null) {
                    veiculoDAO.excluir(placa);
                }

                if (idCliente > 0) {
                    clienteDAO.excluir(idCliente);
                }

                System.out.println("Limpeza dos registros de teste concluída.");

            } catch (SQLException e) {
                System.err.println(
                        "Atenção: verifique a limpeza dos registros: "
                        + e.getMessage());
            }
        }
    }
}
