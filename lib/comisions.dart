import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treball_final/crea_comisio.dart';
import 'package:treball_final/database.dart';
import 'package:treball_final/login.dart';
import 'package:treball_final/model/comisioservei.dart';
import 'package:treball_final/vehicles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();
  late List<ComisoServei> _comisiones;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _comisiones = [];
    _loadComisiones();
    _startTimer();
  }

  void _loadComisiones() async {
    List<ComisoServei> comisiones =
        await _databaseService.findAllComisionesStream();
    setState(() {
      _comisiones = comisiones;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _loadComisiones();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comisiones'),
      ),
      drawer: _buildDrawer(context),
      body: _buildComisionesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreaComisioPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Usuario Conectado'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Vehicles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehiclesPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComisionesList() {
    return ListView.builder(
      itemCount: _comisiones.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_comisiones[index].id.toString()),
          onDismissed: (direction) {
            _eliminarComision(_comisiones[index]);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('Descripción: ${_comisiones[index].descripcio}'),
              subtitle: Text('Fecha: ${_comisiones[index].dia}'),
            ),
          ),
        );
      },
    );
  }

  void _eliminarComision(ComisoServei comisoServei) {
    _databaseService.deleteComisiones(comisoServei);
    _loadComisiones();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Comisio eliminada correctament.'),
        action: SnackBarAction(
          label: 'Tanca',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
