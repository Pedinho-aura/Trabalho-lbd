/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.OficinaDF;

import br.com.dao.FuncionarioDAO;
import br.com.entidade.Funcionario;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
/**
 *
 * @author tharlis.agrario
 */
public class TesteFuncionarioDAO {
     public static void main(String[] args) {

        FuncionarioDAO dao = new FuncionarioDAO();

        int idSupervisor = 0;
        int idFuncionario = 0;

        String sufixo = String.format(
                "%010d",
                System.currentTimeMillis() % 10000000000L);

        String cpfSupervisor = "1" + sufixo;
        String cpfFuncionario = "2" + sufixo;

        try {
            System.out.println("=== TESTE DO FUNCIONARIODAO ===");

            // 1. Cadastrar supervisor
            Funcionario supervisor = new Funcionario();
            supervisor.setNome("Supervisor Teste");
            supervisor.setCpf(cpfSupervisor);
            supervisor.setDataAdmissao(LocalDate.now().minusDays(1));
            supervisor.setIdSupervisor(null);

            idSupervisor = dao.inserir(supervisor);

            System.out.println(
                    "[OK] Supervisor cadastrado: " + idSupervisor);

            // 2. Cadastrar funcionário vinculado ao supervisor
            Funcionario funcionario = new Funcionario();
            funcionario.setNome("Funcionario Teste");
            funcionario.setCpf(cpfFuncionario);
            funcionario.setDataAdmissao(LocalDate.now());
            funcionario.setIdSupervisor(idSupervisor);

            idFuncionario = dao.inserir(funcionario);

            System.out.println(
                    "[OK] Funcionário cadastrado: " + idFuncionario);

            // 3. Buscar funcionário
            Funcionario encontrado = dao.buscarPorId(idFuncionario);

            if (encontrado == null) {
                throw new SQLException(
                        "Funcionário não encontrado após inserção.");
            }

            if (!cpfFuncionario.equals(encontrado.getCpf())) {
                throw new SQLException("CPF retornado incorretamente.");
            }

            if (!Integer.valueOf(idSupervisor).equals(
                    encontrado.getIdSupervisor())) {
                throw new SQLException(
                        "O vínculo com o supervisor não foi recuperado.");
            }

            System.out.println("[OK] Busca por ID e vínculo com supervisor");

            // 4. Listar funcionários
            List<Funcionario> funcionarios = dao.listarTodos();

            boolean constaNaLista = false;

            for (Funcionario f : funcionarios) {
                if (f.getIdFuncionario() == idFuncionario) {
                    constaNaLista = true;
                    break;
                }
            }

            if (!constaNaLista) {
                throw new SQLException(
                        "Funcionário não encontrado na listagem.");
            }

            System.out.println("[OK] Listagem de funcionários");

            // 5. Atualizar funcionário
            funcionario.setIdFuncionario(idFuncionario);
            funcionario.setNome("Funcionario Atualizado");

            boolean atualizado = dao.atualizar(funcionario);

            if (!atualizado) {
                throw new SQLException(
                        "A atualização não foi realizada.");
            }

            Funcionario atualizadoNoBanco =
                    dao.buscarPorId(idFuncionario);

            if (atualizadoNoBanco == null
                    || !"Funcionario Atualizado".equals(
                            atualizadoNoBanco.getNome())) {
                throw new SQLException(
                        "A atualização não foi confirmada.");
            }

            System.out.println("[OK] Atualização de funcionário");

            // 6. Excluir funcionário subordinado primeiro
            if (!dao.excluir(idFuncionario)) {
                throw new SQLException(
                        "Não foi possível excluir o funcionário.");
            }

            idFuncionario = 0;

            if (dao.buscarPorId(
                    atualizadoNoBanco.getIdFuncionario()) != null) {
                throw new SQLException(
                        "O funcionário ainda existe após exclusão.");
            }

            System.out.println("[OK] Exclusão de funcionário");

            // 7. Excluir supervisor depois do subordinado
            if (!dao.excluir(idSupervisor)) {
                throw new SQLException(
                        "Não foi possível excluir o supervisor.");
            }

            idSupervisor = 0;

            System.out.println("[OK] Exclusão do supervisor");
            System.out.println("\n=== TODOS OS TESTES PASSARAM ===");

        } catch (Exception e) {
            System.err.println("\n[ERRO] " + e.getMessage());
            e.printStackTrace();

        } finally {
            // Tentar remover apenas os registros criados pelo teste.
            try {
                if (idFuncionario > 0) {
                    dao.excluir(idFuncionario);
                }

                if (idSupervisor > 0) {
                    dao.excluir(idSupervisor);
                }

                System.out.println(
                        "Limpeza dos registros de teste concluída.");

            } catch (SQLException e) {
                System.err.println(
                        "Atenção: verifique a limpeza dos registros: "
                        + e.getMessage());
            }
        }
    }
}
