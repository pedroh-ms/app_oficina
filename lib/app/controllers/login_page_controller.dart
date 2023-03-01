class LoginPageController {
  
  Future<bool> permitirLogin(String usuario, String senha) async {
    return (usuario == 'pedrohms' && senha == '1234');
  }
}