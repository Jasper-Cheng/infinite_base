import 'package:logger/logger.dart';
import 'package:infinite_base/configs/app_config.dart';

class LogUtil{
  static Logger logger=Logger(printer: PrettyPrinter(methodCount: 0));

  static void d(message) => AppConfig.deBug?logger.d(message):null;
  static void w(message) => AppConfig.deBug?logger.w(message):null;
  static void e(message) => AppConfig.deBug?logger.e(message):null;
}