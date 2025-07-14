class RecentSale {
  final String icon;
  final String name;
  final String date;
  final String amount;

  RecentSale({
    required this.icon,
    required this.name,
    required this.date,
    required this.amount,
  });
}

List<RecentSale> recentSales = [
  RecentSale(
    icon: 'assets/icons/xd_file.svg',
    name: 'Adobe XD',
    date: '01-03-2024',
    amount: 'Rp 250.000',
  ),
  RecentSale(
    icon: 'assets/icons/figma_file.svg',
    name: 'Figma',
    date: '27-02-2024',
    amount: 'Rp 150.000',
  ),
  RecentSale(
    icon: 'assets/icons/doc_file.svg',
    name: 'Document',
    date: '23-02-2024',
    amount: 'Rp 50.000',
  ),
  RecentSale(
    icon: 'assets/icons/sound_file.svg',
    name: 'Sound',
    date: '21-02-2024',
    amount: 'Rp 75.000',
  ),
  RecentSale(
    icon: 'assets/icons/media_file.svg',
    name: 'Media',
    date: '23-02-2024',
    amount: 'Rp 100.000',
  ),
];
