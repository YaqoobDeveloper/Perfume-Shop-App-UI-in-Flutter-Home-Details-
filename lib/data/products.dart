import 'package:flutter/material.dart';

import '../components/aroma/perfume_bottle.dart';

enum Category { women, men, kids, unisex }

extension CategoryLabel on Category {
  String get label => switch (this) {
    Category.women => "Women's",
    Category.men => "Men's",
    Category.kids => 'Kids',
    Category.unisex => 'Unisex',
  };
}

/// One colour of a perfume: the liquid and the card tint behind it.
class Edition {
  const Edition(this.liquid, this.tint);

  final Color liquid;
  final Color tint;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.shape,
    required this.editions,
    this.featured = false,
  });

  final String id;
  final String name;
  final String subtitle;
  final String description;

  /// Price of the 100 ml bottle, in dollars.
  final int price;
  final double rating;
  final Category category;
  final BottleShape shape;

  /// First edition is the one shown on the home screen.
  final List<Edition> editions;
  final bool featured;

  Edition get main => editions.first;
}

const _lavender = Edition(Color(0xFFA99BE0), Color(0xFFE9E2F7));
const _pink = Edition(Color(0xFFE0559A), Color(0xFFF7E1EE));
const _teal = Edition(Color(0xFF4FB3BF), Color(0xFFDDF3F5));
const _green = Edition(Color(0xFF8DBE7A), Color(0xFFE3F1DC));
const _amber = Edition(Color(0xFFF0B04F), Color(0xFFFBEFD9));
const _rose = Edition(Color(0xFFC04F7A), Color(0xFFF6E0EA));

const products = [
  Product(
    id: 'aromatic-allure',
    name: 'Aromatic Allure',
    subtitle: 'A Fruity Floral perfume for Women',
    description:
        'A soft bouquet of violet, pear and white musk that opens bright '
        'and settles into a warm, powdery trail. Made for long days that '
        'turn into evenings out.',
    price: 328,
    rating: 4.8,
    category: Category.women,
    shape: BottleShape.tapered,
    editions: [_lavender, _teal, _green, _pink],
    featured: true,
  ),
  Product(
    id: 'velvet-dreams',
    name: 'Velvet Dreams',
    subtitle: 'A Fruity Floral perfume for Women',
    description:
        'Raspberry, peony and a touch of vanilla wrapped in creamy '
        'sandalwood. Sweet, smooth and impossible to forget.',
    price: 382,
    rating: 4.7,
    category: Category.women,
    shape: BottleShape.square,
    editions: [_pink, _lavender, _rose],
  ),
  Product(
    id: 'ocean-breeze',
    name: 'Ocean Breeze',
    subtitle: 'A Fresh Aquatic perfume for Men',
    description:
        'Sea salt, bergamot and cedar for a clean, crisp scent that feels '
        'like the first cool wind off the water.',
    price: 296,
    rating: 4.6,
    category: Category.men,
    shape: BottleShape.classic,
    editions: [_teal, _green, _lavender],
    featured: true,
  ),
  Product(
    id: 'forest-whisper',
    name: 'Forest Whisper',
    subtitle: 'A Woody Green perfume for Everyone',
    description:
        'Fig leaf, vetiver and pine resin. Earthy and calm, like a walk '
        'through the woods after rain.',
    price: 314,
    rating: 4.5,
    category: Category.unisex,
    shape: BottleShape.square,
    editions: [_green, _teal, _amber],
    featured: true,
  ),
  Product(
    id: 'sunny-petals',
    name: 'Sunny Petals',
    subtitle: 'A Sweet Citrus splash for Kids',
    description:
        'A gentle, alcohol-free splash of orange blossom and soft peach. '
        'Light enough for little ones.',
    price: 148,
    rating: 4.9,
    category: Category.kids,
    shape: BottleShape.classic,
    editions: [_amber, _pink, _green],
  ),
  Product(
    id: 'rose-noir',
    name: 'Rose Noir',
    subtitle: 'A Deep Rose perfume for Women',
    description:
        'Dark Turkish rose, black pepper and patchouli. Bold and velvety, '
        'made for the night.',
    price: 356,
    rating: 4.7,
    category: Category.women,
    shape: BottleShape.tapered,
    editions: [_rose, _lavender, _pink],
  ),
];
