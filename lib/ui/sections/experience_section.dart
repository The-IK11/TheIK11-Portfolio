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
        'title': 'Junior Flutter Developer',
        'company': 'Softvence Agency',
        'duration': '13th December 2024 - Running',
        'description':
            'Working as a Junior Flutter Developer, contributing to mobile application development projects using Flutter and Dart. Building scalable and performant applications.',
      },
      {
        'title': 'Intern with Flutter Developer',
        'company': 'Universe IT',
        'duration': '1st July 2024 - 10th December 2024',
        'description':
            'Completed internship program focused on Flutter development. Gained hands-on experience with mobile app development, learned best practices, and collaborated with the development team on multiple projects.',
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
