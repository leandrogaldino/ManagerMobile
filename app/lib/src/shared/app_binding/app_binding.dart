import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/models/person_compressor_model.dart';
import 'package:manager_mobile_app/src/models/person_model.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_coalescent_repository.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:manager_mobile_app/src/repositories/person_repository.dart';
import 'package:manager_mobile_app/src/repositories/repository.dart';
import 'package:manager_mobile_app/src/repositories/repository_by_parent.dart';
import 'package:manager_mobile_app/src/shared/database/localdb.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';

class AppBinding {
  AppBinding._();

  static GetIt locator = GetIt.instance;
  static void setupLocator() {
    _registerDatabase();
    _registerPersonCompressorCoalescentRepository();
    _registerPersonCompressorRepository();
    _registerPersonRepository();
  }

  static void _registerDatabase() {
    locator.registerSingleton<LocalDB>(
      SqfliteDB(),
    );
  }

  static void _registerPersonCompressorCoalescentRepository() {
    locator.registerSingleton<RepositoryByParent<PersonCompressorCoalescentModel>>(
      PersonCompressorCoalescentRepository(
        db: GetIt.I<LocalDB>(),
      ),
    );
  }

  static void _registerPersonCompressorRepository() {
    locator.registerSingleton<RepositoryByParent<PersonCompressorModel>>(
      PersonCompressorRepository(
        db: GetIt.I<LocalDB>(),
        coalescentRepository: GetIt.I<RepositoryByParent<PersonCompressorCoalescentModel>>(),
      ),
    );
  }

  static void _registerPersonRepository() {
    locator.registerSingleton<Repository<PersonModel>>(
      PersonRepository(
        db: GetIt.I<LocalDB>(),
        compressorRepository: GetIt.I<RepositoryByParent<PersonCompressorModel>>(),
      ),
    );
  }
}
