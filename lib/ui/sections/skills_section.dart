import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Skill Data Model
class SkillItem {
  final String name;
  final IconData icon;
  final Color color;

  SkillItem({
    required this.name,
    required this.icon,
    required this.color,
  });
}

/// Skills Section
class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const SkillsSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);
    final isMobile = Responsive.isMobile(context);

    // Skills with icons and colors
    final skillsList = [
      SkillItem(name: 'Dart', icon: Icons.code, color: const Color(0xFF00D4FF)),
      SkillItem(name: 'Flutter', icon: Icons.flutter_dash, color: const Color(0xFF02569B)),
      SkillItem(name: 'GetX', icon: Icons.settings, color: const Color(0xFF795548)),
      SkillItem(name: 'Provider', icon: Icons.cloud, color: const Color(0xFFFFC107)),
      SkillItem(name: 'RxDart', icon: Icons.waves, color: const Color(0xFF4CAF50)),
      SkillItem(name: 'Firebase', icon: Icons.local_fire_department, color: const Color(0xFFFF6F00)),
      SkillItem(name: 'Supabase', icon: Icons.storage, color: const Color(0xFF27AE60)),
      SkillItem(name: 'SQLite', icon: Icons.table_chart, color: const Color(0xFF0275D8)),
      SkillItem(name: 'REST API', icon: Icons.api, color: const Color(0xFF673AB7)),
      SkillItem(name: 'Google Maps', icon: Icons.location_on, color: const Color(0xFFEA4335)),
      SkillItem(name: 'Payment Gateway', icon: Icons.payment, color: const Color(0xFF1976D2)),
      SkillItem(name: 'Google Ads', icon: Icons.ads_click, color: const Color(0xFF4285F4)),
      SkillItem(name: 'In-App Purchase', icon: Icons.shopping_cart, color: const Color(0xFF34A853)),
      SkillItem(name: 'Git & GitHub', icon: Icons.code_rounded, color: const Color(0xFF333333)),
      SkillItem(name: 'Figma & Adobe XD', icon: Icons.palette, color: const Color(0xFF9C27B0)),
      SkillItem(name: 'HTTP & Dio', icon: Icons.cloud_download, color: const Color(0xFF00BCD4)),
      SkillItem(name: 'Notifications', icon: Icons.notifications, color: const Color(0xFFFF5722)),
      SkillItem(name: 'CI/CD', icon: Icons.build_circle, color: const Color(0xFF009688)),
      SkillItem(name: 'OOP', icon: Icons.architecture, color: const Color(0xFF3F51B5)),
      SkillItem(name: 'Bloc', icon: Icons.view_comfy, color: const Color(0xFF00ACC1)),
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
                  'Skills & Expertise',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Skills Grid
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 3 : (Responsive.isTablet(context) ? 4 : 5),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: skillsList.length,
                  itemBuilder: (context, index) {
                    return _SkillCard(skill: skillsList[index]);
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

/// Skill Card Widget
class _SkillCard extends StatefulWidget {
  final SkillItem skill;

  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> with SingleTickerProviderStateMixin {
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.border.withOpacity(0.3),
                width: 0.8,
              ),
              color: AppColors.bgSecondary,
              boxShadow: [
                BoxShadow(
                  color: widget.skill.color.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Skill Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.skill.color.withOpacity(0.2),
                        widget.skill.color.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Icon(
                    widget.skill.icon,
                    size: 28,
                    color: widget.skill.color,
                  ),
                ),
                const SizedBox(height: 6),

                // Skill Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    widget.skill.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
