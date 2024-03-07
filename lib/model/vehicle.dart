import 'package:floor/floor.dart';

@Entity(tableName: "vehicles")
class Vehicle {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? matricula;
  final String? marca;
  final String? model;

  Vehicle(this.id, {required this.matricula, required this.marca, required this.model});
}
