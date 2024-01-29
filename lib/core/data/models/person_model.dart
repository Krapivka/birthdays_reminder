import 'package:birthdays_reminder/core/domain/enteties/person_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'person_model.g.dart';

@JsonSerializable()
class PersonModel extends PersonEntity {
  PersonModel(
      {required super.id,
      required super.name,
      required super.birthdate,
      super.listOfGifts});

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
