// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html';

import 'package:devtools_device_preview/src/configuration/configuration.dart';
import 'package:devtools_device_preview/src/services/service.dart';

/// This adds a side menu to the html page.
class PreviewMenu {
  PreviewMenu(this.service) {
    _subscription = service.updates.listen(_buildMenu);
    service.get().then(_buildMenu);
  }
  late final StreamSubscription<PreviewConfiguration> _subscription;
  final PreviewService service;

  void _buildMenu(PreviewConfiguration configuration) {
    // TODO create a side menu with html elements
  }

  void dispose() {
    _subscription.cancel();
  }

  /// Gets the root menu Html div.
  ///
  /// Creates it and add it to the body if not existing.
  Element get menuElement {
    return document.body.getOrCreateChildWithId('device-preview-menu');
  }
}

extension on Element? {
  Element getOrCreateChildWithId(String id) {
    final result = document.getElementById(id);
    if (result != null) {
      return result;
    }

    final element = DivElement()..id = id;
    this?.children.add(element);
    return element;
  }

  Element getOrCreateChildWithClass(String className) {
    final result = this?.getElementsByClassName(className);
    if (result != null && result.isNotEmpty) {
      final child = result.first;
      if (child is Element) return child;
    }
    return createChildWithClass(className);
  }

  Element createChildWithId(String id) {
    final element = DivElement()..id = id;
    this?.children.add(element);
    return element;
  }

  Element createChildWithClass(String className) {
    final element = DivElement()..className = className;
    this?.children.add(element);
    return element;
  }
}
