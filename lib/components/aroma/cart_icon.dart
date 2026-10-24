import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/shop.dart';
import '../../theme/aroma_colors.dart';

/// Shopping bag icon with a red count badge once the cart has items.
class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: Shop.cartCount,
      builder: (context, count, _) => Badge(
        isLabelVisible: count > 0,
        backgroundColor: AromaColors.badge,
        label: Text(
          '$count',
          style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600),
        ),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}
