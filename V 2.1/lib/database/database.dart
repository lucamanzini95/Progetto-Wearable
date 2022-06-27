import 'dart:async';
import 'package:floor/floor.dart';
import 'package:progetto_wearable/database/daos/sleepDao.dart';
import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:progetto_wearable/database/daos/stepsDao.dart';
import 'package:progetto_wearable/database/entities/stepsData.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:progetto_wearable/database/daos/userDao.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'typeConverters/dateTimeConverter.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [UserData, SleepData, StepsData])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  SleepDao get sleepDao;
  StepsDao get stepsDao;
}
