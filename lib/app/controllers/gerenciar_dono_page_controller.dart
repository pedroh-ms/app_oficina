import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';

class GerenciarDonoPageController {

  Future<bool> salvar(Map dono) async {
    final repository = DonoRepository();
    try {
      await repository.put(
        DonoModel(
          id: dono['id'],
          nome: dono['nome'],
          numeroCelular: dono['numeroCelular']
        )
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletar(int id) async {
    final repository = DonoRepository();
    try {
      await repository.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}