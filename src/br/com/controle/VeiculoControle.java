/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.controle;

import br.com.dao.VeiculoDAO;
import br.com.entidade.Veiculo;

import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class VeiculoControle {
     private final VeiculoDAO veiculoDAO;

    public VeiculoControle() {
        this.veiculoDAO = new VeiculoDAO();
    }

    public boolean cadastrar(
            String placa, String modelo, int idCliente)
            throws SQLException {

        validarPlaca(placa);
        validarModelo(modelo);
        validarIdCliente(idCliente);

        Veiculo veiculo = new Veiculo();
        veiculo.setPlaca(placa.trim());
        veiculo.setModelo(modelo.trim());
        veiculo.setIdCliente(idCliente);

        return veiculoDAO.inserir(veiculo);
    }

    public List<Veiculo> listarTodos() throws SQLException {
        return veiculoDAO.listarTodos();
    }

    public Veiculo buscarPorPlaca(String placa)
            throws SQLException {

        validarPlaca(placa);

        return veiculoDAO.buscarPorPlaca(placa.trim());
    }

    public boolean atualizar(
            String placa, String modelo, int idCliente)
            throws SQLException {

        validarPlaca(placa);
        validarModelo(modelo);
        validarIdCliente(idCliente);

        Veiculo veiculo = new Veiculo();
        veiculo.setPlaca(placa.trim());
        veiculo.setModelo(modelo.trim());
        veiculo.setIdCliente(idCliente);

        return veiculoDAO.atualizar(veiculo);
    }

    public boolean excluir(String placa) throws SQLException {
        validarPlaca(placa);

        return veiculoDAO.excluir(placa.trim());
    }

    private void validarPlaca(String placa) {
        if (placa == null || placa.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "A placa do veículo é obrigatória.");
        }
    }

    private void validarModelo(String modelo) {
        if (modelo == null || modelo.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "O modelo do veículo é obrigatório.");
        }
    }

    private void validarIdCliente(int idCliente) {
        if (idCliente <= 0) {
            throw new IllegalArgumentException(
                    "O ID do cliente deve ser maior que zero.");
        }
    }
}
