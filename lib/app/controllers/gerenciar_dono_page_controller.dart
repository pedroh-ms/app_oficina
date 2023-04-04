import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';

class GerenciarDonoPageController {

  Future<bool> save(Map<String, dynamic> dono) async {
    final repository = DonoRepository();
    try {
      await repository.put(DonoModel.fromJson(dono));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    final repository = DonoRepository();
    try {
      await repository.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}