import 'package:app_oficina/app/views/inserir_carro_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../controllers/carros_page_controller.dart';

class CarrosPage extends StatefulWidget {
  @override
  CarrosPageState createState() {
    return CarrosPageState ();
  }
}

class CarrosPageState extends State<CarrosPage> {

  final _controller = CarrosPageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.start();
            },
            icon: const Icon(Icons.refresh_outlined)
          ),
        ]
      ),
      body: AnimatedBuilder(
        animation: _controller.carrosdonos,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 500,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Id')
                      ),
                      DataColumn(
                        label: Text('Nome')
                      ),
                      DataColumn(
                        label: Text('Cor')
                      ),
                      DataColumn(
                        label: Text('Dono')
                      )
                    ],
                    rows: (_controller.carrosdonos.value.reversed).map(
                      (carro) => DataRow(
                        cells: [
                          DataCell(
                            Text(carro.id.toString())
                          ),
                          DataCell(
                            Text(carro.nome.toString())
                          ),
                          DataCell(
                            Text(carro.cor.toString())
                          ),
                          DataCell(
                            Text(carro.dono!.nome.toString())
                          )
                        ]
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InserirCarroPage(donos: donos)
            )
          );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}