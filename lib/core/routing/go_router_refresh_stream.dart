import 'dart:async';

import 'package:flutter/foundation.dart';

/// A [ChangeNotifier] that triggers GoRouter refreshes from a [Stream].
class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [ChangeNotifier] that listens to [stream] for router refreshes.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
