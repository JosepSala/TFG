import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:treball_final/database.dart';
import 'package:treball_final/model/usuari.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  int id = 0;
  String nom = "";
  String cognom = "";
  String treball = "";
  String grup = "";
  String user = "";
  String password = "";
  String password2 = "";

  List<String> _grupOptions = <String>["A1", "A2", "B", "C1", "C2", "AP"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Nuevo Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Nom'),
              onChanged: (value) {
                setState(() {
                  nom = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Cognoms'),
              onChanged: (value) {
                setState(() {
                  cognom = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Lloc de treball'),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  treball = value;
                });
              },
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: "Tria un grup"),
                items: _grupOptions.map((e) {
                  /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                  return DropdownMenuItem(child: Text(e), value: e);
                }).toList(),
                onChanged: (value) {
                  grup = value!;
                }),
            TextField(
              decoration: InputDecoration(labelText: 'Usuari'),
              onChanged: (value) {
                setState(() {
                  user = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nova Contrasenya'),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true, // Ocultar la contraseña con puntos
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Repetix Contrasenya'),
              onChanged: (value) {
                setState(() {
                  password2 = value;
                });
              },
              obscureText: true, // Ocultar la contraseña con puntos
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Validación de campos
                if (password == password2) {
                  // Las contraseñas coinciden, puedes continuar con la creación de usuario
                  final nuevoUsuario = Usuari(
                    // Id puede ser 0 si es autogenerado por la base de datos
                    id,
                    nom: this.nom,
                    cognom: this.cognom,
                    treball: this.treball,
                    grup: this.grup,
                    user: this.user,
                    password: this.password,
                  );
                  // Obtener la instancia de la base de datos
                  final database = await $FloorMyAppDB
                      .databaseBuilder('treball_final.db')
                      .build();

                  // Insertar el nuevo usuario en la base de datos
                  await database.usuariDao.insertUsuario(nuevoUsuario);

                  print("Usuario guardado en la base de datos: $nuevoUsuario");

                  // Navegar a la página de inicio o hacer cualquier otra acción necesaria
                  Navigator.pop(context);
                } else {
                  // Las contraseñas no coinciden, mostrar un mensaje de error
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Las contraseñas no coinciden. Por favor, inténtalo de nuevo.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // Cerrar el diálogo de error
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Crear Usuario'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_newgrup', grup));
    properties.add(StringProperty('_newgrup', grup));
  }
}
