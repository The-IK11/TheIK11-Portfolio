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
import 'package:theik11_portfolio/ui/sections/testimonials_section.dart';
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
  
  // Global keys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      case 'testimonials':
        key = _testimonialsKey;
        break;
      case 'contact':
        key = _contactKey;
        break;
    }

    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCursorWidget(
      child: Scaffold(
        body: SpaceBackground(
          child: Column(
            children: [
              // Navigation Bar
              NavBar(
                onNavItemTapped: _scrollToSection,
                scrollController: _scrollController,
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
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

                      // Testimonials Section
                      TestimonialsSection(sectionKey: _testimonialsKey),

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
