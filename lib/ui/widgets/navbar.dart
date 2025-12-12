import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:theik11_portfolio/core/constants/app_constants.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final Function(String) onNavItemTapped;
  final ScrollController scrollController;
  final String currentSection;

  const NavBar({
    required this.onNavItemTapped,
    required this.scrollController,
    this.currentSection = 'home',
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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

    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.containerPadding,
            vertical: AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.bgPrimary.withOpacity(0.75),
            border: Border(
              bottom: BorderSide(
                color: AppColors.primary.withOpacity(0.3),
                width: 2,
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
                      final isSelected = widget.currentSection == item;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: MouseRegion(
                          onEnter: (_) {
                            // Hover effect - no state change needed
                          },
                          onExit: (_) {
                            // Exit hover
                          },
                          child: GestureDetector(
                            onTap: () {
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
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(
              children: [
                // Backdrop
                Container(color: Colors.transparent),
                // Drawer from left
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: ModalRoute.of(context)!.animation!,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {}, // Prevent closing when tapping drawer
                    child: Container(
                      width: 280,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: AppColors.bgPrimary.withOpacity(0.95),
                        border: Border(
                          right: BorderSide(
                            color: AppColors.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Header
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.lg,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppConstants.nickname,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.primary.withOpacity(0.1),
                          ),
                          // Menu Items
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: List.generate(
                                navItems.length,
                                (index) {
                                  final item = navItems[index];
                                  final label = navLabels[item] ?? item;
                                  final isSelected = widget.currentSection == item;

                                  return Container(
                                    color: isSelected
                                        ? AppColors.primary.withOpacity(0.1)
                                        : Colors.transparent,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: isSelected
                                            ? AppColors.primary
                                            : Colors.transparent,
                                      ),
                                      title: Text(
                                        label,
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        widget.onNavItemTapped(item);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Footer
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Text(
                              '© 2024 TheIK11',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
