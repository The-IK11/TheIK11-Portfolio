import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_constants.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final Function(String) onNavItemTapped;
  final ScrollController scrollController;

  const NavBar({
    required this.onNavItemTapped,
    required this.scrollController,
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String _selectedItem = 'home';

  static const List<String> navItems = [
    'home',
    'about',
    'skills',
    'experience',
    'projects',
    'services',
    'testimonials',
    'contact',
  ];

  static const Map<String, String> navLabels = {
    'home': 'Home',
    'about': 'About',
    'skills': 'Skills',
    'experience': 'Experience',
    'projects': 'Projects',
    'services': 'Services',
    'testimonials': 'Testimonials',
    'contact': 'Contact',
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.containerPadding,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.border.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Name
          GestureDetector(
            onTap: () => widget.onNavItemTapped('home'),
            child: Text(
              AppConstants.nickname,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
              ),
            ),
          ),
          
          // Desktop Navigation
          if (!isMobile)
            Row(
              children: List.generate(
                navItems.length,
                (index) {
                  final item = navItems[index];
                  final label = navLabels[item] ?? item;
                  final isSelected = _selectedItem == item;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() => _selectedItem = item);
                      },
                      onExit: (_) {
                        setState(() => _selectedItem = _selectedItem);
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedItem = item);
                          widget.onNavItemTapped(item);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              label,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Container(
                                  height: 2,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            // Mobile Menu Button
            IconButton(
              onPressed: () => _showMobileMenu(context),
              icon: const Icon(Icons.menu, color: AppColors.primary),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: List.generate(
            navItems.length,
            (index) {
              final item = navItems[index];
              final label = navLabels[item] ?? item;

              return ListTile(
                title: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectedItem = item);
                  widget.onNavItemTapped(item);
                },
              );
            },
          ),
        );
      },
    );
  }
}
