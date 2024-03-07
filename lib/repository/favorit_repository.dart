import 'package:treball_final/database.dart';
import 'package:treball_final/model/comisioservei.dart';
import 'package:treball_final/model/comisioservei_dao.dart';
import 'package:treball_final/model/usuari.dart';
import 'package:treball_final/model/usuari_dao.dart';

class FavoritRepository {
  MyAppDB? _database; // Referència a la BD
  UsuariDao? _daoU; // Referència al DAO
  ComisoServeiDao? _daoC;

  FavoritRepository._(); // Constructor privat

  // Instància única del repositori. La podem crear directament
  // en la inicialització
  static final FavoritRepository _instance = FavoritRepository._();

  // Quan se'ns demane el repositori retornem la instància.
  factory FavoritRepository() {
    return _instance;
  }

  // Connexió a la base de dades
  Future<void> connectaDB() async {
    if (_database == null) {
      // Creem la base de dades només si no s'ha creat ja
      _database = await $FloorMyAppDB.databaseBuilder('my_app.db').build();

      // Creem el DAO
      _daoU = _database?.usuariDao;
      _daoC = _database?.comisoServeiDao;
    }
  }

  Object findAllUsuarios() {
    return _daoU?.getAllUsuarios() ?? const Stream.empty();
  }

  Future<void> insertUsuario(Usuari usuari) {
    return _daoU?.insertUsuario(usuari) ?? Future.value();
  }

  Future<void> deleteUsuario(Usuari usuari) {
    return _daoU?.deleteUsuario(usuari) ?? Future.value();
  }

  Future findAllComisiones() {
    return _daoC?.findAllComisiones() ?? Future.value();
  }

  // Stream findAllComisionesStream() {
  //   return _daoC?.findAllComisiones() ?? const Stream.empty();
  // }

  Future<void> insertComisiones(ComisoServei comisoServei) {
    return _daoC?.insertComisiones(comisoServei) ?? Future.value();
  }

  Future<void> deleteComisiones(ComisoServei comisoServei) {
    return _daoC?.deleteComisiones(comisoServei) ?? Future.value();
  }
}
