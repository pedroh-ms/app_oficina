import 'package:app_oficina/app/models/material_comprado_model.dart';
import 'package:app_oficina/app/repositories/material_comprado_repository.dart';

class GerenciarMaterialCompradoPageController {

  Future<bool> save(Map<String, dynamic> materialComprado) async {
    final repository = MaterialCompradoRepository();
    try {
      repository.put(MaterialCompradoModel.fromJson(materialComprado));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    final repository = MaterialCompradoRepository();
    try {
      repository.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}