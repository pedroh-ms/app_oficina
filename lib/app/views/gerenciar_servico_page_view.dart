import 'package:app_oficina/app/controllers/gerenciar_servico_page_controller.dart';
import 'package:app_oficina/app/enums/servico_dono_carro_event_enum.dart';
import 'package:app_oficina/app/models/carro_model.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:app_oficina/app/models/servico_dono_carro_model.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

class GerenciarServicoPage extends StatefulWidget {

  final ServicoDonoCarroModel? servico;
  final List<CarroModel>? carros;
  final List<DonoModel>? donos;

  const GerenciarServicoPage({super.key, this.servico, this.carros, this.donos});

  @override
  GerenciarServicoPageState createState() => GerenciarServicoPageState(servico, carros, donos);
}

class GerenciarServicoPageState extends State<GerenciarServicoPage> {

  late ServicoDonoCarroModel servico;
  List<CarroModel>? carros;
  List<CarroModel>? carrosSF;
  List<DonoModel>? donos;
  List<DonoModel>? donosSF;

  final _gerenciarServicoPageController = GerenciarServicoPageController();
  final _dataEntregaController = TextEditingController();
  final _precoController = CurrencyTextFieldController(currencySymbol: 'R\$', decimalSymbol: ',', thousandSymbol: '.');
  final _observacaoController = TextEditingController();
  final _donoSearchFieldController = TextEditingController();
  final _carroSearchFieldController = TextEditingController();

  GerenciarServicoPageState(ServicoDonoCarroModel? servico, this.carros, this.donos) {
    this.servico = servico ?? ServicoDonoCarroModel();
    _dataEntregaController.text = servico!.dataEntrega!;
    _precoController.text = servico.preco!;
    _observacaoController.text = servico.observacao!;
    carrosSF = carros!.where((e) => e.donoId == servico.dono!.id).toList();
    donosSF = donos!.where((e) => e.id == servico.carro!.donoId).toList();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _carroSearchFieldController.text = servico.carro!.nome!;
      _donoSearchFieldController.text = servico.dono!.nome!;
    });
  }

  Future<void> _showDataEntregaDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: servico.dataEntrega != '' && servico.dataEntrega != null ? DateTime.parse(servico.dataEntrega!): DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101)
    ).then(
      (pickedDate) {
        if (pickedDate == null) return;
        servico.dataEntrega = DateFormat('yyyy-MM-dd').format(pickedDate);
        _dataEntregaController.text = servico.dataEntrega!;
      }
    );
  }

  void _servicoDonoEvent(ServicoDonoCarroEventEnum eventEnum, DonoModel? dono) {
    switch (eventEnum) {
      case ServicoDonoCarroEventEnum.onPressed: {
        _donoSearchFieldController.clear();
        servico.dono = null;
        setState(() {
          carrosSF = carros;
        });
        break;
      }
      case ServicoDonoCarroEventEnum.onSuggestionTap: {
        servico.dono = dono!;
        setState(() {
          carrosSF = carros!.where((e) => e.donoId == dono.id).toList();
        });
        _donoSearchFieldController.text = dono.nome!;
        break;      
      }
    }
  }

  void _servicoCarroEvent(ServicoDonoCarroEventEnum eventEnum, CarroModel? carro) {
    switch (eventEnum) {
      case ServicoDonoCarroEventEnum.onPressed: {
        _carroSearchFieldController.clear();
        servico.carro = null;
        setState(() {
          donosSF = donos;
        });
        break;
      }
      case ServicoDonoCarroEventEnum.onSuggestionTap: {
        servico.carro = carro;
        setState(() {
          donosSF = donos!.where((e) => e.id == carro!.donoId).toList();
        });
        _carroSearchFieldController.text = carro!.nome!;
      }
    }
  }

  Future<void> _save() async {
    await _gerenciarServicoPageController.save(servico.toServicoModel().toJson());
  }

  Future<void> _delete() async {
    await _gerenciarServicoPageController.delete(servico.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar servico')
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _dataEntregaController,
                onChanged: (text) => servico.dataEntrega = text,
                decoration: const InputDecoration(
                  labelText: 'Data da entrega',
                  border: OutlineInputBorder()
                ),
                readOnly: true,
                onTap: () async => await _showDataEntregaDatePicker()
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _precoController,
                maxLength: 11,
                onChanged: (text) => servico.preco = text.replaceAll(RegExp(r'[R$\s.]'), '').replaceFirst(',', '.'),
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
              TextField(
                controller: _observacaoController,
                onChanged: (text) => servico.observacao = text,
                decoration: const InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SearchField<DonoModel>(
                initialValue: SearchFieldListItem<DonoModel>(
                  '${servico.dono!.id}|${servico.dono!.nome}',
                  item: servico.dono,
                  child: Text(servico.dono!.nome!)
                ),
                controller: _donoSearchFieldController,
                suggestions: (donosSF!)
                  .map(
                    (e) => SearchFieldListItem<DonoModel>(
                      '${e.id.toString()}|${e.nome}',
                      item: e,
                      child: Text(e.nome as String),
                    )
                  ).toList(),
                suggestionState: Suggestion.hidden,
                suggestionAction: SuggestionAction.unfocus,
                searchInputDecoration: InputDecoration(
                  labelText: 'Dono',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _servicoDonoEvent(ServicoDonoCarroEventEnum.onPressed, null),
                  )
                ),
                onSuggestionTap: (e) => _servicoDonoEvent(ServicoDonoCarroEventEnum.onSuggestionTap, e.item),
              ),
              const SizedBox(
                height: 5,
              ),
              SearchField<CarroModel>(
                initialValue: SearchFieldListItem<CarroModel>(
                  '${servico.carro!.id}|${servico.carro!.nome}',
                  item: servico.carro,
                  child: Text(servico.dono!.nome!)
                ),
                controller: _carroSearchFieldController,
                suggestions: (carrosSF!)
                  .map(
                    (e) => SearchFieldListItem<CarroModel>(
                      '${e.id}|${e.nome}',
                      item: e,
                      child: Text(e.nome as String)
                    )
                  ).toList(),
                suggestionState: Suggestion.hidden,
                suggestionAction: SuggestionAction.unfocus,
                searchInputDecoration: InputDecoration(
                  labelText: 'Carro',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _servicoCarroEvent(ServicoDonoCarroEventEnum.onPressed, null),
                  )
                ),
                onSuggestionTap: (e) => _servicoCarroEvent(ServicoDonoCarroEventEnum.onSuggestionTap, e.item),
              ),
              const SizedBox(
                height: 5
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async => _save(),
                    child: const Text('Salvar')
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async => _delete(),
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