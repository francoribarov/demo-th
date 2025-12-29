import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mobile_table_hopping/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize date formatting for Spanish locale
  await initializeDateFormatting('es_UY');

  // Bootstrap and run the app
  await bootstrap();
}
