import 'package:progetto_wearable/database/database.dart';
import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:progetto_wearable/database/entities/stepsData.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  // the state of the database is just the AppDatabase
  final AppDatabase database;

  // default constructor
  DatabaseRepository({required this.database});

  Future<List<UserData?>> findUserData() async {
    final result = await database.userDao.findUserData();
    return result;
  }

  Future<void> insertUser(UserData user) async {
    await database.userDao.insertUser(user);
    notifyListeners();
  }

  Future<void> updateUser(UserData user) async {
    await database.userDao.updateUser(user);
    notifyListeners();
  }

  Future<void> removeUser(UserData user) async {
    await database.userDao.deleteUser(user);
    notifyListeners();
  }

  Future<List<SleepData>> findSleepData() async {
    final result = await database.sleepDao.findSleepData();
    return result;
  }

  Future<List<SleepData>> findUserSleep(int userId) async {
    final result = await database.sleepDao.findUserSleep(userId);
    return result;
  }

  Future<void> deleteSleep(List<SleepData> sleepData) async {
    await database.sleepDao.deleteSleep(sleepData);
    notifyListeners();
  }

  Future<void> insertSleepData(List<SleepData> sleepData) async {
    await database.sleepDao.insertSleep(sleepData);
    notifyListeners();
  }

  Future<List<StepsData>> findStepsData() async {
    final result = await database.stepsDao.findStepsData();
    return result;
  }

  Future<void> insertStepsData(StepsData stepsData) async {
    await database.stepsDao.insertSteps(stepsData);
    notifyListeners();
  }
}
