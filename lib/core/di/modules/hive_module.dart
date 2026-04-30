import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/local/hive_service.dart';

@module
abstract class HiveModule {
  @lazySingleton
  HiveService get hiveService => HiveService();
}
