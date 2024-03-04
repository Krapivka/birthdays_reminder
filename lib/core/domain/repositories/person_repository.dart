import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/core/domain/enteties/person_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractPersonRepository {
  Future<Either<Failure, void>> addPerson(PersonEntity person);
  Future<Either<Failure, void>> deletePerson(int id);
  Future<Either<Failure, void>> updatePerson(PersonModel person);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
  Future<Either<Failure, List<PersonEntity>>> getAllPersons();
  Future<int> lastIndex();
}
