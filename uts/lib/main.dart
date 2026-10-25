import 'package:flutter/material.dart';

void main() => runApp(const LokaTripApp());

class Destination {
  final String name, location, category, description, price, duration;
  final double rating;
  final IconData icon;
  final Color color;
  final List<String> highlights;
  const Destination({required this.name, required this.location, required this.category, required this.description, required this.price, required this.duration, required this.rating, required this.icon, required this.color, required this.highlights});
}

const destinations = [
  Destination(name: 'Gunung Bromo', location: 'Jawa Timur', category: 'Alam', description: 'Nikmati matahari terbit yang ikonik, lautan pasir, dan panorama pegunungan yang menenangkan.', price: 'Mulai Rp185K', duration: '2 Hari 1 Malam', rating: 4.9, icon: Icons.landscape, color: Color(0xFFFFB86B), highlights: ['Sunrise Point', 'Lautan Pasir', 'Bukit Teletubbies']),
  Destination(name: 'Pantai Tiga Warna', location: 'Malang Selatan', category: 'Pantai', description: 'Pantai konservasi dengan gradasi air laut yang cantik dan suasana tropis yang masih alami.', price: 'Mulai Rp120K', duration: '1 Hari', rating: 4.8, icon: Icons.beach_access, color: Color(0xFF55C2B2), highlights: ['Snorkeling', 'Konservasi', 'Camping']),
  Destination(name: 'Kota Lama Semarang', location: 'Jawa Tengah', category: 'Budaya', description: 'Jelajahi bangunan kolonial, sudut foto klasik, dan kuliner khas di kawasan bersejarah.', price: 'Mulai Rp90K', duration: '1 Hari', rating: 4.7, icon: Icons.account_balance, color: Color(0xFF9A8CFF), highlights: ['Gereja Blenduk', 'Sewa Sepeda', 'Kuliner Lokal']),
  Destination(name: 'Danau Toba', location: 'Sumatera Utara', category: 'Danau', description: 'Temukan ketenangan dan budaya Batak di tepian danau vulkanik terbesar di Asia Tenggara.', price: 'Mulai Rp650K', duration: '3 Hari 2 Malam', rating: 4.9, icon: Icons.water, color: Color(0xFF5C9DFF), highlights: ['Pulau Samosir', 'Budaya Batak', 'Pemandangan']),
];

class LokaTripApp extends StatelessWidget {
  const LokaTripApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'LokaTrip',
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: const Color(0xFFF7F8FC), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B55D9))),
    home: const MainShell(),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;
  final pages = const [HomePage(), ExplorePage(), SavedPage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: selectedIndex, children: pages),
    bottomNavigationBar: NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) => setState(() => selectedIndex = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
        NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Eksplorasi'),
        NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Tersimpan'),
      ],
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        const Text('Selamat datang,', style: TextStyle(color: Color(0xFF7C8497))),
        const SizedBox(height: 4),
        const Text('Ghazy 👋', style: TextStyle(color: Color(0xFF17243A), fontWeight: FontWeight.w800, fontSize: 24)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF5B55D9), Color(0xFF817BEE)]), borderRadius: BorderRadius.circular(24)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Temukan tempat\nuntuk pulang.', style: TextStyle(color: Colors.white, fontSize: 27, height: 1.15, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Text('Rencana perjalanan lokal yang lebih bermakna.', style: TextStyle(color: Colors.white.withValues(alpha: .8))),
            const SizedBox(height: 18),
            FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.search), label: const Text('Mulai eksplorasi'), style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF5B55D9))),
          ]),
        ),
        const SizedBox(height: 28),
        const Text('Kategori pilihan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
        const SizedBox(height: 14),
        SizedBox(height: 105, child: ListView(scrollDirection: Axis.horizontal, children: const [CategoryTile(icon: Icons.landscape, label: 'Alam', color: Color(0xFFFFB86B)), CategoryTile(icon: Icons.beach_access, label: 'Pantai', color: Color(0xFF55C2B2)), CategoryTile(icon: Icons.account_balance, label: 'Budaya', color: Color(0xFF9A8CFF)), CategoryTile(icon: Icons.restaurant, label: 'Kuliner', color: Color(0xFFFF8D9B))])),
        const SizedBox(height: 26),
        const Text('Rekomendasi untukmu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
        const SizedBox(height: 14),
        DestinationCard(destination: destinations[0]),
        const SizedBox(height: 12),
        DestinationCard(destination: destinations[1]),
      ],
    ),
  );
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override State<ExplorePage> createState() => _ExplorePageState();
}
class _ExplorePageState extends State<ExplorePage> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = destinations.where((d) => '${d.name} ${d.location} ${d.category}'.toLowerCase().contains(query.toLowerCase())).toList();
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(20, 18, 20, 24), children: [
      const Text('Eksplorasi', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
      const SizedBox(height: 6),
      const Text('Cari inspirasi perjalanan berikutnya.', style: TextStyle(color: Color(0xFF7C8497))),
      const SizedBox(height: 20),
      TextField(onChanged: (v) => setState(() => query = v), decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Cari destinasi atau kota', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))),
      const SizedBox(height: 22),
      ...filtered.map((d) => Padding(padding: const EdgeInsets.only(bottom: 12), child: DestinationCard(destination: d))),
      if (filtered.isEmpty) const Padding(padding: EdgeInsets.all(32), child: Center(child: Text('Destinasi tidak ditemukan.'))),
    ]));
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(20, 18, 20, 24), children: [
    const Text('Tersimpan', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
    const SizedBox(height: 6),
    const Text('Koleksi tempat yang ingin kamu kunjungi.', style: TextStyle(color: Color(0xFF7C8497))),
    const SizedBox(height: 24),
    Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)), child: const Column(children: [Icon(Icons.bookmark_border, size: 58, color: Color(0xFF9A8CFF)), SizedBox(height: 14), Text('Belum ada koleksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), SizedBox(height: 6), Text('Simpan destinasi favoritmu dari halaman eksplorasi.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF7C8497)))])),
  ]));
}

