import 'package:app_oficina/app/repositories/carro_repository.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';

import '../models/carro_model.dart';
import '../models/dono_model.dart';

class InserirCarroPageController {
  Future<bool> insert(Map<String, dynamic> carro) async {
    final repository = CarroRepository();
    try {
      await repository.post(CarroModel.fromJson(carro));
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