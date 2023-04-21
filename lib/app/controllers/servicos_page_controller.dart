import 'package:app_oficina/app/repositories/carro_repository.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';
import 'package:app_oficina/app/toast.dart';
import 'package:flutter/widgets.dart';

import '../models/carro_model.dart';
import '../models/dono_model.dart';
import '../models/servico_dono_carro_model.dart';
import '../repositories/servico_repository.dart';

class ServicosPageController {
  final servicos = ValueNotifier<List<ServicoDonoCarroModel>>([]);

  Future start() async {
    final repository = ServicoRepository();
    try {
      servicos.value = await repository.getWithDonosCarros();
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future<List<DonoModel>> getDonos() async {
    final repository = DonoRepository();
    try {
      return await repository.get();
    } catch (e) {
      errorToast(e.toString());
      return [];
    }
  }

  Future<List<CarroModel>> getCarros() async {
    final repository = CarroRepository();
    try {
      return await repository.get();
    } catch (e) {
      errorToast(e.toString());
      return [];
    }
  }
}