import 'package:apps_yother/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildFoundationInfo(),
            _buildAppsGrid(context),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        children: [
          Image.asset('assets/images/foundation_logo.png', height: 100),
          const SizedBox(height: 16),
          Text(
            'مؤسسة شباب الحسين',
            style: GoogleFonts.cairo(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B5E20),
            ),
          ),
          Text(
            'للمساعدات الإنسانية',
            style: GoogleFonts.cairo(
              fontSize: 24,
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoundationInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Text(
          'مؤسسة خيرية ثقافية تعمل على دعم عشرات العوائل المتعففة والأيتام وسد النقص لديهم في الجانبين الخيري والثقافي.',
          style: GoogleFonts.cairo(
            fontSize: 18,
            height: 1.8,
            color: Colors.grey[800],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAppsGrid(BuildContext context) {
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
        // iosUrl: null, // Coming soon
      ),
      const AppCard(
        title: 'سفراء الولاية',
        description:
            'تطبيق ديني يشمل عدة فئات عمريه لإجراء الدورات القرآنية الصيفية وعدة مسابقات إلكترونية. سجل في أول انطلاق له أكثر من 600 مشترك. متوفر على أندرويد فقط، وقريبًا على آيفون.',
        logoPath: 'assets/images/ambassadors_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=com.mycompany.students',
        // iosUrl: null, // Coming soon
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: apps,
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF1B5E20),
      child: Text(
        '© ${DateTime.now().year} مؤسسة شباب الحسين للمساعدات الإنسانية',
        style: GoogleFonts.cairo(color: Colors.white70),
        textAlign: TextAlign.center,
      ),
    );
  }
}
