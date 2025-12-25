import 'package:apps_yother/widgets/web_hover_effect.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String description;
  final String logoPath;
  final String? androidUrl;
  final String? iosUrl;

  const AppCard({
    super.key,
    required this.title,
    required this.description,
    required this.logoPath,
    this.androidUrl,
    this.iosUrl,
  });

  Future<void> _launchUrl(String url) async {
    if (url == '#' || url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebHoverEffect(
      builder: (context, isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 350,
          transform:
              isHovered
                  ? (Matrix4.identity()..translate(0, -10, 0))
                  : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    isHovered
                        ? Colors.black12
                        : Colors.black.withValues(alpha: 0.05),
                blurRadius: isHovered ? 20 : 10,
                offset: isHovered ? const Offset(0, 10) : const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo Header with Gradient
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Color(0xFFF5F7FA), Color(0xFFE4E8EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: title,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(logoPath),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B5E20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        if (androidUrl != null)
                          _StoreBadge(
                            icon: FontAwesomeIcons.googlePlay,
                            label: 'Google Play',
                            color: const Color(0xFF00C853),
                            onTap: () => _launchUrl(androidUrl!),
                          ),
                        if (iosUrl != null)
                          _StoreBadge(
                            icon: FontAwesomeIcons.appStore,
                            label: 'App Store',
                            color: const Color(0xFF1565C0),
                            onTap: () => _launchUrl(iosUrl!),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StoreBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _StoreBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WebHoverEffect(
      onTap: onTap,
      builder: (context, isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered ? color : color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: isHovered ? Colors.white : color),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isHovered ? Colors.white : color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
