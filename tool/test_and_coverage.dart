import 'dart:io';

const _defaultCoverageFile = 'coverage/lcov.info';
const _defaultThresholdsFile = 'tool/coverage_thresholds.json';

Future<void> main(List<String> args) async {
  final parsedArgs = _parseArgs(args);
  final coveragePath = parsedArgs['coverage-file'] ?? _defaultCoverageFile;
  final thresholdsPath = parsedArgs['thresholds'] ?? _defaultThresholdsFile;

  final useFvm = parsedArgs.containsKey('use-fvm') || parsedArgs['flutter-bin'] == 'fvm';
  final flutterBin = useFvm ? 'fvm' : (parsedArgs['flutter-bin'] ?? 'flutter');

  final flutterArgs = useFvm ? <String>['flutter', 'test', '--coverage'] : <String>['test', '--coverage'];

  final testExit = await _runCommand(flutterBin, flutterArgs);
  if (testExit != 0) {
    exitCode = testExit;
    return;
  }

  final enforceExit = await _runCommand('dart', [
    'tool/enforce_coverage.dart',
    '--coverage-file',
    coveragePath,
    '--thresholds',
    thresholdsPath,
  ]);
  if (enforceExit != 0) {
    exitCode = enforceExit;
  }
}

Future<int> _runCommand(String executable, List<String> arguments) async {
  stdout.writeln('Running: $executable ${arguments.join(' ')}');
  final process = await Process.start(executable, arguments);
  final stdoutDone = stdout.addStream(process.stdout);
  final stderrDone = stderr.addStream(process.stderr);
  final exitCode = await process.exitCode;
  await Future.wait([stdoutDone, stderrDone]);
  return exitCode;
}

Map<String, String> _parseArgs(List<String> args) {
  final parsed = <String, String>{};
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (!arg.startsWith('--')) {
      continue;
    }

    final trimmed = arg.substring(2);
    final equalsIndex = trimmed.indexOf('=');
    if (equalsIndex != -1) {
      parsed[trimmed.substring(0, equalsIndex)] = trimmed.substring(equalsIndex + 1);
      continue;
    }

    final next = i + 1 < args.length ? args[i + 1] : null;
    if (next != null && !next.startsWith('--')) {
      parsed[trimmed] = next;
      i++;
    } else {
      parsed[trimmed] = 'true';
    }
  }
  return parsed;
}
