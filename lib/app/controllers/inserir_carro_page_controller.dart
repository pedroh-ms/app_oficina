import 'package:app_oficina/app/repositories/carro_repository.dart';
import 'package:app_oficina/app/toast.dart';
import '../models/carro_model.dart';

class InserirCarroPageController {
  Future insert(Map<String, dynamic> carro) async {
    final repository = CarroRepository();
    try {
      await repository.post(CarroModel.fromJson(carro));
    } catch (e) {
      errorToast(e.toString());
    }
  }
}