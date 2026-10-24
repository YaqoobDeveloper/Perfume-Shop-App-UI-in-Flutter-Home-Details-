import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/products.dart';
import '../../theme/aroma_colors.dart';

/// "All", "Women's", "Men's"... The selected one is a purple pill.
/// A null [selected] means "All".
class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Category? selected;
  final ValueChanged<Category?> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = <Category?>[null, ...Category.values];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 4),
        itemBuilder: (context, i) {
          final option = options[i];
          final active = option == selected;
          return GestureDetector(
            onTap: () => onChanged(option),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AromaColors.purple : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                option?.label ?? 'All',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? Colors.white : AromaColors.faint,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
