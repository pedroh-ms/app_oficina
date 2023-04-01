import 'package:app_oficina/app/models/material_comprado_model.dart';
import 'package:app_oficina/app/repositories/material_comprado_repository.dart';

class InserirMaterialCompradoPageController {

  Future<bool> insert(Map<String, dynamic> materialComprado) async {
    final repository = MaterialCompradoRepository();
    try {
      await repository.post(MaterialCompradoModel.fromJson(materialComprado));
      return true;
    } catch (e) {
      return false;
    }
  }
}