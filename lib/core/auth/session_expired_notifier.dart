import 'dart:async';

import 'package:injectable/injectable.dart';

/// Lightweight broadcast notifier that signals a session expiry event.
///
/// Sits between the network layer and the auth BLoC with no dependencies of
/// its own, avoiding any circular dependency.
@lazySingleton
class SessionExpiredNotifier {
  final _controller = StreamController<void>.broadcast();

  /// Stream that emits whenever the session expires.
  Stream<void> get stream => _controller.stream;

  /// Notifies listeners that the session has expired.
  void notifySessionExpired() => _controller.add(null);
}
