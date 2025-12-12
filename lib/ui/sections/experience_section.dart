import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Experience Section with Timeline
class ExperienceSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ExperienceSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);

    final experiences = [
      {
        'title': 'Senior Flutter Developer',
        'company': 'Tech Innovations Inc.',
        'duration': 'Jan 2023 - Present',
        'description':
            'Led mobile app development with Flutter, managed team of 3 developers, improved app performance by 40%.',
      },
      {
        'title': 'Flutter Developer',
        'company': 'Digital Solutions Ltd.',
        'duration': 'Jun 2021 - Dec 2022',
        'description':
            'Developed and maintained 10+ production apps, integrated Firebase and APIs, implemented state management.',
      },
      {
        'title': 'Junior Flutter Developer',
        'company': 'StartUp Studio',
        'duration': 'Jan 2021 - May 2021',
        'description':
            'Built mobile applications from scratch, learned best practices, collaborated with designers and backend teams.',
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
                  'Experience',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Timeline
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: experiences.length,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xxl,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: 40,
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                        ],
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    final exp = experiences[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline dot
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                            border: Border.all(
                              color: AppColors.bgPrimary,
                              width: 3,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xl),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exp['title']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                exp['company']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.accent1,
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                exp['duration']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                exp['description']!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
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
