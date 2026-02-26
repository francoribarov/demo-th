import 'package:flutter/foundation.dart';

/// Severity for presentation-layer feedback notices.
enum FeedbackSeverity {
  success,
  error,
  warning,
  info,
}

/// Typed user-facing feedback notice emitted by presentation state.
@immutable
class FeedbackNotice {
  /// Creates a typed feedback notice.
  const FeedbackNotice({
    required this.message,
    required this.severity,
  });

  /// Text shown to the user.
  final String message;

  /// Tone used by feedback renderers.
  final FeedbackSeverity severity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FeedbackNotice &&
        other.message == message &&
        other.severity == severity;
  }

  @override
  int get hashCode => Object.hash(message, severity);
}
