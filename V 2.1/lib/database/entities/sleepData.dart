import 'package:floor/floor.dart';
import 'package:progetto_wearable/database/entities/userData.dart';

@Entity
(
  tableName: 'SleepData',
  foreignKeys:
  [
    ForeignKey
    (
      childColumns: ['userId'],
      parentColumns: ['id'],
      entity: UserData,
    ),
  ]
)

class SleepData
{
  @PrimaryKey(autoGenerate : true)
  //@ColumnInfo(name: 'id')
  final int? sleepId;

  @ColumnInfo(name: 'userId')
  final int? userId;

  DateTime dateOfSleep;
  DateTime entryDateTime;
  String? level;

  SleepData(this.sleepId, this.userId, this.dateOfSleep, this.entryDateTime, this.level);
}