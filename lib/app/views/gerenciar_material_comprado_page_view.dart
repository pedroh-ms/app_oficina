import 'package:app_oficina/app/controllers/gerenciar_material_comprado_page_controller.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/material_comprado_model.dart';

class GerenciarMaterialCompradoPage extends StatefulWidget {

  final MaterialCompradoModel? materialComprado;

  const GerenciarMaterialCompradoPage({super.key, this.materialComprado});

  @override
  GerenciarMaterialCompradoPageState createState() => GerenciarMaterialCompradoPageState(materialComprado);
}

class GerenciarMaterialCompradoPageState extends State<GerenciarMaterialCompradoPage> {

  late MaterialCompradoModel materialComprado;

  final _inserirMaterialCompradoPageController = GerenciarMaterialCompradoPageController();

  final _nomeController = TextEditingController();
  final _diaController = TextEditingController();
  final _precoController = CurrencyTextFieldController(currencySymbol: 'R\$', decimalSymbol: ',', thousandSymbol: '.');

  GerenciarMaterialCompradoPageState(MaterialCompradoModel? materialComprado) {
    this.materialComprado = materialComprado ?? MaterialCompradoModel();
    _nomeController.text = materialComprado?.nome ?? '';
    _diaController.text = materialComprado?.dia ?? '';
    _precoController.text = materialComprado?.preco ?? '';
  }

  Future<void> _showDiaDatePicker() async {
    showDatePicker(
      context: context, 
      initialDate: materialComprado.dia != null ? DateTime.parse(materialComprado.dia!) : DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2101)
    ).then((pickedDate) {
      if (pickedDate == null) return;
      materialComprado.dia = DateFormat('yyyy-MM-dd').format(pickedDate);
      _diaController.text = materialComprado.dia!;
    });
  }

  Future<void> _save() async {
    await _inserirMaterialCompradoPageController.save(materialComprado.toJson());
  }

  Future<void> _delete() async {
    await _inserirMaterialCompradoPageController.delete(materialComprado.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar material comprado'),
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
                onChanged: (nome) => materialComprado.nome = nome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _diaController,
                onChanged: (dia) => materialComprado.dia = dia,
                decoration: const InputDecoration(
                  labelText: 'Dia',
                  border: OutlineInputBorder()
                ),
                readOnly: true,
                onTap: () async => await _showDiaDatePicker(),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _precoController,
                maxLength: 11,
                onChanged: (preco) => materialComprado.preco = preco.replaceAll(RegExp(r'[R$\s.]'), '').replaceFirst(',', '.'),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                  counterText: ''
                ),
                keyboardType: TextInputType.number,
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
                    width: 5
                  ),
                  ElevatedButton(
                    onPressed: () async => await _delete(), 
                    child: const Text('Deletar')
                  )
                ],
              )
            ],
          )
        )
      )
    );
  }
}