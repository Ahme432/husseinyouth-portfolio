import 'package:apps_yother/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildAppsSection(context),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage(
                'assets/images/foundation_logo.png',
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'مؤسسة شباب الحسين',
            style: GoogleFonts.cairo(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'للمساعدات الإنسانية',
            style: GoogleFonts.cairo(
              fontSize: 28,
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Text(
              'مؤسسة خيرية ثقافية تعمل على دعم عشرات العوائل المتعففة والأيتام وسد النقص لديهم في الجانبين الخيري والثقافي.',
              style: GoogleFonts.cairo(
                fontSize: 20,
                height: 1.6,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppsSection(BuildContext context) {
    final List<Widget> apps = [
      const AppCard(
        title: 'حقيبة الكوثر',
        description:
            'تطبيق ديني شيعي متكامل، والتطوير فيه مستمر. متوفر على آيفون وأندرويد، وله أكثر من 1,500 مستخدم.',
        logoPath: 'assets/images/kawthar_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=com.husseinyouth.khatma',
        iosUrl:
            'https://apps.apple.com/us/app/%D8%AD%D9%82%D9%8A%D8%A8%D8%A9-%D8%A7%D9%84%D9%83%D9%88%D8%AB%D8%B1/id6748036531?l=ar',
      ),
      const AppCard(
        title: 'بنك الدم العراقي',
        description:
            'تطبيق يجمع المتبرعين والمحتاجين في جميع محافظات العراق في واجهة بسيطة لإنقاذ الأرواح. متوفر على أندرويد فقط، وقريبًا على آيفون. يضم أكثر من 1,500 مستخدم.',
        logoPath: 'assets/images/bloodbank_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=exp.bloodbank',
      ),
      const AppCard(
        title: 'سفراء الولاية',
        description:
            'تطبيق ديني يشمل عدة فئات عمريه لإجراء الدورات القرآنية الصيفية وعدة مسابقات إلكترونية. سجل في أول انطلاق له أكثر من 600 مشترك. متوفر على أندرويد فقط، وقريبًا على آيفون.',
        logoPath: 'assets/images/ambassadors_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=com.mycompany.students',
      ),
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFF5F7FA),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'تطبيقاتنا',
            style: GoogleFonts.cairo(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B5E20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 48),
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF00C853),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 32,
            children: apps,
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $uri');
    }
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF263238),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'تواصل معنا',
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildContactItem(
                icon: Icons.phone,
                title: 'رقم الهاتف',
                content: '07601199150',
                onTap: () => _launchUrl('tel:07601199150'),
              ),
              _buildContactItem(
                icon: Icons.location_on,
                title: 'العنوان',
                content:
                    'العراق - بابل - قضاء الهاشمية\nشارع مركز الشرطة القديم',
                onTap:
                    () =>
                        _launchUrl('https://maps.app.goo.gl/5nyAFBLDeNLYt4KMA'),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 20),
          Text(
            'بكل حب ❤️ من مؤسسة شباب الحسين',
            style: GoogleFonts.cairo(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            '© ${DateTime.now().year} جميع الحقوق محفوظة',
            style: GoogleFonts.cairo(fontSize: 14, color: Colors.white30),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF00C853), size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.cairo(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: GoogleFonts.cairo(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
