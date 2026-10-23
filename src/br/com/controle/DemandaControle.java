/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.controle;

import br.com.dao.DemandaDAO;
import br.com.entidade.Demanda;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class DemandaControle {
    private final DemandaDAO demandaDAO;

    public DemandaControle() {
        this.demandaDAO = new DemandaDAO();
    }

    public int cadastrar(
            String status,
            LocalDateTime dataHoraAbertura,
            String placa) throws SQLException {

        validarStatus(status);
        validarDataHoraAbertura(dataHoraAbertura);
        validarPlaca(placa);

        Demanda demanda = new Demanda();
        demanda.setStatus(status.trim());
        demanda.setDataHoraAbertura(dataHoraAbertura);
        demanda.setPlaca(placa.trim());

        return demandaDAO.inserir(demanda);
    }

    public List<Demanda> listarTodos() throws SQLException {
        return demandaDAO.listarTodos();
    }

    public Demanda buscarPorId(int idDemanda)
            throws SQLException {

        validarIdDemanda(idDemanda);

        return demandaDAO.buscarPorId(idDemanda);
    }

    public boolean atualizar(
            int idDemanda,
            String status,
            LocalDateTime dataHoraAbertura,
            String placa) throws SQLException {

        validarIdDemanda(idDemanda);
        validarStatus(status);
        validarDataHoraAbertura(dataHoraAbertura);
        validarPlaca(placa);

        Demanda demanda = new Demanda();
        demanda.setIdDemanda(idDemanda);
        demanda.setStatus(status.trim());
        demanda.setDataHoraAbertura(dataHoraAbertura);
        demanda.setPlaca(placa.trim());

        return demandaDAO.atualizar(demanda);
    }

    public boolean excluir(int idDemanda)
            throws SQLException {

        validarIdDemanda(idDemanda);

        return demandaDAO.excluir(idDemanda);
    }

    private void validarIdDemanda(int idDemanda) {
        if (idDemanda <= 0) {
            throw new IllegalArgumentException(
                    "O ID da demanda deve ser maior que zero.");
        }
    }

    private void validarStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "O status da demanda é obrigatório.");
        }

        String statusNormalizado = status.trim();

        if (!statusNormalizado.equals("Pendente")
                && !statusNormalizado.equals("Finalizado")) {
            throw new IllegalArgumentException(
                    "O status deve ser Pendente ou Finalizado.");
        }
    }

    private void validarDataHoraAbertura(
            LocalDateTime dataHoraAbertura) {

        if (dataHoraAbertura == null) {
            throw new IllegalArgumentException(
                    "A data e hora de abertura são obrigatórias.");
        }

        if (dataHoraAbertura.isAfter(LocalDateTime.now())) {
            throw new IllegalArgumentException(
                    "A data e hora de abertura não podem ser futuras.");
        }
    }

    private void validarPlaca(String placa) {
        if (placa == null || placa.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "A placa do veículo é obrigatória.");
        }
    }
}
