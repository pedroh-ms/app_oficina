import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';

class InserirDonoPageController {

  Future<bool> inserir(Map dono) async {
    try {
      final repository = DonoRepository();
      await repository.post(
        DonoModel(
          id: null,
          nome: dono['nome'],
          numeroCelular: dono['numeroCelular']
        )
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}