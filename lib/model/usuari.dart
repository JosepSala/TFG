import 'package:floor/floor.dart';

@Entity(tableName: "usuaris")
class Usuari {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String nom;
  final String cognom;
  final String? treball;
  final String? grup;
  final String user;
  final String password;

  Usuari(this.id, {required this.nom, required this.cognom, this.treball, this.grup, required this.user, required this.password});
}

