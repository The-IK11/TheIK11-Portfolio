import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_constants.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Skills Section
class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const SkillsSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);

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
                  'Skills & Expertise',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Skills Grid
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: Wrap(
                  spacing: AppSpacing.lg,
                  runSpacing: AppSpacing.lg,
                  children: List.generate(
                    AppConstants.skills.length,
                    (index) {
                      final skill = AppConstants.skills[index];
                      final colors = [
                        AppColors.accent1,
                        AppColors.accent2,
                        AppColors.accent3,
                        AppColors.accent4,
                      ];
                      final color = colors[index % colors.length];

                      return SkillChip(
                        label: skill,
                        textColor: color,
                      );
                    },
                  ),
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
