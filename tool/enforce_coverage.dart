import 'dart:convert';
import 'dart:io';

const _defaultCoverageFile = 'coverage/lcov.info';
const _defaultThresholdsFile = 'tool/coverage_thresholds.json';

Future<void> main(List<String> args) async {
  final parsedArgs = _parseArgs(args);
  final coveragePath = parsedArgs['coverage-file'] ?? _defaultCoverageFile;
  final thresholdsPath = parsedArgs['thresholds'] ?? _defaultThresholdsFile;

  final threshold = await _loadLineThreshold(thresholdsPath);
  final coverage = await _readLineCoverage(coveragePath);

  _printSummary(coverage: coverage, threshold: threshold, coveragePath: coveragePath, thresholdsPath: thresholdsPath);

  if (!coverage.meetsThreshold(threshold)) {
    stderr.writeln(
      'ERROR: Line coverage ${coverage.percentageString} is below '
      'the threshold ${threshold.toStringAsFixed(2)}%.',
    );
    exitCode = 2;
  }
}

Future<double> _loadLineThreshold(String thresholdsPath) async {
  final thresholdsFile = File(thresholdsPath);
  if (!thresholdsFile.existsSync()) {
    stderr.writeln('ERROR: Thresholds file not found at $thresholdsPath.');
    exitCode = 2;
    return 0;
  }

  final data = jsonDecode(await thresholdsFile.readAsString());
  final threshold = _extractLineThreshold(data);
  if (threshold == null) {
    stderr.writeln('WARN: No line threshold found in $thresholdsPath. Defaulting to 0%.');
    return 0;
  }

  if (threshold < 0 || threshold > 100) {
    stderr.writeln('ERROR: Line threshold must be between 0 and 100; got $threshold.');
    exitCode = 2;
  }

  return threshold;
}

double? _extractLineThreshold(dynamic data) {
  if (data is Map<String, dynamic>) {
    final topLevel = _extractLineValue(data);
    if (topLevel != null) {
      return topLevel;
    }

    final global = data['global'];
    if (global is Map<String, dynamic>) {
      return _extractLineValue(global);
    }
  }
  return null;
}

double? _extractLineValue(Map<String, dynamic> map) {
  for (final key in const ['lines', 'line', 'line_coverage', 'lineCoverage', 'min_lines', 'minimum_lines']) {
    final value = map[key];
    if (value is num) {
      return value.toDouble();
    }
  }
  return null;
}

Future<LineCoverage> _readLineCoverage(String coveragePath) async {
  final coverageFile = File(coveragePath);
  if (!coverageFile.existsSync()) {
    stderr.writeln('ERROR: Coverage file not found at $coveragePath.');
    exitCode = 2;
    return LineCoverage(linesFound: 0, linesHit: 0);
  }

  var linesFound = 0;
  var linesHit = 0;

  for (final line in await coverageFile.readAsLines()) {
    if (line.startsWith('LF:')) {
      linesFound += int.tryParse(line.substring(3).trim()) ?? 0;
    } else if (line.startsWith('LH:')) {
      linesHit += int.tryParse(line.substring(3).trim()) ?? 0;
    }
  }

  return LineCoverage(linesFound: linesFound, linesHit: linesHit);
}

void _printSummary({
  required LineCoverage coverage,
  required double threshold,
  required String coveragePath,
  required String thresholdsPath,
}) {
  stdout
    ..writeln('Coverage file: $coveragePath')
    ..writeln('Thresholds file: $thresholdsPath')
    ..writeln(
      'Line coverage: ${coverage.percentageString} '
      '($threshold% required)',
    );

  if (coverage.linesFound == 0) {
    stdout.writeln(
      'WARN: No lines were found in coverage data. '
      'Consider adding tests or ensuring coverage is generated.',
    );
  }
}

class LineCoverage {
  LineCoverage({required this.linesFound, required this.linesHit});

  final int linesFound;
  final int linesHit;

  double get percentage {
    if (linesFound == 0) {
      return 0;
    }
    return (linesHit / linesFound) * 100;
  }

  String get percentageString => percentage.toStringAsFixed(2);

  bool meetsThreshold(double threshold) {
    if (linesFound == 0) {
      return threshold <= 0;
    }
    return percentage >= threshold;
  }
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
