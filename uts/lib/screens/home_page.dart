import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../widgets/category_tile.dart';
import '../widgets/destination_card.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final void Function(String) onToggleSaved;
  final bool Function(String) isSaved;

  const HomePage({
    super.key,
    required this.onToggleSaved,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          pinned: true,
          floating: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 64,
          backgroundColor: const Color(0xFFF9F9FF).withValues(alpha: 0.8),
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.transparent),
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.travel_explore,
                color: const Color(0xFF5B46E8),
                size: 28,
              ),
              const SizedBox(width: 8),
              const Text(
                'LokaTrip',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111C2D),
                ),
              ),
            ],
          ),
          actions: [
            const Text(
              'Beranda',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF474555),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE4DFFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4225D0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),

        // Body content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Greeting section
                _buildGreetingSection(),

                const SizedBox(height: 20),

                // Hero banner
                _buildHeroBanner(),

                const SizedBox(height: 28),

                // Categories
                _buildCategoryHeader(),
              ],
            ),
          ),
        ),

        // Category tiles (horizontal scroll)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                CategoryTile(
                  icon: Icons.forest_rounded,
                  label: 'Alam',
                  subtitle: 'Gunung & Hutan',
                  color: Color(0xFF6FFBBE),
                ),
                SizedBox(width: 12),
                CategoryTile(
                  icon: Icons.beach_access_rounded,
                  label: 'Pantai',
                  subtitle: 'Bahari & Pulau',
                  color: Color(0xFFDEE8FF),
                ),
                SizedBox(width: 12),
                CategoryTile(
                  icon: Icons.account_balance_rounded,
                  label: 'Budaya',
                  subtitle: 'Candi & Adat',
                  color: Color(0xFFFFDDB8),
                ),
                SizedBox(width: 12),
                CategoryTile(
                  icon: Icons.restaurant_rounded,
                  label: 'Kuliner',
                  subtitle: 'Otentik Lokal',
                  color: Color(0xFFFFDAD6),
                ),
              ],
            ),
          ),
        ),

        // Recommendation header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Rekomendasi untukmu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111C2D),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Paling banyak dikunjungi minggu ini',
                  style: TextStyle(fontSize: 12, color: Color(0xFF474555)),
                ),
              ],
            ),
          ),
        ),

        // Destination cards
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final dest = allDestinations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DestinationCard(
                  destination: dest,
                  isSaved: isSaved(dest.id),
                  onToggleSaved: () => onToggleSaved(dest.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          destination: dest,
                          isSaved: isSaved(dest.id),
                          onToggleSaved: () => onToggleSaved(dest.id),
                        ),
                      ),
                    );
                  },
                ),
              );
            }, childCount: allDestinations.length),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Halo, selamat pagi 👋',
                style: TextStyle(fontSize: 12, color: Color(0xFF474555)),
              ),
              SizedBox(height: 4),
              Text(
                'Selamat datang, Ghazy',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111C2D),
                ),
              ),
            ],
          ),
        ),
        // Notification bell
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 22,
                  color: Color(0xFF474555),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFE4DFFF),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'G',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4225D0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/bromo_dashboard.jpg', fit: BoxFit.cover),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Pill tag
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Inspirasi Akhir Pekan',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Temukan tempat\nuntuk pulang',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Eksplorasi destinasi lokal favoritmu',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5B46E8),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mulai eksplorasi',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Kategori pilihan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111C2D),
          ),
        ),
        Text(
          'Lihat Semua',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF4225D0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
