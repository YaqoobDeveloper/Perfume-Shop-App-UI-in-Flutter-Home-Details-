import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/aroma_colors.dart';

/// Solid purple rounded button. Grows to fill the width when [expand].
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 58,
    this.expand = false,
  });

  final String label;
  final VoidCallback onTap;
  final double height;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: expand ? double.infinity : null,
          padding: EdgeInsets.symmetric(horizontal: height * 0.6),
          decoration: BoxDecoration(
            color: AromaColors.purple,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          // Hugs the label unless the button should fill the width.
          child: Center(
            widthFactor: expand ? null : 1,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: height > 44 ? 16 : 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
