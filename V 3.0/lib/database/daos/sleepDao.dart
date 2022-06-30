import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:floor/floor.dart';

@dao
abstract class SleepDao
{
  // Query 1: obtain all entries from the sleepData table
  @Query('SELECT * FROM SleepData')
  Future<List<SleepData>> findSleepData();

  // Query 3: obtain all data entries older than a certain dateTime
  @Query('SELECT * FROM SleepData WHERE userId = :id')
  Future<List<SleepData>> findUserSleep(int id);
  
  // Query 2 : insert sleep period in the table
  @insert
  Future<void> insertSleep(List<SleepData> sleepDatas);

  @delete
  Future<void> deleteSleep(List<SleepData> userSleep);

}