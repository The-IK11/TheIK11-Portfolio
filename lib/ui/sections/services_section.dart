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
            'Native and cross-platform mobile apps using Flutter with Firebase integration',
        'icon': Icons.phone_android,
      },
      {
        'title': 'UI/UX Design',
        'description': 'Beautiful and intuitive user interface design following material design',
        'icon': Icons.palette,
      },
      {
        'title': 'API Integration',
        'description': 'Seamless integration with REST APIs, Firebase, and cloud services',
        'icon': Icons.api,
      },
      {
        'title': 'Flutter Web Apps',
        'description': 'Responsive web applications built with Flutter for all devices',
        'icon': Icons.language,
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
                    crossAxisCount: isMobile ? 1 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _ServiceCard(
                      title: service['title'] as String,
                      description: service['description'] as String,
                      icon: service['icon'] as IconData,
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
  final IconData icon;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.icon,
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
            child: Card(
              color: AppColors.bgSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Color.lerp(
                    AppColors.border.withOpacity(0.3),
                    AppColors.primary.withOpacity(0.5),
                    _controller.value,
                  )!,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Expanded(
                      child: Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
