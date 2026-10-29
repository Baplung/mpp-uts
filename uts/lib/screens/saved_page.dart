import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import 'detail_page.dart';

class SavedPage extends StatelessWidget {
  final Set<String> savedIds;
  final void Function(String) onToggleSaved;
  final bool Function(String) isSaved;

  const SavedPage({
    super.key,
    required this.savedIds,
    required this.onToggleSaved,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    final savedDestinations = allDestinations
        .where((d) => savedIds.contains(d.id))
        .toList();

    return SafeArea(
      child: savedDestinations.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 72,
                    color: const Color(0xFF787587).withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada yang disimpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111C2D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ketuk ikon bookmark pada destinasi\nuntuk menyimpannya di sini',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Color(0xFF787587)),
                  ),
                ],
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tersimpan',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111C2D),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${savedDestinations.length} destinasi disimpan',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF474555),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final dest = savedDestinations[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DestinationCard(
                          destination: dest,
                          isSaved: true,
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
                    }, childCount: savedDestinations.length),
                  ),
                ),
              ],
            ),
    );
  }
}
