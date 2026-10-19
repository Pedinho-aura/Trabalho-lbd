
package br.com.controle;

import javax.swing.JOptionPane;


public class TratamentoDeErros {
    
   public static void exibirErroBanco(int codigo){
     
       switch (codigo) {
           case 1062:
               JOptionPane.showMessageDialog(null, "Erro: Este registro já está cadastrado no sistema.");
               break;
           case 1451:
               JOptionPane.showMessageDialog(null, "Erro:Não é permitido excluir este registro, pois ele possui histórico ou vínculos associados no sistema. ");
               break;
           case 1452:
               JOptionPane.showMessageDialog(null, "Erro: Não foi possível salvar o registro, pois um dos registros relacionados não existe no sistema.");
               break;
           case 3819:
               JOptionPane.showMessageDialog(null, "Erro: O valor informado viola as regras de validação do sistema");
               break;
           case 1406:
               JOptionPane.showMessageDialog(null, "Erro: O texto digitado ultrapassou o limite máximo permitido para este campo.");
               break;
           case 1048:
           case 1364:
               JOptionPane.showMessageDialog(null, "Erro: Existe campo obrigatório que não foi preenchido.");
               break;
           default:
               JOptionPane.showMessageDialog(null, "Erro não identificado. Verifique os dados e tente novamente.");
               break;
       }
}

}


