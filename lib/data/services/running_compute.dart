import 'dart:async';

import 'package:isolates_helper/isolates_helper.dart';

final IsolatesHelper _worker = IsolatesHelper(
  concurrent: 3,
);

typedef ComputeFunction<RESULT, PARAM> = FutureOr<RESULT> Function(
  PARAM parameter,
);

Future<RESULT> compute<PARAM extends Object, RESULT extends Object>(
  ComputeFunction<RESULT, PARAM> function,
  PARAM parameter,
) async {
  final RESULT result =
      await _worker.compute<RESULT, PARAM>(function, parameter);
  return result;
}
