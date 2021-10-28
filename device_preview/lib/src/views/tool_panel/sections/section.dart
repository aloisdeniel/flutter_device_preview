import 'package:flutter/material.dart';

class ToolPanelSection extends StatelessWidget {
  const ToolPanelSection({
    Key? key,
    required this.title,
    required this.icon,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 32.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SafeArea(
              top: false,
              bottom: false,
              minimum: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
                bottom: 4,
              ),
              child: Text(
                title.toUpperCase(),
                style: theme.textTheme.subtitle2,
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
