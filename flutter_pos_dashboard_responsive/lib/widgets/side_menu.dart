import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
          DrawerListTile(
            title: 'Dashboard',
            svgSrc: 'assets/icons/menu_dashboard.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Transaksi',
            svgSrc: 'assets/icons/menu_tran.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Tugas',
            svgSrc: 'assets/icons/menu_task.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Dokumen',
            svgSrc: 'assets/icons/menu_doc.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Toko',
            svgSrc: 'assets/icons/menu_store.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Notifikasi',
            svgSrc: 'assets/icons/menu_notification.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Profil',
            svgSrc: 'assets/icons/menu_profile.svg',
            press: () {},
          ),
          DrawerListTile(
            title: 'Pengaturan',
            svgSrc: 'assets/icons/menu_setting.svg',
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
