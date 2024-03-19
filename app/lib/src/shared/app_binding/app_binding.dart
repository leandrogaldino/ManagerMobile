import 'package:manager_mobile_app/src/models/person_model.dart';
import 'package:manager_mobile_app/src/repositories/person_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:manager_mobile_app/src/repositories/repository.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';

class AppBinding {
  AppBinding._();

  static GetIt locator = GetIt.instance;
  static void setupLocator() {
    _registerDatabase();
    _registerPersonRepository();
  }

  static void _registerDatabase() {
    locator.registerSingleton<SqfliteDB>(
      SqfliteDB(),
    );
  }

  static void _registerPersonRepository() {
    locator.registerSingleton<Repository<PersonModel>>(
      PersonRepository(
        db: GetIt.I<SqfliteDB>(),
      ),
    );
  }
}
