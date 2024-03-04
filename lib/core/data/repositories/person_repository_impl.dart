import 'package:birthdays_reminder/core/error/exception.dart';
import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/enteties/person_entity.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepository implements AbstractPersonRepository {
  final PersonLocalDataSource localDataSource;

  PersonRepository({required this.localDataSource});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons() async {
    try {
      final locationPerson = await localDataSource.getPersonsFromCache();
      return Right(locationPerson);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    try {
      final locationPerson = await localDataSource.getPersonsFromCache();
      return Right(locationPerson);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addPerson(PersonEntity person) async {
    try {
      return Right(
          await localDataSource.onePersonToCache(person as PersonModel));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<int> lastIndex() async {
    try {
      return await localDataSource.lastIndex();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<Either<Failure, void>> deletePerson(int id) async {
    try {
      return Right(await localDataSource.deletePersonById(id));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updatePerson(PersonModel person) async {
    try {
      return Right(await localDataSource.updatePerson(person));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
