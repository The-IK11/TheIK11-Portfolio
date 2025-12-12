import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Projects Section
class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.getMaxContentWidth(context);

    final projects = [
      {
        'title': 'E-Commerce App',
        'description': 'Full-featured e-commerce app with Firebase backend',
        'image': Icons.shopping_bag,
        'tags': ['Flutter', 'Firebase', 'Payment Gateway'],
        'github': 'https://github.com',
        'playstore': 'https://play.google.com',
      },
      {
        'title': 'Social Media App',
        'description': 'Real-time chat and social features',
        'image': Icons.people,
        'tags': ['Flutter', 'Firebase', 'Real-time DB'],
        'github': 'https://github.com',
      },
      {
        'title': 'Task Management App',
        'description': 'Productivity app with cloud sync',
        'image': Icons.task,
        'tags': ['Flutter', 'Supabase', 'Local Storage'],
        'github': 'https://github.com',
      },
      {
        'title': 'Weather App',
        'description': 'Real-time weather with beautiful UI',
        'image': Icons.cloud,
        'tags': ['Flutter', 'REST API', 'UI/UX'],
        'github': 'https://github.com',
        'playstore': 'https://play.google.com',
      },
      {
        'title': 'Fitness Tracker',
        'description': 'Track workouts and health metrics',
        'image': Icons.fitness_center,
        'tags': ['Flutter', 'SQLite', 'Charts'],
        'github': 'https://github.com',
      },
      {
        'title': 'Portfolio Website',
        'description': 'Modern portfolio built with Flutter Web',
        'image': Icons.language,
        'tags': ['Flutter Web', 'Firebase', 'Responsive'],
        'github': 'https://github.com',
      },
    ];

    return Container(
      key: sectionKey,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.containerPadding,
        vertical: AppSpacing.sectionPadding,
      ),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              FadeInAnimation(
                child: Text(
                  'Featured Projects',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Projects Grid
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 2,
                    crossAxisSpacing: AppSpacing.xl,
                    mainAxisSpacing: AppSpacing.xl,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return _ProjectCard(
                      title: project['title'] as String,
                      description: project['description'] as String,
                      icon: project['image'] as IconData,
                      tags: List<String>.from(project['tags'] as List),
                      github: project['github'] as String,
                      playstore: project['playstore'] as String?,
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> tags;
  final String github;
  final String? playstore;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.tags,
    required this.github,
    this.playstore,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _elevationAnimation = Tween<double>(begin: 2.0, end: 12.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _elevationAnimation,
        builder: (context, child) {
          return Card(
            elevation: _elevationAnimation.value,
            color: AppColors.bgSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.border.withOpacity(0.3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Title
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Description
                  Expanded(
                    child: Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Tags
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: widget.tags
                        .take(2)
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Links
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            // TODO: Open GitHub
                          },
                          icon: const Icon(Icons.code),
                          label: const Text('Code'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                      if (widget.playstore != null)
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () {
                              // TODO: Open Play Store
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('App'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.accent2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
