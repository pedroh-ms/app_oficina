import 'package:app_oficina/app/controllers/inserir_material_comprado_page_controller.dart';
import 'package:app_oficina/app/models/material_comprado_model.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InserirMaterialCompradoPage extends StatefulWidget {

  @override
  InserirMaterialCompradoPageState createState() => InserirMaterialCompradoPageState();
}

class InserirMaterialCompradoPageState extends State<InserirMaterialCompradoPage> {

  final materialComprado = MaterialCompradoModel();

  final _inserirMaterialCompradoPageController = InserirMaterialCompradoPageController();

  final _diaController = TextEditingController();
  final _precoController = CurrencyTextFieldController(currencySymbol: 'R\$', decimalSymbol: ',', thousandSymbol: '.');

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

  Future<void> _insert() async {
    final ret = await _inserirMaterialCompradoPageController.insert(materialComprado.toJson());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir material comprado'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (nome) => materialComprado.nome = nome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder()
                )
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _diaController,
                onChanged: (dia) => materialComprado.dia = dia,
                decoration: InputDecoration(
                  labelText: 'Dia',
                  border: OutlineInputBorder()
                ),
                readOnly: true,
                onTap: () async => await _showDiaDatePicker(),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _precoController,
                maxLength: 11,
                onChanged: (preco) => materialComprado.preco = preco.replaceAll(RegExp(r'[R$\s.]'), '').replaceFirst(',', '.'),
                decoration: InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                  counterText: ''
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () async => await _insert(),
                child: Text('Inserir')
              )
            ],
          )
        )
      )
    );
  }
}