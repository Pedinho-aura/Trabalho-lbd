/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.entidade;


/**
 *
 * @author tharlis.agrario
 */

import java.time.LocalDate;

public class Funcionario {
    // Atributos
    private int idFuncionario;
    private String nome;
    private String cpf;
    private LocalDate dataAdmissao;
    private Integer idSupervisor;

    // Construtor vazio
    public Funcionario() {
    }

    // Construtor com todos os atributos
    public Funcionario(
            int idFuncionario,
            String nome,
            String cpf,
            LocalDate dataAdmissao,
            Integer idSupervisor) {

        this.idFuncionario = idFuncionario;
        this.nome = nome;
        this.cpf = cpf;
        this.dataAdmissao = dataAdmissao;
        this.idSupervisor = idSupervisor;
    }

    // Getter e setter do ID
    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    // Getter e setter do nome
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    // Getter e setter do CPF
    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    // Getter e setter da data de admissão
    public LocalDate getDataAdmissao() {
        return dataAdmissao;
    }

    public void setDataAdmissao(LocalDate dataAdmissao) {
        this.dataAdmissao = dataAdmissao;
    }

    // Getter e setter do supervisor
    public Integer getIdSupervisor() {
        return idSupervisor;
    }

    public void setIdSupervisor(Integer idSupervisor) {
        this.idSupervisor = idSupervisor;
    }

    // Representação textual
    @Override
    public String toString() {
        return "Funcionario{"
                + "idFuncionario=" + idFuncionario
                + ", nome='" + nome + '\''
                + ", cpf='" + cpf + '\''
                + ", dataAdmissao=" + dataAdmissao
                + ", idSupervisor=" + idSupervisor
                + '}';
    }
}
