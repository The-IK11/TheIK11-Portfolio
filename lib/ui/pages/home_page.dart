import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/ui/sections/about_section.dart';
import 'package:theik11_portfolio/ui/sections/contact_section.dart';
import 'package:theik11_portfolio/ui/sections/experience_section.dart';
import 'package:theik11_portfolio/ui/sections/hero_section.dart';
import 'package:theik11_portfolio/ui/sections/projects_section.dart';
import 'package:theik11_portfolio/ui/sections/services_section.dart';
import 'package:theik11_portfolio/ui/sections/skills_section.dart';
import 'package:theik11_portfolio/ui/sections/publications_section.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';
import 'package:theik11_portfolio/ui/widgets/navbar.dart';

/// Home Page with all sections
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  String _currentSection = 'home';
  bool _isScrollingToSection = false;
  
  // Global keys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _publicationsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateCurrentSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCurrentSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateCurrentSection() {
    // Skip automatic updates if we're in the middle of scrolling to a section
    if (_isScrollingToSection) {
      return;
    }

    // Define section positions
    final sections = [
      ('home', _heroKey),
      ('about', _aboutKey),
      ('skills', _skillsKey),
      ('experience', _experienceKey),
      ('projects', _projectsKey),
      ('services', _servicesKey),
      ('publications', _publicationsKey),
      ('contact', _contactKey),
    ];

    // Get the viewport height and scroll position
    final scrollPosition = _scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;
    // Get the center of the visible screen area (accounting for navbar at top)
    final screenCenter = scrollPosition + (viewportHeight / 2);

    // Find which section's center is closest to the screen center
    String closestSection = 'home';
    double closestDistance = double.infinity;

    for (final (sectionName, key) in sections) {
      final context = key.currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset offset = box.localToGlobal(Offset.zero);
        final sectionTop = offset.dy;
        final sectionHeight = box.size.height;
        final sectionCenter = sectionTop + (sectionHeight / 2);
        
        // Distance from screen center to section center
        final distance = (sectionCenter - screenCenter).abs();
        
        if (distance < closestDistance) {
          closestDistance = distance;
          closestSection = sectionName;
        }
      }
    }

    // Update the navbar if section changed
    if (_currentSection != closestSection) {
      setState(() => _currentSection = closestSection);
    }
  }

  void _scrollToSection(String sectionName) {
    GlobalKey? key;
    
    switch (sectionName) {
      case 'home':
        key = _heroKey;
        break;
      case 'about':
        key = _aboutKey;
        break;
      case 'skills':
        key = _skillsKey;
        break;
      case 'experience':
        key = _experienceKey;
        break;
      case 'projects':
        key = _projectsKey;
        break;
      case 'services':
        key = _servicesKey;
        break;
      case 'publications':
        key = _publicationsKey;
        break;
      case 'contact':
        key = _contactKey;
        break;
    }

    if (key != null && key.currentContext != null) {
      // Set flag to prevent automatic section detection during scroll
      _isScrollingToSection = true;
      
      // Update the current section immediately when clicking
      setState(() => _currentSection = sectionName);
      
      // Then scroll to the section
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        // Re-enable automatic detection after scroll completes
        _isScrollingToSection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCursorWidget(
      child: Scaffold(
        body: SpaceBackground(
          child: Stack(
            children: [
              // Main Content (scrollable)
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Add padding to account for fixed navbar
                    SizedBox(height: 60),
                    
                    // Hero Section
                    HeroSection(
                      sectionKey: _heroKey,
                      scrollController: _scrollController,
                    ),

                    // About Section
                    AboutSection(sectionKey: _aboutKey),

                    // Skills Section
                    SkillsSection(sectionKey: _skillsKey),

                    // Experience Section
                    ExperienceSection(sectionKey: _experienceKey),

                    // Projects Section
                    ProjectsSection(sectionKey: _projectsKey),

                    // Services Section
                    ServicesSection(sectionKey: _servicesKey),

                    // Publications & Open Source Section
                    PublicationsSection(sectionKey: _publicationsKey),

                    // Contact Section
                    ContactSection(sectionKey: _contactKey),

                    // Footer
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.containerPadding,
                        vertical: AppSpacing.xl,
                      ),
                      color: AppColors.bgSecondary,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 1,
                              color: AppColors.border.withOpacity(0.2),
                              margin: const EdgeInsets.only(
                                bottom: AppSpacing.xl,
                              ),
                            ),
                            Text(
                              '© 2024 MD. Ibrahim Khalil. All rights reserved.',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Built with Flutter ❤️',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.accent4,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Fixed Navigation Bar (on top)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NavBar(
                  onNavItemTapped: _scrollToSection,
                  scrollController: _scrollController,
                  currentSection: _currentSection,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
