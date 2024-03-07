import 'package:flutter/material.dart';
import 'package:treball_final/model/vehicle.dart'; // Asegúrate de importar el modelo correcto
import 'package:treball_final/database.dart'; // Asegúrate de importar el servicio de base de datos

class CreaVehicle extends StatefulWidget {
  @override
  _CreaVehicleState createState() => _CreaVehicleState();
}

class _CreaVehicleState extends State<CreaVehicle> {
  int id = 0;
  String matricula = "";
  String marca = "";
  String model = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Matricula'),
              onChanged: (value) {
                setState(() {
                  matricula = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Marca'),
              onChanged: (value) {
                setState(() {
                  marca = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Model'),
              onChanged: (value) {
                setState(() {
                  model = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Acción para guardar la comisión en la base de datos
                final newVehicle = Vehicle(
                    id,
                    matricula: this.matricula,
                    marca: this.marca,
                    model: this.model);

                // Obtener la instancia de la base de datos
                final database = await $FloorMyAppDB
                    .databaseBuilder('treball_final.db')
                    .build();

                // Insertar el nueva Comisio en la base de datos
                await database.vehicleDao.insertVehicle(newVehicle);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 5),
                    content: const Text('Vehicle creat correctament.'),
                    action: SnackBarAction(
                      label: 'Tanca',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              },
              child: Text('Guardar vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
