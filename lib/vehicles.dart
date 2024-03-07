import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treball_final/crea_vehicle.dart';
import 'package:treball_final/database.dart';
import 'package:treball_final/model/vehicle.dart';

class VehiclesPage extends StatefulWidget {
  @override
  _VehiclesPageState createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  final DatabaseService _databaseService = DatabaseService();
  late List<Vehicle> _vehicles;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _vehicles = []; // Inicializamos la lista aquí
    _loadVehicles();
    _startTimer();
  }

  void _loadVehicles() async {
    List<Vehicle> vehicles = await _databaseService.findAllVehicles();
    setState(() {
      _vehicles = vehicles;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _loadVehicles();
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
        title: Text('Vehicles'),
      ),
      body: _buildVehiclesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreaVehicle()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildVehiclesList() {
    return ListView.builder(
      itemCount: _vehicles.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_vehicles[index].id.toString()),
          onDismissed: (direction) {
            _eliminarVehicle(_vehicles[index]);
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
              title: Text('Matrícula: ${_vehicles[index].matricula}'),
              subtitle: Text('Marca: ${_vehicles[index].marca}'),
            ),
          ),
        );
      },
    );
  }

  void _eliminarVehicle(Vehicle vehicle) {
    _databaseService.deleteVehicle(vehicle);
    _loadVehicles();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Vehicle eliminat correctament.'),
        action: SnackBarAction(
          label: 'Tanca',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    // Lógica para mostrar un cuadro de diálogo para confirmar el cierre de sesión
    // ...
  }
}
