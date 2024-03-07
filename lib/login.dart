import 'package:flutter/material.dart';
import 'package:treball_final/comisions.dart';
import 'package:treball_final/create_user.dart';

import 'package:treball_final/database.dart';
import 'package:treball_final/model/usuari.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _validarCredenciales() async {
    String user = _userController.text;
    String password = _passwordController.text;

    Usuari? usuari = await _databaseService.getUsuariByCredenciales(
        user, password);

    if (usuari != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage()));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Credenciales incorrectas. Por favor, inténtalo de nuevo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio de Sesión'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/inicio.jpg'), // Agregar foto
                TextField(
                  controller: _userController,
                  decoration: InputDecoration(labelText: 'Usuario'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true, // Ocultar la contrasenya
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Iniciar Sesión'),
                  onPressed: _validarCredenciales
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUserPage()));
                    print('Crear nuevo usuario');
                  },
                  child: Text('Crear Nuevo Usuario'),
                ),
              ],
            ),
          ),
        ));
  }
}
