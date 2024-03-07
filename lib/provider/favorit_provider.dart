import 'package:flutter/foundation.dart';
import 'package:treball_final/model/comisioservei.dart';
import 'package:treball_final/model/usuari.dart';
import 'package:treball_final/repository/favorit_repository.dart';

class FavoritProvider with ChangeNotifier {
  final FavoritRepository _repository = FavoritRepository();

  Object findAllUsuarios() {
   return _repository.findAllUsuarios();
}

Future<void> insertUsuario(Usuari usuari) async {
  await _repository.insertUsuario(usuari);
  notifyListeners();
}

Future<void> deleteUsuario(Usuari usuari) async {
  await _repository.deleteUsuario(usuari);
  notifyListeners();
}

// Stream findAllComisionesStream() {
//    return _repository.findAllComisionesStream();
// }

Future<void> insertComisiones(ComisoServei comisoServei) async {
  await _repository.insertComisiones(comisoServei);
  notifyListeners();
}

Future<void> deleteComisiones(ComisoServei comisoServei) async {
  await _repository.deleteComisiones(comisoServei);
  notifyListeners();
}
}