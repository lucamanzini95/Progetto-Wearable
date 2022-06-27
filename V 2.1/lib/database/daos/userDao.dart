import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao
{
  // Query 1: obtain all entries from the userData table
  @Query('SELECT * FROM UserData')
  Future<List<UserData>> findUserData();

  // Query 2 : insert user in the table
  @insert
  Future<void> insertUser(UserData user);

  // Query 3 : update user information
  @update
  Future<void> updateUser(UserData user);

  // Query 4 : remove information
  @delete
  Future<void> deleteUser(UserData user);

}


