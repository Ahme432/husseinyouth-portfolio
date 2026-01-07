import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF00695C), // Darker Teal for top bar
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Contact Info
          Wrap(
            spacing: 24,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildTopBarItem(
                icon: Icons.phone,
                text: '07601199150',
                onTap: () => _launchUrl('tel:07601199150'),
              ),
              _buildTopBarItem(
                icon: Icons.email,
                text: 'info@husseinyouth.org', // Placeholder email
                onTap: () => _launchUrl('mailto:info@husseinyouth.org'),
              ),
            ],
          ),

          // Social Icons
          Wrap(
            spacing: 16,
            children: [
              _buildSocialIcon(
                FontAwesomeIcons.facebookF,
                'https://www.facebook.com/hussein.youth?mibextid=ZbWKwL',
              ),
              _buildSocialIcon(
                FontAwesomeIcons.instagram,
                'https://www.instagram.com/hussein.youth?igsh=MmtlY3JqeDYxeDk1',
              ),
              _buildSocialIcon(
                FontAwesomeIcons.telegram,
                'https://t.me/ShababAlhussein',
              ),
              _buildSocialIcon(
                FontAwesomeIcons.youtube,
                'https://youtube.com/@hussein.youth1?si=pYYUjv3ZejsMIdWv',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBarItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white70),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.cairo(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: FaIcon(icon, size: 16, color: Colors.white70),
    );
  }
}
