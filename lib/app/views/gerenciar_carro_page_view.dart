import 'package:app_oficina/app/models/carro_dono_model.dart';
import 'package:app_oficina/app/models/carro_model.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../controllers/gerenciar_carro_page_controller.dart';
import '../models/dono_model.dart';

class GerenciarCarroPage extends StatefulWidget {
  
  final CarroDonoModel? carro;
  final List<DonoModel>? donos;

  const GerenciarCarroPage({super.key, this.carro, this.donos});

  @override
  GerenciarCarroPageState createState() => GerenciarCarroPageState(carro, donos);
}

class GerenciarCarroPageState extends State<GerenciarCarroPage> {
  
  late CarroModel carro;
  late DonoModel dono;
  List<DonoModel>? donos;

  final _nomeController = TextEditingController();
  final _corController = TextEditingController();
  final _gerenciarCarroPageController = GerenciarCarroPageController();

  GerenciarCarroPageState(CarroDonoModel? carro, this.donos) {
    
    this.carro = carro?.toCarroModel() ?? CarroModel();
    dono = carro!.dono!;

    _nomeController.text = carro.nome ?? '';
    _corController.text = carro.cor ?? '';
  }

  Future<void> _save() async {
    await _gerenciarCarroPageController.save(carro.toJson());
  }

  Future<void> _delete() async {
    await _gerenciarCarroPageController.delete(carro.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar carro')
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nomeController,
                onChanged: (text) => carro.nome = text,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _corController,
                onChanged: (text) => carro.cor = text,
                decoration: const InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SearchField<DonoModel>(
                initialValue: SearchFieldListItem<DonoModel>(
                  dono.nome as String,
                  item: dono,
                  child: Text(dono.nome as String)
                ),
                suggestions: (donos!)
                  .map(
                    (e) => SearchFieldListItem<DonoModel>(
                      e.nome as String,
                      item: e,
                      child: Text(e.nome as String)
                    )
                  ).toList(),
                searchInputDecoration: const InputDecoration(
                  labelText: 'Dono',
                  border: OutlineInputBorder()
                ),
                onSuggestionTap: (e) {
                  dono = e.item as DonoModel;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async => await _save(),
                    child: const Text('Salvar')
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async => await _delete(),
                    child: const Text('Deletar')
                  )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}