import 'package:app_oficina/app/controllers/gerenciar_dono_page_controller.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:flutter/material.dart';

class GerenciarDonoPage extends StatefulWidget {

  final DonoModel? dono;

  const GerenciarDonoPage({super.key, this.dono});

  @override
  GerenciarDonoPageState createState() => GerenciarDonoPageState(dono);
}

class GerenciarDonoPageState extends State<GerenciarDonoPage> {

  late DonoModel dono;

  final _nomeController = TextEditingController();
  final _numeroCelularController = TextEditingController();
  final _gerenciarDonoPageController = GerenciarDonoPageController();

  GerenciarDonoPageState(DonoModel? dono) {
    this.dono = dono ?? DonoModel();

    _nomeController.text = dono?.nome ?? '';
    _numeroCelularController.text = dono?.numeroCelular ?? '';
  }

  Future<void> _save() async {
    await _gerenciarDonoPageController.save(dono.toJson());
  }

  Future<void> _delete() async {
    await _gerenciarDonoPageController.delete(dono.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar dono'),
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
                onChanged: (text) => dono.nome = text,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _numeroCelularController,
                onChanged: (text) => dono.numeroCelular = text,
                decoration: const InputDecoration(
                  labelText: 'Número do celular',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 15,
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
              )
            ],
          )
        ),
      ),
    );
  }
}