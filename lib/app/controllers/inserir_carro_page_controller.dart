import 'package:app_oficina/app/repositories/carro_repository.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';

import '../models/carro_model.dart';
import '../models/dono_model.dart';

class InserirCarroPageController {
  Future<bool> inserir(Map carro) async {
    final repository = CarroRepository();
    try {
      await repository.post(
        CarroModel(
          id: null,
          nome: carro['nome'],
          cor: carro['cor'],
          donoId: carro['dono']
        )
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DonoModel>> getDonos() async {
    final repository = DonoRepository();
    return await repository.get();
  }
}