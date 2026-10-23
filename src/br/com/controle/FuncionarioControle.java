/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.controle;

import br.com.dao.FuncionarioDAO;
import br.com.entidade.Funcionario;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;


/**
 *
 * @author tharlis.agrario
 */
public class FuncionarioControle {
    private final FuncionarioDAO funcionarioDAO;

    public FuncionarioControle() {
        this.funcionarioDAO = new FuncionarioDAO();
    }

    public int cadastrar(
            String nome,
            String cpf,
            LocalDate dataAdmissao,
            Integer idSupervisor) throws SQLException {

        validarNome(nome);
        validarCpf(cpf);
        validarDataAdmissao(dataAdmissao);
        validarIdSupervisor(idSupervisor);

        Funcionario funcionario = new Funcionario();
        funcionario.setNome(nome.trim());
        funcionario.setCpf(cpf.trim());
        funcionario.setDataAdmissao(dataAdmissao);
        funcionario.setIdSupervisor(idSupervisor);

        return funcionarioDAO.inserir(funcionario);
    }

    public List<Funcionario> listarTodos() throws SQLException {
        return funcionarioDAO.listarTodos();
    }

    public Funcionario buscarPorId(int idFuncionario)
            throws SQLException {

        validarIdFuncionario(idFuncionario);

        return funcionarioDAO.buscarPorId(idFuncionario);
    }

    public boolean atualizar(
            int idFuncionario,
            String nome,
            String cpf,
            LocalDate dataAdmissao,
            Integer idSupervisor) throws SQLException {

        validarIdFuncionario(idFuncionario);
        validarNome(nome);
        validarCpf(cpf);
        validarDataAdmissao(dataAdmissao);
        validarIdSupervisor(idSupervisor);

        if (idSupervisor != null
                && idSupervisor == idFuncionario) {
            throw new IllegalArgumentException(
                    "Um funcionário não pode ser seu próprio supervisor.");
        }

        Funcionario funcionario = new Funcionario();
        funcionario.setIdFuncionario(idFuncionario);
        funcionario.setNome(nome.trim());
        funcionario.setCpf(cpf.trim());
        funcionario.setDataAdmissao(dataAdmissao);
        funcionario.setIdSupervisor(idSupervisor);

        return funcionarioDAO.atualizar(funcionario);
    }

    public boolean excluir(int idFuncionario)
            throws SQLException {

        validarIdFuncionario(idFuncionario);

        return funcionarioDAO.excluir(idFuncionario);
    }

    private void validarIdFuncionario(int idFuncionario) {
        if (idFuncionario <= 0) {
            throw new IllegalArgumentException(
                    "O ID do funcionário deve ser maior que zero.");
        }
    }

    private void validarNome(String nome) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "O nome do funcionário é obrigatório.");
        }
    }

    private void validarCpf(String cpf) {
        if (cpf == null || cpf.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "O CPF do funcionário é obrigatório.");
        }
    }

    private void validarDataAdmissao(LocalDate dataAdmissao) {
        if (dataAdmissao == null) {
            throw new IllegalArgumentException(
                    "A data de admissão é obrigatória.");
        }

        if (dataAdmissao.isAfter(LocalDate.now())) {
            throw new IllegalArgumentException(
                    "A data de admissão não pode ser futura.");
        }
    }

    private void validarIdSupervisor(Integer idSupervisor) {
        if (idSupervisor != null && idSupervisor <= 0) {
            throw new IllegalArgumentException(
                    "O ID do supervisor deve ser maior que zero.");
        }
    }
}
