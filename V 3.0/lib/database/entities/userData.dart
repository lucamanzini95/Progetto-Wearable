import 'package:floor/floor.dart';

@Entity(
  tableName: 'UserData',
)
class UserData
{
  @PrimaryKey(autoGenerate : true)
  //@ColumnInfo(name: 'id')
  final int? id;

  final String name;
  final String surname;
  final int age;
  final int height;
  final int weight;

  UserData(this.id, this.name, this.surname, this.age, this.height, this.weight);
}