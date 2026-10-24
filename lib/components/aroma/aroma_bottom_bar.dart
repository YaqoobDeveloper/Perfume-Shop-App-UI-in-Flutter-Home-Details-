import 'package:flutter/material.dart';

import '../../theme/aroma_colors.dart';
import 'cart_icon.dart';

/// White bottom bar: home, bag, a gap for the scan button, heart, profile.
/// The active tab sits in a purple circle.
class AromaBottomBar extends StatelessWidget {
  const AromaBottomBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 12 + bottomInset),
      decoration: const BoxDecoration(
        color: AromaColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AromaColors.shadow,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(0, const Icon(Icons.home_rounded), 'Home'),
          _item(1, const CartIcon(), 'Cart'),
          const SizedBox(width: 64),
          _item(2, const Icon(Icons.favorite_border_rounded), 'Favourites'),
          _item(3, const Icon(Icons.person_outline_rounded), 'Profile'),
        ],
      ),
    );
  }

  Widget _item(int index, Widget icon, String label) {
    final active = index == selected;
    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: active ? AromaColors.purple : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconTheme(
            data: IconThemeData(
              color: active ? Colors.white : AromaColors.faint,
              size: 24,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}
