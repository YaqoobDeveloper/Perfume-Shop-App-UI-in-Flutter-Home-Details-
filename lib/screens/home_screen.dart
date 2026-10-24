import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/aroma/aroma_components.dart';
import '../data/products.dart';
import '../data/shop.dart';
import '../theme/aroma_colors.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  Category? _category;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _visible {
    final q = _query.trim().toLowerCase();
    return products
        .where((p) => _category == null || p.category == _category)
        .where((p) => q.isEmpty || p.name.toLowerCase().contains(q))
        .toList();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void _open(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailsScreen(product: product),
      ),
    );
  }

  void _add(Product product) {
    Shop.addToCart();
    _showMessage('${product.name} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AromaColors.background,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildTop()),
              _buildGrid(),
              SliverToBoxAdapter(child: _buildFeatured()),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 66,
          height: 66,
          child: FloatingActionButton(
            onPressed: () => _showMessage('Scan a bottle to find it'),
            tooltip: 'Scan',
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: AromaColors.purple,
            foregroundColor: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(color: AromaColors.surface, width: 5),
            ),
            child: const Icon(Icons.qr_code_scanner_rounded, size: 28),
          ),
        ),
        bottomNavigationBar: AromaBottomBar(
          selected: 0,
          onChanged: (i) {
            if (i != 0) {
              final tab = ['', 'Cart', 'Favourites', 'Profile'][i];
              _showMessage('$tab coming soon');
            }
          },
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: const [
                        TextSpan(text: 'ar'),
                        TextSpan(
                          text: 'o',
                          style: TextStyle(color: AromaColors.purple),
                        ),
                        TextSpan(text: 'ma'),
                      ],
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                      color: AromaColors.ink,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Notifications',
                    onPressed: () => _showMessage('No new notifications'),
                    icon: const Badge(
                      smallSize: 8,
                      backgroundColor: AromaColors.badge,
                      child: Icon(
                        Icons.notifications_rounded,
                        color: AromaColors.purple,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AromaSearchBar(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
              ),
              const SizedBox(height: 20),
              PromoBanner(
                onShopNow: () => _showMessage('Offer applied at checkout'),
              ),
              const SizedBox(height: 22),
              _sectionTitle('Explore by Category'),
              const SizedBox(height: 12),
            ],
          ),
        ),
        CategoryChips(
          selected: _category,
          onChanged: (c) => setState(() => _category = c),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGrid() {
    final visible = _visible;
    if (visible.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            'No perfumes found',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: AromaColors.muted),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid.builder(
        itemCount: visible.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: 268,
        ),
        itemBuilder: (context, i) => ProductCard(
          product: visible[i],
          onTap: () => _open(visible[i]),
          onAdd: () => _add(visible[i]),
        ),
      ),
    );
  }

  Widget _buildFeatured() {
    final featured = products.where((p) => p.featured);
    return Padding(
      // Leaves room for the bottom bar and the scan button above it.
      padding: EdgeInsets.fromLTRB(
        20,
        26,
        20,
        120 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle('Featured'),
          const SizedBox(height: 12),
          for (final p in featured) ...[
            FeaturedTile(product: p, onTap: () => _open(p)),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AromaColors.ink,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _category = null;
            _query = '';
            _searchController.clear();
          }),
          child: Text(
            'See all',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AromaColors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
