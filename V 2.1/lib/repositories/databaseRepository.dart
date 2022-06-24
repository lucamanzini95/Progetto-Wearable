import 'package:progetto_wearable/database/database.dart';
import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier
{
  // the state of the database is just the AppDatabase
  final AppDatabase database;

  // default constructor
  DatabaseRepository({required this.database});
  

  Future<List<UserData?>> findUserData() async
  {
    final result = await database.userDao.findUserData();
    return result;
  }

  Future<void> insertUser(UserData user) async
  {
    await database.userDao.insertUser(user);
    notifyListeners();
  }

  Future<void> updateUser(UserData user) async
  {
    await database.userDao.updateUser(user);
    notifyListeners();
  }

  Future<void> removeUser(UserData user) async
  {
    await database.userDao.deleteUser(user);
    notifyListeners();
  }

  Future<List<SleepData>> findSleepData() async
  {
    final result = await database.sleepDao.findSleepData();
    return result;
  }

  Future<void> insertSleepData(SleepData sleepData) async
  {
    await database.sleepDao.insertSleep(sleepData);
    notifyListeners();
  }
}