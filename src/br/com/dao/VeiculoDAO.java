/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.dao;

import br.com.entidade.Veiculo;
import br.com.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tharlis.agrario
 */
public class VeiculoDAO {
    public boolean inserir(Veiculo veiculo) throws SQLException {
        String sql = "INSERT INTO veiculo (placa, modelo, id_cliente) "
                   + "VALUES (?, ?, ?)";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando =
                     conexao.prepareStatement(sql)) {

            comando.setString(1, veiculo.getPlaca());
            comando.setString(2, veiculo.getModelo());
            comando.setInt(3, veiculo.getIdCliente());

            return comando.executeUpdate() > 0;
        }
    }

    public List<Veiculo> listarTodos() throws SQLException {
        String sql = "SELECT placa, modelo, id_cliente "
                   + "FROM veiculo ORDER BY placa";

        List<Veiculo> veiculos = new ArrayList<>();

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando =
                     conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {
                Veiculo veiculo = new Veiculo();

                veiculo.setPlaca(resultado.getString("placa"));
                veiculo.setModelo(resultado.getString("modelo"));
                veiculo.setIdCliente(
                        resultado.getInt("id_cliente"));

                veiculos.add(veiculo);
            }
        }

        return veiculos;
    }

    public Veiculo buscarPorPlaca(String placa)
            throws SQLException {

        String sql = "SELECT placa, modelo, id_cliente "
                   + "FROM veiculo WHERE placa = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando =
                     conexao.prepareStatement(sql)) {

            comando.setString(1, placa);

            try (ResultSet resultado = comando.executeQuery()) {
                if (resultado.next()) {
                    Veiculo veiculo = new Veiculo();

                    veiculo.setPlaca(
                            resultado.getString("placa"));
                    veiculo.setModelo(
                            resultado.getString("modelo"));
                    veiculo.setIdCliente(
                            resultado.getInt("id_cliente"));

                    return veiculo;
                }
            }
        }

        return null;
    }

    public boolean atualizar(Veiculo veiculo)
            throws SQLException {

        String sql = "UPDATE veiculo "
                   + "SET modelo = ?, id_cliente = ? "
                   + "WHERE placa = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando =
                     conexao.prepareStatement(sql)) {

            comando.setString(1, veiculo.getModelo());
            comando.setInt(2, veiculo.getIdCliente());
            comando.setString(3, veiculo.getPlaca());

            return comando.executeUpdate() > 0;
        }
    }

    public boolean excluir(String placa) throws SQLException {
        String sql = "DELETE FROM veiculo WHERE placa = ?";

        try (Connection conexao = Conexao.abrirBanco();
             PreparedStatement comando =
                     conexao.prepareStatement(sql)) {

            comando.setString(1, placa);

            return comando.executeUpdate() > 0;
        }
    }
}
