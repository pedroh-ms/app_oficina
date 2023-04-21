import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/repositories/dono_repository.dart';
import 'package:app_oficina/app/toast.dart';

class InserirDonoPageController {

  Future insert(Map<String, dynamic> dono) async {
    final repository = DonoRepository();
    try {
      await repository.post(DonoModel.fromJson(dono));
    } catch (e) {
      errorToast(e.toString());
    }
  }
}