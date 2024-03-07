import 'package:floor/floor.dart';
import 'package:treball_final/model/comisioservei.dart';


@dao
abstract class ComisoServeiDao{
  @Query('SELECT * FROM comisoservei')
  Future<List<ComisoServei>> findAllComisiones();

  @Query('SELECT * FROM comisoservei')
  Future<List<ComisoServei>> findAllComisionesStream();

  @Query('SELECT * FROM comisoservei WHERE id = :id')
  Future<ComisoServei?> findComisionesById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComisiones(ComisoServei comisoServei);

  @delete
  Future<void> deleteComisiones(ComisoServei comisoServei);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateComisiones(ComisoServei comisoServei);

}
