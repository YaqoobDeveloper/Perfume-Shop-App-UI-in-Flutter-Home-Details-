import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/aroma_colors.dart';
import 'perfume_bottle.dart';
import 'pill_button.dart';

/// "Buy 1 Get 1 Free" card with two bottles on a big purple circle.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key, required this.onShopNow});

  final VoidCallback onShopNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AromaColors.purpleLight,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            bottom: -70,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: AromaColors.purpleCircle,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            right: 104,
            bottom: 14,
            height: 82,
            child: PerfumeBottle(
              liquid: Color(0xFFA99BE0),
              shape: BottleShape.square,
            ),
          ),
          const Positioned(
            right: 14,
            bottom: 10,
            height: 136,
            child: PerfumeBottle(
              liquid: Color(0xFFA99BE0),
              shape: BottleShape.square,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buy 1\nGet 1 Free',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    color: AromaColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    text: 'Discount Up to ',
                    children: [
                      TextSpan(
                        text: '50%',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AromaColors.ink,
                  ),
                ),
                const Spacer(),
                PillButton(label: 'Shop Now', height: 38, onTap: onShopNow),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
