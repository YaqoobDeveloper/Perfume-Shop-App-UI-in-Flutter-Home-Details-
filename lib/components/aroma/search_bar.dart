import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/aroma_colors.dart';

/// White pill search field with a round purple search button.
class AromaSearchBar extends StatelessWidget {
  const AromaSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 22, right: 6),
      decoration: BoxDecoration(
        color: AromaColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: AromaColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              cursorColor: AromaColors.purple,
              style: GoogleFonts.poppins(fontSize: 14, color: AromaColors.ink),
              decoration: InputDecoration(
                hintText: 'Find Your Favorite...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AromaColors.faint,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AromaColors.purple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
