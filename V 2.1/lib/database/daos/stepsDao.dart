import 'package:progetto_wearable/database/entities/stepsData.dart';
import 'package:floor/floor.dart';

@dao
abstract class StepsDao {
  // Query 1: obtain all entries from the stepsData table
  @Query('SELECT * FROM SleepData')
  Future<List<StepsData>> findStepsData();

  // Query 2 : insert new step in the table
  @insert
  Future<void> insertSteps(StepsData stepsData);
}
