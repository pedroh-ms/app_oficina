import 'package:app_oficina/app/models/material_comprado_model.dart';
import 'package:app_oficina/app/repositories/material_comprado_repository.dart';
import 'package:flutter/material.dart';

class MaterialCompradosPageController {
  final materialComprados = ValueNotifier<List<MaterialCompradoModel>>([]);
  
  Future start() async {
    final repository = MaterialCompradoRepository();
    materialComprados.value = await repository.get();
  }
}