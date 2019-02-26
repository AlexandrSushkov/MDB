import 'dart:async';

import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:meta/meta.dart';

abstract class BaseBloc implements DisposableBloc {
  final _subscriptions = <StreamSubscription<dynamic>>[];
  final _controllers = <StreamController>[];

  @override
  void dispose() {
//    _closeControllers();
//    _clearSubscriptions();
  }

  _closeControllers() {
    _controllers.forEach((controller) => controller.close());
  }

  _clearSubscriptions() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }

}
