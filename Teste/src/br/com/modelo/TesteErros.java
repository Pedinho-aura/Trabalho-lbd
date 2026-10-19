
package br.com.modelo;
import br.com.controle.TratamentoDeErros;
import java.sql.SQLException;

public class TesteErros {
    public static void main(String[] args) {
        try {
            // Observação: Troque pelo número 13 esses outros códigos para testar.
            // E se for um número diferente desses, sempre vai cair no default.
            // 1062
            // 1451
            // 1452
            // 3819
            // 1406
            // 1048
            // 1364
            throw new SQLException("Erro simulado para teste", "23000", 13);
        }
        catch(SQLException e){
        int codigo = e.getErrorCode();
        TratamentoDeErros.exibirErroBanco(codigo);
        }  
   }
}
