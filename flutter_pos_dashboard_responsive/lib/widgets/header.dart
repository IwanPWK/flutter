import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/colors.dart';
import 'package:flutter_pos_dashboard_responsive/responsive/responsive_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!ResponsiveLayout.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        if (!ResponsiveLayout.isMobile(context))
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        if (!ResponsiveLayout.isMobile(context))
          Spacer(flex: ResponsiveLayout.isDesktop(context) ? 2 : 1),
        const Expanded(child: SearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/profile_pic.png',
            height: 38,
          ),
          if (!ResponsiveLayout.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Angelina Jolie', style: TextStyle(color: Colors.white)),
            ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari...',
        hintStyle: const TextStyle(color: Colors.white70),
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ),
      ),
    );
  }
}