class CategoryTile extends StatelessWidget {
  final IconData icon; final String label; final Color color;
  const CategoryTile({super.key, required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(width: 78, margin: const EdgeInsets.only(right: 12), child: Column(children: [Container(width: 58, height: 58, decoration: BoxDecoration(color: color.withValues(alpha: .2), borderRadius: BorderRadius.circular(18)), child: Icon(icon, color: color)), const SizedBox(height: 7), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))]));
}

class DestinationCard extends StatelessWidget {
  final Destination destination;
  const DestinationCard({super.key, required this.destination});
  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(destination: destination))),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        Container(width: 92, height: 92, decoration: BoxDecoration(color: destination.color.withValues(alpha: .22), borderRadius: BorderRadius.circular(16)), child: Icon(destination.icon, size: 42, color: destination.color)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(destination.category.toUpperCase(), style: TextStyle(color: destination.color, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
          const SizedBox(height: 5),
          Text(destination.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
          const SizedBox(height: 5),
          Row(children: [const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF7C8497)), const SizedBox(width: 3), Text(destination.location, style: const TextStyle(color: Color(0xFF7C8497), fontSize: 12)), const Spacer(), const Icon(Icons.star, size: 15, color: Color(0xFFFFB84D)), const SizedBox(width: 3), Text('${destination.rating}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))]),
        ])),
      ]),
    ),
  );
}

class DetailPage extends StatelessWidget {
  final Destination destination;
  const DetailPage({super.key, required this.destination});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detail destinasi', style: TextStyle(fontWeight: FontWeight.w700))),
    body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 30), children: [
      Container(height: 220, decoration: BoxDecoration(color: destination.color.withValues(alpha: .25), borderRadius: BorderRadius.circular(26)), child: Icon(destination.icon, size: 110, color: destination.color)),
      const SizedBox(height: 22),
      Text(destination.category.toUpperCase(), style: TextStyle(color: destination.color, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
      const SizedBox(height: 6),
      Text(destination.name, style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
      const SizedBox(height: 8),
      Row(children: [const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF7C8497)), const SizedBox(width: 4), Text(destination.location, style: const TextStyle(color: Color(0xFF7C8497))), const Spacer(), const Icon(Icons.star, color: Color(0xFFFFB84D)), Text('${destination.rating}', style: const TextStyle(fontWeight: FontWeight.w800))]),
      const SizedBox(height: 22),
      Text(destination.description, style: const TextStyle(color: Color(0xFF596275), height: 1.6)),
      const SizedBox(height: 24),
      const Text('Yang akan kamu dapatkan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
      const SizedBox(height: 12),
      ...destination.highlights.map((item) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [const Icon(Icons.check_circle, color: Color(0xFF55C2B2), size: 20), const SizedBox(width: 10), Text(item, style: const TextStyle(color: Color(0xFF596275)))]))),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: const Color(0xFFEDEBFF), borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          const Icon(Icons.schedule, color: Color(0xFF5B55D9)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Durasi perjalanan', style: TextStyle(color: Color(0xFF7C8497), fontSize: 12)),
            Text(destination.duration, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF17243A))),
          ]),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text('Estimasi biaya', style: TextStyle(color: Color(0xFF7C8497), fontSize: 12)),
            Text(destination.price, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF5B55D9))),
          ]),
        ]),
      ),
    ]),
  );
}
