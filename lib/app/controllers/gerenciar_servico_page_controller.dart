import 'package:app_oficina/app/models/servico_model.dart';
import 'package:app_oficina/app/repositories/servico_repository.dart';

class GerenciarServicoPageController {
  Future<bool> salvar(Map<String, dynamic> servico) async {
    final repository = ServicoRepository();
    try {
      await repository.put(ServicoModel.fromJson(servico));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletar(int id) async {
    final repository = ServicoRepository();
    try {
      await repository.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}