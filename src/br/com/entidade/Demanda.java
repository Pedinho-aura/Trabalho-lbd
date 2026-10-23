/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.entidade;
import java.time.LocalDateTime;
/**
 *
 * @author tharlis.agrario
 */
public class Demanda {

    // Atributos
    private int idDemanda;
    private String status;
    private LocalDateTime dataHoraAbertura;
    private String placa;

    // Construtor vazio
    public Demanda() {
    }

    // Construtor com todos os atributos
    public Demanda(
            int idDemanda,
            String status,
            LocalDateTime dataHoraAbertura,
            String placa) {

        this.idDemanda = idDemanda;
        this.status = status;
        this.dataHoraAbertura = dataHoraAbertura;
        this.placa = placa;
    }

    // Getter e setter do ID
    public int getIdDemanda() {
        return idDemanda;
    }

    public void setIdDemanda(int idDemanda) {
        this.idDemanda = idDemanda;
    }

    // Getter e setter do status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Getter e setter da data e hora de abertura
    public LocalDateTime getDataHoraAbertura() {
        return dataHoraAbertura;
    }

    public void setDataHoraAbertura(LocalDateTime dataHoraAbertura) {
        this.dataHoraAbertura = dataHoraAbertura;
    }

    // Getter e setter da placa
    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    // Representação textual
    @Override
    public String toString() {
        return "Demanda{"
                + "idDemanda=" + idDemanda
                + ", status='" + status + '\''
                + ", dataHoraAbertura=" + dataHoraAbertura
                + ", placa='" + placa + '\''
                + '}';
    }
}
