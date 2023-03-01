import 'package:app_oficina/app/repositories/dono_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final donoRepository = DonoRepository();

  test('deve trazer uma lista de DonoModel', () async {
    final donos = await donoRepository.get();
    for(var i = 0; i < donos.length; i++){
      print(donos[i].nome);
    }
  });
}