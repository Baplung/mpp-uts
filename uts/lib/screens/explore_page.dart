import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';
import 'detail_page.dart';

class ExplorePage extends StatefulWidget {
  final void Function(String) onToggleSaved;
  final bool Function(String) isSaved;

  const ExplorePage({
    super.key,
    required this.onToggleSaved,
    required this.isSaved,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _selectedFilter = 'Semua';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  static const _filters = ['Semua', 'Alam', 'Pantai', 'Budaya', 'Kuliner'];

  List<Destination> get _filteredDestinations {
    var list = allDestinations;
    if (_selectedFilter != 'Semua') {
      list = list.where((d) => d.category == _selectedFilter).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list
          .where(
            (d) =>
                d.fullName.toLowerCase().contains(q) ||
                d.location.toLowerCase().contains(q) ||
                d.category.toLowerCase().contains(q),
          )
          .toList();
    }
    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _filteredDestinations;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Eksplorasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111C2D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Cari destinasi...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF787587),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF787587),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Filter chips
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (context2, index2) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final filter = _filters[index];
                        final isSelected = _selectedFilter == filter;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedFilter = filter),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF5B46E8)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? null
                                  : Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF474555),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (destinations.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: Color(0xFF787587),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Tidak ada destinasi ditemukan',
                      style: TextStyle(fontSize: 14, color: Color(0xFF787587)),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final dest = destinations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DestinationCard(
                      destination: dest,
                      isSaved: widget.isSaved(dest.id),
                      onToggleSaved: () => widget.onToggleSaved(dest.id),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              destination: dest,
                              isSaved: widget.isSaved(dest.id),
                              onToggleSaved: () =>
                                  widget.onToggleSaved(dest.id),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }, childCount: destinations.length),
              ),
            ),
        ],
      ),
    );
  }
}
