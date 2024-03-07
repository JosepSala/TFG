import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:treball_final/model/comisioservei.dart';
import 'package:treball_final/model/comisioservei_dao.dart';
import 'package:treball_final/model/usuari.dart';
import 'package:treball_final/model/usuari_dao.dart';
import 'package:treball_final/model/vehicle.dart';
import 'package:treball_final/model/vehicle_dao.dart';

//Injectem el codi generat per floor_generator
part 'database.g.dart';

@Database(version: 1, entities: [Usuari, Vehicle, ComisoServei])
//@Database(version: 1, entities: [Vehicle])
abstract class MyAppDB extends FloorDatabase {
  UsuariDao get usuariDao;
  VehicleDao get vehicleDao;
  ComisoServeiDao get comisoServeiDao;
}

class DatabaseService {
  Future<MyAppDB> openDatabase() async {
    return await $FloorMyAppDB.databaseBuilder('treball_final.db').build();
  }

  Future<Usuari?> getUsuariByCredenciales(String user, String password) async {
    final database = await openDatabase();
    return await database.usuariDao.getUsuarioByCredenciales(user, password);
  }

  Future<List<ComisoServei>> findAllComisionesStream() async {
    final database = await openDatabase();
    return database.comisoServeiDao.findAllComisionesStream();
  }

  Future<List<Vehicle>> findAllVehicles() async {
    final database = await openDatabase();
    return database.vehicleDao.findAllVehicles();
  }

  Future<void> deleteComisiones(ComisoServei comisoServei) async{
    final database = await openDatabase();
    return database.comisoServeiDao.deleteComisiones(comisoServei);
  }

  Future<void> deleteVehicle(Vehicle vehicle) async{
    final database = await openDatabase();
    return database.vehicleDao.deleteVehicle(vehicle);
  }
}
