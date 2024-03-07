import 'package:flutter/material.dart';
import 'package:treball_final/model/comisioservei.dart'; // Asegúrate de importar el modelo correcto
import 'package:treball_final/database.dart'; // Asegúrate de importar el servicio de base de datos

class CreaComisioPage extends StatefulWidget {
  @override
  _CreaComisioPageState createState() => _CreaComisioPageState();
}

class _CreaComisioPageState extends State<CreaComisioPage> {
  int id = 0;
  String descripcio = "";
  String h_ixida = "";
  String h_tornada = "";
  String dia = "";
  String km_total = ""; // Asegúrate de tener tu servicio de base de datos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Comissió de Servei'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Descripció'),
              onChanged: (value) {
                setState(() {
                  descripcio = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Hora de Eixida'),
              onChanged: (value) {
                setState(() {
                  h_ixida = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Hora de Tornada'),
              onChanged: (value) {
                setState(() {
                  h_tornada = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Data'),
              onChanged: (value) {
                setState(() {
                  dia = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Kilòmetres totals'),
              onChanged: (value) {
                setState(() {
                  km_total = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Acción para guardar la comisión en la base de datos
                final nuevaComisio = ComisoServei(id,
                    h_ixida: this.h_ixida,
                    h_tornada: this.h_tornada,
                    dia: this.dia,
                    km_total: this.km_total,
                    descripcio: this.descripcio);

                // Obtener la instancia de la base de datos
                final database = await $FloorMyAppDB
                    .databaseBuilder('treball_final.db')
                    .build();

                // Insertar el nueva Comisio en la base de datos
                await database.comisoServeiDao.insertComisiones(nuevaComisio);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 5),
                    content: const Text('Comisio creada correctament.'),
                    action: SnackBarAction(
                      label: 'Tanca',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              },
              child: Text('Guardar Comisión'),
            ),
          ],
        ),
      ),
    );
  }
}
