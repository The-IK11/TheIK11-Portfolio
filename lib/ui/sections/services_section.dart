import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Services Section
class ServicesSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ServicesSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.getMaxContentWidth(context);

    final services = [
      {
        'title': 'Mobile App Development',
        'description':
            'Building cross-platform mobile apps using Flutter and Dart, with feature-first development and state management using GetX, Provider, and BLoC following clean architecture principles.',
        'image': 'assets/images/mobile_app_development.jpg',
      },
      {
        'title': 'UI/UX Design',
        'description': 'Translating Figma designs into pixel-perfect Flutter interfaces, focusing on clean layouts, smooth interactions, and practical UI logic.',
        'image': 'assets/images/ui:ux_design.jpg',
      },
      {
        'title': 'API Integration',
        'description': 'Integrating REST APIs built with Laravel, MERN, and Django, along with Firebase-based backends for personal and cloud-powered applications.',
        'image': 'assets/images/api_integration.jpg',
      },
      {
        'title': 'Flutter Web Apps',
        'description': 'Integrating REST APIs built with Laravel, MERN, and Django, along with Firebase-based backends for personal and cloud-powered applications.',
        'image': 'assets/images/web_app.jpg',
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
                  'Services',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Services Grid
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : (Responsive.isTablet(context) ? 3 : 4),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _ServiceCard(
                      title: service['title'] as String,
                      description: service['description'] as String,
                      image: service['image'] as String,
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

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
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
        animation: _controller,
        builder: (context, child) {
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.03 * (1 - _controller.value))
            ..translate(0.0, -10 * _controller.value);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
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
                  // Image Section - Centered
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: AppColors.bgTertiary,
                      child: Image.asset(
                        widget.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.textTertiary,
                              size: 50,
                            ),
                          );
                        },
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
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          // Description
                          Expanded(
                            child: Text(
                              widget.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                              ),
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
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
