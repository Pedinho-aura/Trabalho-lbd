/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.entidade;

/**
 *
 * @author tharlis.agrario
 */

public class Veiculo {

    // Atributos
    private String placa;
    private String modelo;
    private int idCliente;

    // Construtor vazio
    public Veiculo() {
    }

    // Construtor com todos os atributos
    public Veiculo(String placa, String modelo, int idCliente) {
        this.placa = placa;
        this.modelo = modelo;
        this.idCliente = idCliente;
    }

    // Getter e setter da placa
    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    // Getter e setter do modelo
    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    // Getter e setter do ID do cliente
    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    // Representação textual
    @Override
    public String toString() {
        return "Veiculo{"
                + "placa='" + placa + '\''
                + ", modelo='" + modelo + '\''
                + ", idCliente=" + idCliente
                + '}';
    }
}

