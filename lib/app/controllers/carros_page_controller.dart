import 'package:flutter/widgets.dart';

import '../models/carro_dono_model.dart';
import '../models/carro_model.dart';
import '../models/dono_model.dart';
import '../repositories/carro_repository.dart';
import '../repositories/dono_repository.dart';

class CarrosPageController {
  final carros = ValueNotifier<List<CarroModel>>([]);
  final carrosdonos = ValueNotifier<List<CarroDonoModel>>([]);

  Future start() async {
    final repository = CarroRepository();
    carrosdonos.value = await repository.getWithDonos();
  }

  Future<List<DonoModel>> getDonos() async {
    final repository = DonoRepository();
    return await repository.get();
  }
}