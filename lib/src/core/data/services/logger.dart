import 'package:logger/logger.dart';

class DebugLogPrinter extends LogPrinter {
  final String className;

  DebugLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    return [color('$emoji $className - ${event.message}')];
  }
}

Logger createLogger(String className) =>
    Logger(printer: DebugLogPrinter(className ?? ''));
