import 'package:app_oficina/app/models/material_comprado_model.dart';
import 'package:app_oficina/app/repositories/material_comprado_repository.dart';
import 'package:app_oficina/app/toast.dart';
import 'package:flutter/material.dart';

class MaterialCompradosPageController {
  final materialComprados = ValueNotifier<List<MaterialCompradoModel>>([]);
  
  Future start() async {
    final repository = MaterialCompradoRepository();
    try {
      materialComprados.value = await repository.get();
    } catch (e) {
      errorToast(e.toString());
    }
  }
}