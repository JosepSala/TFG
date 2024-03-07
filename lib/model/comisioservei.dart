import 'package:floor/floor.dart';

@Entity(tableName: "comisoservei")
class ComisoServei {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String descripcio;
  final String h_ixida;
  final String h_tornada;
  final String dia;
  final String km_total;

  ComisoServei(this.id, {required this.descripcio, required this.h_ixida, required this.h_tornada, required this.dia, required this.km_total});
}
