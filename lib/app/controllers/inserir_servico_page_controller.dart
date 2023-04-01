import 'package:app_oficina/app/models/servico_model.dart';
import 'package:app_oficina/app/repositories/servico_repository.dart';

class InserirServicoPageController {
  Future<bool> inserir(Map<String, dynamic> servico) async {
    final repository = ServicoRepository();
    try {
      await repository.post(ServicoModel.fromJson(servico));
      return true;
    } catch (e) {
      return false;
    }
  }
}