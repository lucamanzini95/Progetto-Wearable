import 'package:floor/floor.dart';
import 'package:progetto_wearable/database/entities/userData.dart';

@Entity(tableName: 'StepsData', foreignKeys: [
  ForeignKey(
    childColumns: ['userId'],
    parentColumns: ['id'],
    entity: UserData,
  ),
])
class StepsData {
  @PrimaryKey(autoGenerate: true)
  //@ColumnInfo(name: 'id')
  final int? stepsId;

  @ColumnInfo(name: 'userId')
  final int? userId;

  DateTime dateOfSteps;
  double? steps;

  StepsData(this.stepsId, this.userId, this.dateOfSteps, this.steps);
}
