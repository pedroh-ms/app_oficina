import 'package:app_oficina/app/models/servico_model.dart';
import 'package:app_oficina/app/repositories/servico_repository.dart';
import 'package:app_oficina/app/toast.dart';

class InserirServicoPageController {
  Future inserir(Map<String, dynamic> servico) async {
    final repository = ServicoRepository();
    try {
      await repository.post(ServicoModel.fromJson(servico));
    } catch (e) {
      errorToast(e.toString());
    }
  }
}