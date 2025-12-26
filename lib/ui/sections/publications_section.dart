import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

/// Publications & Open Source Section
class PublicationsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const PublicationsSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.getMaxContentWidth(context);

    final publications = [
      PublicationItem(
        title: 'Building Scalable Flutter Apps',
        description: 'A comprehensive guide to architectural patterns and best practices.',
        date: 'Mar 2025',
        imageUrl: 'assets/images/publication_flutter.jpg',
        link: 'https://medium.com/@theik11/flutter-scalable',
        type: 'Article',
        tag: 'Article',
      ),
      PublicationItem(
        title: 'Payment Methods UI Kit',
        description: 'Reusable Flutter package for multiple payment method implementations.',
        date: 'Feb 2025',
        imageUrl: 'assets/images/publication_payments.jpg',
        link: 'https://pub.dev/packages/payment_methods_ui',
        type: 'Package',
        tag: 'Package',
      ),
      PublicationItem(
        title: 'GitHub Wrapped Generator',
        description: 'Open-source project to create GitHub Wrapped-style yearly summaries.',
        date: 'Jan 2025',
        imageUrl: 'assets/images/publication_github_wrapped.jpg',
        link: 'https://github.com/theik11/github-wrapped',
        type: 'Open Source',
        tag: 'Open Source',
      ),
      PublicationItem(
        title: 'Advanced State Management',
        description: 'Deep dive into Riverpod patterns and performance optimization techniques.',
        date: 'Dec 2024',
        imageUrl: 'assets/images/publication_riverpod.jpg',
        link: 'https://dev.to/theik11/riverpod-patterns',
        type: 'Article',
        tag: 'Article',
      ),
      PublicationItem(
        title: 'Firebase Real-time Database',
        description: 'Flutter package for simplified Firebase Realtime Database integration.',
        date: 'Nov 2024',
        imageUrl: 'assets/images/publication_firebase.jpg',
        link: 'https://pub.dev/packages/firebase_realtime',
        type: 'Package',
        tag: 'Package',
      ),
      PublicationItem(
        title: 'Experimental UI Components',
        description: 'Learning project exploring cutting-edge Flutter animation techniques.',
        date: 'Oct 2024',
        imageUrl: 'assets/images/publication_experimental.jpg',
        link: 'https://github.com/theik11/experimental-ui',
        type: 'Open Source',
        tag: 'Open Source',
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
                  'Publications & Open Source',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Publications Grid
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3),
                    crossAxisSpacing: AppSpacing.xl,
                    mainAxisSpacing: AppSpacing.xl,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: publications.length,
                  itemBuilder: (context, index) {
                    return _PublicationCard(
                      publication: publications[index],
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

/// Publication Data Model
class PublicationItem {
  final String title;
  final String description;
  final String date;
  final String imageUrl;
  final String link;
  final String type;
  final String tag;

  PublicationItem({
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.link,
    required this.type,
    required this.tag,
  });
}

/// Publication Card Widget
class _PublicationCard extends StatefulWidget {
  final PublicationItem publication;

  const _PublicationCard({
    required this.publication,
  });

  @override
  State<_PublicationCard> createState() => _PublicationCardState();
}

class _PublicationCardState extends State<_PublicationCard>
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
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

  void _openLink() async {
    final Uri url = Uri.parse(widget.publication.link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
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
          child: GestureDetector(
            onTap: _openLink,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.border.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover Image
                    Container(
                      height: 160,
                      width: double.infinity,
                      color: AppColors.bgSecondary,
                      child: Stack(
                        children: [
                          // Image or placeholder
                          Container(
                            color: AppColors.bgTertiary,
                            child: Center(
                              child: Icon(
                                _getIconForType(widget.publication.type),
                                size: 48,
                                color: AppColors.primary.withOpacity(0.3),
                              ),
                            ),
                          ),
                          // Tag Badge
                          Positioned(
                            top: AppSpacing.md,
                            right: AppSpacing.md,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getColorForType(widget.publication.type),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.publication.tag,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Card Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              widget.publication.title,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            // Description
                            Expanded(
                              child: Text(
                                widget.publication.description,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // Date
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              widget.publication.date,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Card Footer - Click Indicator
                    Container(
                      height: 1,
                      color: AppColors.border.withOpacity(0.2),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.sm,
                      ),
                      color: AppColors.bgSecondary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'View',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_outward_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'article':
        return Icons.article;
      case 'package':
        return Icons.extension;
      case 'open source':
        return Icons.code;
      default:
        return Icons.folder;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'article':
        return const Color(0xFF4CAF50); // Green
      case 'package':
        return const Color(0xFF2196F3); // Blue
      case 'open source':
        return const Color(0xFF9C27B0); // Purple
      default:
        return AppColors.primary;
    }
  }
}
