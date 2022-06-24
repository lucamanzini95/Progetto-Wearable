import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:floor/floor.dart';

@dao
abstract class SleepDao
{
  // Query 1: obtain all entries from the sleepData table
  @Query('SELECT * FROM SleepData')
  Future<List<SleepData>> findSleepData();

  // Query 2 : insert sleep period in the table
  @insert
  Future<void> insertSleep(SleepData sleepData);
}