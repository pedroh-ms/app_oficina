import 'package:app_oficina/app/models/servico_model.dart';
import 'package:app_oficina/app/repositories/servico_repository.dart';
import 'package:app_oficina/app/toast.dart';

class GerenciarServicoPageController {
  Future save(Map<String, dynamic> servico) async {
    final repository = ServicoRepository();
    try {
      await repository.put(ServicoModel.fromJson(servico));
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future delete(int id) async {
    final repository = ServicoRepository();
    try {
      await repository.delete(id);
    } catch (e) {
      errorToast(e.toString());
    }
  }
}