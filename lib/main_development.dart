import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:verygoodcoffee/bootstrap.dart';
import 'package:verygoodcoffee/features/app/app.dart';
import 'package:verygoodcoffee/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  unawaited(bootstrap(() => const App()));
}
