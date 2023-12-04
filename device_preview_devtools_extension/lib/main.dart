import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FooDevToolsExtension());
}

class FooDevToolsExtension extends StatelessWidget {
  const FooDevToolsExtension({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: Placeholder(),
    );
  }
}
