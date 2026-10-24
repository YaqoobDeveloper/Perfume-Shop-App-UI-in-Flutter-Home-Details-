import 'package:flutter/material.dart';

import '../../theme/aroma_colors.dart';

/// Small white rounded square with a purple icon, e.g. like / share.
class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.size = 42,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AromaColors.surface,
            borderRadius: BorderRadius.circular(size * 0.3),
          ),
          child: Icon(icon, color: AromaColors.purple, size: size * 0.5),
        ),
      ),
    );
  }
}
