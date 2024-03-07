import 'package:floor/floor.dart';
import 'package:treball_final/model/usuari.dart';

@dao
abstract class UsuariDao {
  @Query('SELECT * FROM usuaris')
  Future<List<Usuari>> getAllUsuarios();

  @Query('SELECT * FROM usuaris WHERE id = :id')
  Future<Usuari?> getUsuarioById(int id);

  @Query('SELECT * FROM usuaris WHERE user = :user AND password = :password')
  Future<Usuari?> getUsuarioByCredenciales(String user, String password);

  @insert
  Future<void> insertUsuario(Usuari usuari);

  @update
  Future<void> updateUsuario(Usuari usuari);

  @delete
  Future<void> deleteUsuario(Usuari usuari);
}


