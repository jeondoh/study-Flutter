import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// dart run build_runner watch -d
part 'date_formatter.g.dart';

@riverpod
DateFormat dateFormatter(DateFormatterRef ref) {
  /// Date formatter to be used in the app.
  return DateFormat.MMMEd();
}
