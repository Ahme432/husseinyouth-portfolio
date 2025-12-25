import 'package:flutter/material.dart';

class WebHoverEffect extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;
  final VoidCallback? onTap;

  const WebHoverEffect({super.key, required this.builder, this.onTap});

  @override
  State<WebHoverEffect> createState() => _WebHoverEffectState();
}

class _WebHoverEffectState extends State<WebHoverEffect> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor:
          widget.onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.builder(context, _isHovered),
      ),
    );
  }
}
