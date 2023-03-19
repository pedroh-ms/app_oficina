import '../models/carro_model.dart';
import '../repositories/carro_repository.dart';

class GerenciarCarroPageController {

  Future<bool> salvar(Map<String, dynamic> carro) async {
    final repository = CarroRepository();
    try {
      await repository.put(CarroModel.fromJson(carro));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletar(int id) async {
    final repository = CarroRepository();
    try {
      await repository.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}