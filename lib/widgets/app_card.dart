import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                logoPath,
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B5E20), // Dark Green
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (androidUrl != null)
                  _StoreButton(
                    icon: FontAwesomeIcons.googlePlay,
                    label: 'Google Play',
                    onTap: () => _launchUrl(androidUrl!),
                  ),
                if (androidUrl != null && iosUrl != null)
                  const SizedBox(width: 12),
                if (iosUrl != null)
                  _StoreButton(
                    icon: FontAwesomeIcons.appStore,
                    label: 'App Store',
                    onTap: () => _launchUrl(iosUrl!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StoreButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label, style: GoogleFonts.cairo(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
