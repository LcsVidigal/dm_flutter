import 'dart:convert';
import 'package:dm_flutter/homepage.dart';
import 'package:dm_flutter/tela_login/login_page_controller.dart';
import 'package:dm_flutter/services/preferences.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = LoginController();
  final TextEditingController _coreId = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              height: double.infinity,
              color: Colors.grey,
              child: const Image(
                image: AssetImage('lib/assets/login.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _coreId,
                    decoration: const InputDecoration(labelText: 'CoreID'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      String coreId = _coreId.text;
                      String password = _passwordController.text;
                      String token =
                          base64Url.encode(utf8.encode("$coreId:$password"));

                      bool value = await loginController.login(token);

                      if (value) {
                        Preferences().saveLogin(coreId, password, token);
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                        
                      } else {
                        debugPrint("login inválido");
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
