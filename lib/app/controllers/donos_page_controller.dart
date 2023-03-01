import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';
import 'package:flutter/material.dart';

class DonosPageController {
  final donos = ValueNotifier<List<DonoModel>>([]);

  Future start() async {
    final repository = DonoRepository();
    donos.value = await repository.get();
  }
}