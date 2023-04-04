import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';

class InserirDonoPageController {

  Future<bool> insert(Map<String, dynamic> dono) async {
    final repository = DonoRepository();
    try {
      await repository.post(DonoModel.fromJson(dono));
      return true;
    } catch (e) {
      return false;
    }
  }
}