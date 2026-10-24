import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/aroma/aroma_components.dart';
import '../data/products.dart';
import '../data/shop.dart';
import '../theme/aroma_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  /// Bottle sizes in ml and their price compared to the 100 ml bottle.
  static const _sizes = {50: 0.6, 100: 1.0, 150: 1.35};

  int _edition = 0;
  int _size = 100;
  int _quantity = 1;
  bool _liked = false;

  Product get _product => widget.product;
  int get _price => (_product.price * _sizes[_size]!).round();

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void _buy() {
    Shop.addToCart(_quantity);
    _showMessage('$_quantity × ${_product.name} ($_size ml) added to cart');
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AromaColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  children: [
                    _buildHeroCard(),
                    const SizedBox(height: 18),
                    _buildEditions(),
                    const SizedBox(height: 24),
                    _buildSizes(),
                    const SizedBox(height: 22),
                    _label('Description'),
                    const SizedBox(height: 6),
                    Text(
                      _product.description,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        height: 1.6,
                        color: AromaColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 12 + bottomInset),
                child: Row(
                  children: [
                    _buildQuantity(),
                    const SizedBox(width: 14),
                    Expanded(
                      child: PillButton(
                        label: 'Buy Product',
                        expand: true,
                        onTap: _buy,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AromaColors.purple,
            ),
          ),
          Expanded(
            child: Text(
              'Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AromaColors.ink,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Cart',
            onPressed: () => _showMessage('Cart coming soon'),
            icon: const IconTheme(
              data: IconThemeData(color: AromaColors.purple),
              child: CartIcon(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    final edition = _product.editions[_edition];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 420,
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 20),
      decoration: BoxDecoration(
        color: edition.tint,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _product.name,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: AromaColors.ink,
                  ),
                ),
                Text(
                  '\$$_price',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    color: AromaColors.ink,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'bottle-${_product.id}',
                      child: PerfumeBottle(
                        liquid: edition.liquid,
                        shape: _product.shape,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<Set<String>>(
                valueListenable: Shop.favourites,
                builder: (context, favourites, _) {
                  final saved = favourites.contains(_product.id);
                  return SquareIconButton(
                    icon: saved
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    tooltip: saved ? 'Remove from favourites' : 'Favourite',
                    onTap: () => Shop.toggleFavourite(_product.id),
                  );
                },
              ),
              const SizedBox(height: 14),
              SquareIconButton(
                icon: _liked
                    ? Icons.thumb_up_alt_rounded
                    : Icons.thumb_up_off_alt_rounded,
                tooltip: 'Like',
                onTap: () => setState(() => _liked = !_liked),
              ),
              const SizedBox(height: 14),
              SquareIconButton(
                icon: Icons.share_rounded,
                tooltip: 'Share',
                onTap: () => _showMessage('Share link copied'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditions() {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _product.editions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final edition = _product.editions[i];
          final active = i == _edition;
          return GestureDetector(
            onTap: () => setState(() => _edition = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 84,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: edition.tint,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active ? AromaColors.purple : Colors.transparent,
                  width: 2,
                ),
              ),
              child: PerfumeBottle(
                liquid: edition.liquid,
                shape: _product.shape,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSizes() {
    return Row(
      children: [
        _label('Size'),
        const SizedBox(width: 12),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final ml in _sizes.keys)
                GestureDetector(
                  onTap: () => setState(() => _size = ml),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: ml == _size
                          ? AromaColors.purple
                          : AromaColors.surface,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      '$ml ml',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ml == _size ? Colors.white : AromaColors.muted,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    Widget step(IconData icon, String tooltip, VoidCallback? onTap) {
      return IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        visualDensity: VisualDensity.compact,
        color: AromaColors.purple,
        disabledColor: AromaColors.faint,
        icon: Icon(icon, size: 20),
      );
    }

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AromaColors.surface,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Row(
        children: [
          step(
            Icons.remove_rounded,
            'Less',
            _quantity > 1 ? () => setState(() => _quantity--) : null,
          ),
          Text(
            '$_quantity',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AromaColors.ink,
            ),
          ),
          step(Icons.add_rounded, 'More', () => setState(() => _quantity++)),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AromaColors.ink,
      ),
    );
  }
}
