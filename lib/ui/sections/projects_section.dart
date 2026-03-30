import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final String? github;
  final String? playstore;
  final String? appstore;
  final String? demoLink;

  ProjectItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    this.github,
    this.playstore,
    this.appstore,
    this.demoLink,
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
        title: 'Nutrimir',
        description: 'AI Meal Analysis App - Analyze meals via photos.This app helps you take control of your health by understanding your food better. Just snap a photo of your meal, and let our smart AI break down the ingredients, nutrition info, and more — instantly.',
        imageUrl: 'assets/images/nutrimir_app.png',
        tags: ['Flutter', 'REST APIs','Web Stripes', 'In app purchases' ],
        playstore: 'https://play.google.com/store/apps/details?id=com.nutrimir.app&pcampaignid=web_share',
        appstore: null,
      ),
      ProjectItem(
        title: 'Sell Your Strips',
        description: 'Diabetic Accessories Selling Platform. Sell Your Unused Diabetic Supplies for Fast Cash! Have extra diabetic supplies? Don’t let them go to waste—turn them into quick cash with no hassle, no hidden fees, and fast payment. We are serving you Monday to Saturday 9:00 am to 5:00 pm CST',
        imageUrl: 'assets/images/sell_your_strips_app.png',
        tags: ['Flutter', 'REST APIs' ],
        playstore: 'https://play.google.com/store/apps/details?id=com.sellyourstripsusa.app&pcampaignid=web_share',
        appstore: 'https://apps.apple.com/us/app/sell-your-strips/id6751053534',
      ),
      ProjectItem(
        title: 'Rovascore',
        description: 'Live Sports Scores & Stats Platform. RovaScore livescore is your ultimate companion for football and cricket, basketball enthusiasts. Get live match statistics, real-time scores, and in-depth player performance analytics.',
        imageUrl: 'assets/images/rovascore_app.png',
        tags: ['Flutter','REST APIs' ,'Firebase'],
        playstore: 'https://play.google.com/store/apps/details?id=com.rovascore.app&pcampaignid=web_share',
        appstore: 'https://apps.apple.com/us/app/rovascore-live-scores-news/id6756863993',
      ),
      ProjectItem(
        title: 'Underdog',
        description: 'Whether you are looking for the latest apparel designs for the gym and the city, or you need the best Protein, Creatine, & pre-workout to crush your goals, the HumbleUnderdogs app has you covered. Shop quickly, easily, and gain access to exclusive app-only deals.',
        imageUrl: 'assets/images/underdog_app.png',
        tags: ['Flutter', 'REST APIs','Web Stripes'],
        playstore: 'https://play.google.com/store/apps/details?id=com.humbleunderdogs.app',
        appstore: null,
      ),
      ProjectItem(
        title: 'WingSync',
        description: 'Crew & Flight Management System. Keeping you up to date with the latest in aviation tech and real-time flight data. Whether you\'re looking for automated rosters, live delay tracking, or seamless family sync, I’m your one-stop destination for bridging the gap between the cockpit and the home. From OCR roster scanning to FlightRadar24 API integrations, I build the tools that keep crews and their families connected. Stay on top of every arrival with WingSync!',
        imageUrl: 'assets/images/wingsync_app.png',
        tags: ['Flutter','REST APIs' ,'Firebase', 'In app purchases' ],
        demoLink: 'https://drive.google.com/drive/folders/1lrvqvcnroYHFaqf_oq1u9tPHVHUulWWS?usp=sharing',
      ),
      ProjectItem(
        title: 'MindGuardian',
        description: 'MindGuardian is your personal AI-powered assistant for balance, focus, and motivation. It provides the essential tools to protect your mental health and achieve your goals in a stressful world.',
        imageUrl: 'assets/images/mind_guardian.jpeg',
        tags: ['Flutter', 'REST APIs' ,'Firebase', 'In app purchases' ],
        playstore: 'https://play.google.com/store/apps/details?id=com.mindgurdina.app',
      ),
      ProjectItem(
        title: 'Stoic Alarm',
        description: 'The Philosopher Quote Alarm. A Stoic-inspired alarm app that helps users start their day with motivation—set repeating alarms, choose custom “philosopher voice” alarm sounds, get daily quotes with explanations, and manage your account/profile with secure OTP-based password recovery, backed by Firebase and API integration.',
        imageUrl: 'assets/images/stoic_alarm_app.png',
        tags: ['Flutter','REST APIs' ,'Firebase', 'In app purchases' ],
        demoLink: 'https://drive.google.com/drive/folders/1taDX4pOPKKYceL7Au9lKewAXdO6V2DTC?usp=sharing',
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
                    crossAxisCount: isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
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
                    child: Image.asset(
                      widget.project.imageUrl,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.textTertiary,
                            size: 60,
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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.project.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
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
                              fontSize: 12,
                            ),
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Tags
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: widget.project.tags
                              .take(4)
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

                        // Links/Buttons
                        const SizedBox(height: 5),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            // Play Store Button
                            if (widget.project.playstore != null)
                              TextButton.icon(
                                onPressed: () => _launchUrl(context, widget.project.playstore!),
                                icon: const Icon(Icons.play_arrow, size: 16),
                                label: const Text('Play', style: TextStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            
                            // App Store Button
                            if (widget.project.appstore != null)
                              TextButton.icon(
                                onPressed: () => _launchUrl(context, widget.project.appstore!),
                                icon: const Icon(Icons.apple, size: 16),
                                label: const Text('Apple', style: TextStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.accent2,
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            
                            // Not Published Dialog
                            if (widget.project.playstore == null && widget.project.appstore == null && widget.project.demoLink != null)
                              TextButton.icon(
                                onPressed: () => _showNotPublishedDialog(context),
                                icon: const Icon(Icons.info_outline, size: 16),
                                label: const Text('Status', style: TextStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            
                            // Demo Button (if no stores published)
                            if (widget.project.demoLink != null && 
                                (widget.project.playstore == null || widget.project.appstore == null))
                              TextButton.icon(
                                onPressed: () => _launchUrl(context, widget.project.demoLink!),
                                icon: const Icon(Icons.play_circle_outlined, size: 16),
                                label: const Text('Demo', style: TextStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.amber,
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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

  Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  void _showNotPublishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgSecondary,
        title: const Text('Coming Soon'),
        content: const Text(
          'This app is currently on the way to being published on app stores. Check back soon or view the demo!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

