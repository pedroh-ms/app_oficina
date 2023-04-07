import 'package:app_oficina/app/globals.dart';
import 'package:get_it/get_it.dart';

class ConfigPageController {
  String host = '';
  String port = '';

  void save() {
    if (host.isNotEmpty) {
      GetIt.I<Globals>().url = host + (port.isNotEmpty ? ':$port' : '');
      GetIt.I<Globals>().isConfigured = true;
    }
  }
}