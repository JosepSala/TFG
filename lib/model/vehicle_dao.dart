import 'package:floor/floor.dart';
import 'package:treball_final/model/vehicle.dart';

@dao
abstract class VehicleDao {
  @Query('SELECT * FROM vehicles')
  Future<List<Vehicle>> getAllVehicles();

  @Query('SELECT * FROM vehicles')
  Future<List<Vehicle>> findAllVehicles();

  @Query('SELECT * FROM vehicles WHERE id = :id')
  Future<Vehicle?> getVehicleById(int id);

  @insert
  Future<void> insertVehicle(Vehicle vehicle);

  @update
  Future<void> updateVehicle(Vehicle vehicle);

  @delete
  Future<void> deleteVehicle(Vehicle vehicle);
}
