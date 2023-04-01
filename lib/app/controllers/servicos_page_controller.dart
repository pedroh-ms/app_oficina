import 'package:app_oficina/app/repositories/carro_repository.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';
import 'package:flutter/widgets.dart';

import '../models/carro_model.dart';
import '../models/dono_model.dart';
import '../models/servico_dono_carro_model.dart';
import '../repositories/servico_repository.dart';

class ServicosPageController {
  final servicos = ValueNotifier<List<ServicoDonoCarroModel>>([]);

  Future start() async {
    final repository = ServicoRepository();
    servicos.value = await repository.getWithDonosCarros();
  }

  Future<List<DonoModel>> getDonos() async {
    final repository = DonoRepository();
    return await repository.get();
  }

  Future<List<CarroModel>> getCarros() async {
    final repository = CarroRepository();
    return await repository.get();
  }
}