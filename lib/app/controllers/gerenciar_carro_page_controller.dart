import 'package:app_oficina/app/toast.dart';

import '../models/carro_model.dart';
import '../repositories/carro_repository.dart';

class GerenciarCarroPageController {
  Future save(Map<String, dynamic> carro) async {
    final repository = CarroRepository();
    try {
      await repository.put(CarroModel.fromJson(carro));
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future delete(int id) async {
    final repository = CarroRepository();
    try {
      await repository.delete(id);
    } catch (e) {
      toast(e.toString());
    }
  }
}