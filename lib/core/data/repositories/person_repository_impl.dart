import 'package:birthdays_reminder/core/error/exception.dart';
import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/enteties/person_entity.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonLocalDataSource localDataSource;

  PersonRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons() async {
    try {
      final locationPerson = await localDataSource.getLastPersonsFromCache();
      return Right(locationPerson);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    try {
      final locationPerson = await localDataSource.getLastPersonsFromCache();
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
  Future<int> getLength() async {
    try {
      return await localDataSource.length();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}