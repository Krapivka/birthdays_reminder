import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/core/domain/enteties/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure, void>> addPerson(PersonEntity person);
  Future<Either<Failure, List<PersonEntity>>> getAllPersons();
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
