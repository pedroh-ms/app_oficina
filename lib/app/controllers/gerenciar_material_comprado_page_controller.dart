import 'package:app_oficina/app/models/material_comprado_model.dart';
import 'package:app_oficina/app/repositories/material_comprado_repository.dart';
import 'package:app_oficina/app/toast.dart';

class GerenciarMaterialCompradoPageController {

  Future save(Map<String, dynamic> materialComprado) async {
    final repository = MaterialCompradoRepository();
    try {
      repository.put(MaterialCompradoModel.fromJson(materialComprado));
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future delete(int id) async {
    final repository = MaterialCompradoRepository();
    try {
      repository.delete(id);
    } catch (e) {
      errorToast(e.toString());
    }
  }
}