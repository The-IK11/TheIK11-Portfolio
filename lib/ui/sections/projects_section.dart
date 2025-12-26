import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Project Data Model
class ProjectItem {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final String github;
  final String? playstore;

  ProjectItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.github,
    this.playstore,
  });
}

/// Projects Section
class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.getMaxContentWidth(context);

    final projects = [
      ProjectItem(
        title: 'E-Commerce App',
        description: 'Full-featured e-commerce with Firebase',
        imageUrl: 'https://via.placeholder.com/400x250/FF6B6B/FFFFFF?text=E-Commerce',
        tags: ['Flutter', 'Firebase'],
        github: 'https://github.com',
        playstore: 'https://play.google.com',
      ),
      ProjectItem(
        title: 'Social Media App',
        description: 'Real-time chat and social features',
        imageUrl: 'https://via.placeholder.com/400x250/4ECDC4/FFFFFF?text=Social+Media',
        tags: ['Flutter', 'Firebase'],
        github: 'https://github.com',
      ),
      ProjectItem(
        title: 'Task Management',
        description: 'Productivity app with cloud sync',
        imageUrl: 'https://via.placeholder.com/400x250/45B7D1/FFFFFF?text=Task+Manager',
        tags: ['Flutter', 'Supabase'],
        github: 'https://github.com',
      ),
      ProjectItem(
        title: 'Weather App',
        description: 'Real-time weather with beautiful UI',
        imageUrl: 'https://via.placeholder.com/400x250/96CEB4/FFFFFF?text=Weather',
        tags: ['Flutter', 'REST API'],
        github: 'https://github.com',
        playstore: 'https://play.google.com',
      ),
      ProjectItem(
        title: 'Fitness Tracker',
        description: 'Track workouts and health metrics',
        imageUrl: 'https://via.placeholder.com/400x250/FFEAA7/FFFFFF?text=Fitness',
        tags: ['Flutter', 'SQLite'],
        github: 'https://github.com',
      ),
      ProjectItem(
        title: 'Portfolio Website',
        description: 'Modern portfolio with Flutter Web',
        imageUrl: 'https://via.placeholder.com/400x250/DDA15E/FFFFFF?text=Portfolio',
        tags: ['Flutter Web', 'Firebase'],
        github: 'https://github.com',
      ),
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
                    crossAxisCount: isMobile ? 2 : (Responsive.isTablet(context) ? 3 : 4),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return _ProjectCard(project: projects[index]);
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

/// Project Card Widget
class _ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.02))
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.border.withOpacity(0.3),
                width: 0.8,
              ),
              color: AppColors.bgSecondary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section - Centered in space
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.bgTertiary,
                    child: Center(
                      child: Image.network(
                        widget.project.imageUrl,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported,
                            color: AppColors.textTertiary,
                            size: 40,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.primary.withOpacity(0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Divider
                Container(
                  height: 0.8,
                  color: AppColors.border.withOpacity(0.2),
                ),

                // Content Section
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.project.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),

                        // Description
                        Expanded(
                          child: Text(
                            widget.project.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Tags
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: widget.project.tags
                              .take(2)
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.12),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.4),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),

                        // Links
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  // TODO: Open GitHub
                                },
                                icon: const Icon(Icons.code, size: 12),
                                label: const Text('Code'),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                            if (widget.project.playstore != null)
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () {
                                    // TODO: Open Play Store
                                  },
                                  icon: const Icon(Icons.play_arrow, size: 12),
                                  label: const Text('App'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.accent2,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

