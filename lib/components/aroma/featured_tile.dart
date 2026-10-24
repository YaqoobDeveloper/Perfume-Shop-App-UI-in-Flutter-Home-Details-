import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/products.dart';
import '../../theme/aroma_colors.dart';
import 'perfume_bottle.dart';

/// Wide row card for the "Featured" list: bottle, name, rating and price.
class FeaturedTile extends StatelessWidget {
  const FeaturedTile({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AromaColors.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: AromaColors.shadow,
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 80,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: product.main.tint,
                borderRadius: BorderRadius.circular(16),
              ),
              child: PerfumeBottle(
                liquid: product.main.liquid,
                shape: product.shape,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AromaColors.ink,
                    ),
                  ),
                  Text(
                    product.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AromaColors.muted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Color(0xFFF5B83D),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AromaColors.ink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '\$${product.price}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AromaColors.purple,
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
