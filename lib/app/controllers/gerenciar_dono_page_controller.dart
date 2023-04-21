import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';
import 'package:app_oficina/app/toast.dart';

class GerenciarDonoPageController {

  Future save(Map<String, dynamic> dono) async {
    final repository = DonoRepository();
    try {
      await repository.put(DonoModel.fromJson(dono));
    } catch (e) {
      errorToast(e.toString());
    }
  }

  Future delete(int id) async {
    final repository = DonoRepository();
    try {
      await repository.delete(id);
    } catch (e) {
      errorToast(e.toString());
    }
  }
}