/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.entidade;

/**
 *
 * @author tharlis.agrario
 */
public class Cliente {
    private int id_Cliente;
    private String nome;
    
     // Construtor vazio
    public Cliente() {
    }
    
     // Getter do ID
    public int getIdCliente() {
        return id_Cliente;
    }

    // Setter do ID
    public void setIdCliente(int id_Cliente) {
        this.id_Cliente = id_Cliente;
    }

    // Getter do nome
    public String getNome() {
        return nome;
    }

    // Setter do nome
    public void setNome(String nome) {
        this.nome = nome;
    }
    
      @Override
    public String toString() {
        return "Cliente{"
                + "idCliente=" + id_Cliente
                + ", nome='" + nome + '\''
                + '}';
    }
}
