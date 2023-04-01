import 'package:app_oficina/app/views/gerenciar_servico_page_view.dart';
import 'package:app_oficina/app/views/inserir_servico_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../controllers/servicos_page_controller.dart';

class ServicosPage extends StatefulWidget {
  @override
  ServicosPageState createState() {
    return ServicosPageState();
  }
}

class ServicosPageState extends State<ServicosPage> {

  final _controller = ServicosPageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicos'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.start();
            }, 
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller.servicos,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1000,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Id')
                      ),
                      DataColumn(
                        label: Text('Data da entrega')
                      ),
                      DataColumn(
                        label: Text('Preço')
                      ),
                      DataColumn(
                        label: Text('Observação')
                      ),
                      DataColumn(
                        label: Text('Dono')
                      ),
                      DataColumn(
                        label: Text('Carro')
                      )
                    ], 
                    rows: (_controller.servicos.value.reversed).map(
                      (servico) => DataRow(
                        cells: [
                          DataCell(
                            Text(servico.id.toString())
                          ),
                          DataCell(
                            Text(servico.dataEntrega.toString())
                          ),
                          DataCell(
                            Text(servico.preco.toString())
                          ),
                          DataCell(
                            Text(servico.observacao.toString())
                          ),
                          DataCell(
                            Text(servico.dono!.nome.toString())
                          ),
                          DataCell(
                            Text(servico.carro!.nome.toString())
                          )
                        ],
                        onSelectChanged:(value) async {
                          final donos = await _controller.getDonos();
                          final carros = await _controller.getCarros();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:(context) => GerenciarServicoPage(
                                id: servico.id,
                                dataEntrega: servico.dataEntrega,
                                preco: servico.preco,
                                observacao: servico.observacao,
                                carro: servico.carro,
                                dono: servico.dono,
                                carros: carros,
                                donos: donos
                              ),
                            )
                          );
                        },
                      )
                    ).toList(),
                    showCheckboxColumn: false,
                  )
                ],
              )
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final donos = await _controller.getDonos();
          final carros = await _controller.getCarros();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InserirServicoPage(donos: donos, carros: carros)
            )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}