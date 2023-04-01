import 'package:app_oficina/app/repositories/servico_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final donoRepository = ServicoRepository();

  test('deve trazer uma lista de DonoModel', () async {
    final servicos = await donoRepository.getWithDonosCarros();
    for(var i = 0; i < servicos.length; i++){
      print(servicos[i].toJson());
    }
  });
}
