import 'package:apps_yother/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:apps_yother/widgets/nav_bar.dart';
import 'package:apps_yother/widgets/top_bar.dart'; // Add TopBar import

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _programsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _donateKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean white background
      body: SelectionArea(
        child: Focus(
          autofocus: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const TopBar(), // New Top Bar
                NavBar(
                  onHomeTap: () => _scrollToSection(_homeKey),
                  onAboutTap: () => _scrollToSection(_aboutKey),
                  onProgramsTap: () => _scrollToSection(_programsKey),
                  onContactTap: () => _scrollToSection(_contactKey),
                  onDonateTap: () => _scrollToSection(_donateKey),
                ),
                Container(key: _homeKey, child: _buildHeroSection(context)),
                Container(key: _aboutKey, child: _buildInfoSection(context)),
                Container(
                  key: _programsKey,
                  child: _buildProgramsSection(context),
                ),
                _buildFundingSection(context),
                _buildTechnologySection(context),
                Container(
                  key: _donateKey,
                  child: _buildDonationSection(context),
                ),
                _buildFinancialSection(context),
                Container(key: _contactKey, child: _buildFooter()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint changed to 600px (Strictly Phones) to avoid huge vertical images on Tablets/Desktop
        final bool isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          // Mobile Layout (Phones): Vertical 9:16 Image + Content
          return Container(
            color: const Color(0xFF00897B),
            child: Column(
              children: [
                // 9:16 Vertical Image Container
                AspectRatio(
                  aspectRatio: 9 / 16, // Requested vertical ratio for phones
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/hero_children_real.jpg',
                        fit: BoxFit.cover,
                      ),
                      // Gradient to blend bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                const Color(0xFF00897B),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text Content
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'مؤسسة شباب الحسين',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 32, // Slightly smaller for better fit
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'يد عون للخير ونبض للأمل',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'مؤسسة خيرية ثقافية تعمل على دعم عشرات العوائل المتعففة والأيتام وسد النقص لديهم في الجانبين الخيري والثقافي.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _scrollToSection(_donateKey),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF00897B),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                            child: Text(
                              'تبرع الآن',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed:
                                () =>
                                    _launchUrl('https://wa.me/+9647601199150'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                            child: Text(
                              'تواصل معنا',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Bottom Curve
                ClipPath(
                  clipper: const _HeroClipper(),
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        } else {
          // Desktop/Tablet Layout: Scalable Aspect Ratio (2.35:1 Cinematic)
          // This ensures it shrinks when window width shrinks, answering "Why doesn't it shrink?"
          return ClipPath(
            clipper: const _HeroClipper(),
            child: AspectRatio(
              aspectRatio: 2.35 / 1, // Cinematic Widescreen Ratio
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/hero_children_real.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.center, // Center the image
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          const Color(0xFF00897B).withValues(alpha: 0.95),
                          const Color(0xFF00897B).withValues(alpha: 0.7),
                          const Color(0xFF00897B).withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    // Center content vertically
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'مؤسسة شباب الحسين',
                                  style: GoogleFonts.cairo(
                                    fontSize:
                                        64, // Scaled down slightly for better responsive fit
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.1,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 4),
                                        blurRadius: 20,
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'يد عون للخير ونبض للأمل',
                                  style: GoogleFonts.cairo(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 10,
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: 600,
                                  child: Text(
                                    'مؤسسة خيرية ثقافية تعمل على دعم عشرات العوائل المتعففة والأيتام وسد النقص لديهم في الجانبين الخيري والثقافي.',
                                    style: GoogleFonts.cairo(
                                      fontSize: 18,
                                      color: Colors.white.withValues(
                                        alpha: 0.95,
                                      ),
                                      height: 1.6,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5,
                                          color: Colors.black.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 48),
                                Wrap(
                                  spacing: 24,
                                  runSpacing: 24,
                                  children: [
                                    ElevatedButton(
                                      onPressed:
                                          () => _scrollToSection(_donateKey),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF00897B,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 48,
                                          vertical: 24,
                                        ),
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'تبرع الآن',
                                        style: GoogleFonts.cairo(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed:
                                          () => _launchUrl(
                                            'https://wa.me/+9647601199150',
                                          ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 2.5,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 48,
                                          vertical: 24,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'تواصل معنا',
                                        style: GoogleFonts.cairo(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 3), // Space for image visibility
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildFundingSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF5F7FA),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader('موارد المؤسسة'),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            margin: const EdgeInsets.only(bottom: 48),
            child: Text(
              'وارد المؤسسة يعتمد على ٣ موارد رئيسية:',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              _buildFundingCard(
                title: 'أولاً: الختمات الشهرية',
                content:
                    'هو البرنامج الأكبر لدينا، حيث يوجد أكثر من 700 متبرع يقرأون القرآن شهريًا، ويهدون هذه القراءة للمتبرعين والمشاركين. يحصل المشتركون على 60 ختمة في الشهر الواحد. الاشتراك 4000 د.ع شهرياً.',
                icon: FontAwesomeIcons.bookQuran,
                color: const Color(0xFFE8F5E9),
              ),
              _buildFundingCard(
                title: 'ثانياً: الصناديق',
                content:
                    'صندوق الإمام السجاد (عليه السلام)، يحصل المشتركون الذين يمتلكون أحد صناديق المؤسسة أيضًا على 60 ختمة في الشهر الواحد.',
                icon: FontAwesomeIcons.boxOpen,
                color: const Color(0xFFE3F2FD),
                action: Column(
                  children: [
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => _launchUrl('tel:07601199150'),
                      icon: const Icon(Icons.phone),
                      label: Text(
                        'اطلب صندوق الان',
                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              _buildFundingCard(
                title: 'ثالثاً: الاشتراكات الثابتة',
                content:
                    'يشارك بعض الإخوة في برنامج معين بشكل مستمر، وتخصص هذه التبرعات لسد احتياجات العوائل من نفس المبلغ المخصص لهذا البرنامج.',
                icon: FontAwesomeIcons.handHoldingHand,
                color: const Color(0xFFFFF3E0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFundingCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    Widget? action,
  }) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: FaIcon(icon, size: 32, color: Colors.black87),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: GoogleFonts.cairo(
              fontSize: 16,
              height: 1.6,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null) action,
        ],
      ),
    );
  }

  Widget _buildTechnologySection(BuildContext context) {
    // Reusing existing app cards logic but wrapping in new section
    final List<Widget> apps = [
      const AppCard(
        title: 'حقيبة الكوثر',
        description:
            'تطبيق ديني شيعي متكامل، يحتوي على عدة أدعية وزيارات. متوفر على آيفون وأندرويد.',
        logoPath: 'assets/images/kawthar_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=com.husseinyouth.khatma',
        iosUrl:
            'https://apps.apple.com/us/app/%D8%AD%D9%82%D9%8A%D8%A8%D8%A9-%D8%A7%D9%84%D9%83%D9%88%D8%AB%D8%B1/id6748036531?l=ar',
      ),
      const AppCard(
        title: 'بنك الدم العراقي',
        description:
            'الأول من نوعه لتسهيل عملية التبرع بالدم في الحالات الصحية الحرجة. يجمع المتبرعين والمحتاجين في جميع محافظات العراق.',
        logoPath: 'assets/images/bloodbank_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=exp.bloodbank',
      ),
      const AppCard(
        title: 'سفراء الولاية',
        description:
            'لإقامة الدورات القرآنية الصيفية السنوية التي تحتضن أكثر من 600 طالب. يشمل مسابقات إلكترونية.',
        logoPath: 'assets/images/ambassadors_logo.png',
        androidUrl:
            'https://play.google.com/store/apps/details?id=com.mycompany.students',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader('مواكبة التطور'),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            margin: const EdgeInsets.only(bottom: 48),
            child: Text(
              'من أولى اهتمامات إدارة المؤسسة مواكبة التطور الحاصل في العالم، حيث أطلقت المؤسسة مؤخرًا عدة تطبيقات وأبقت تطوراً في النظام الداخلي يعتمد على برنامج خاص لتسجيل جميع التبرعات والصرفيات.',
              style: GoogleFonts.cairo(
                fontSize: 18,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
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

  Widget _buildSectionHeader(String title) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00897B),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 48),
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFF00ACC1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildProgramsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader('برامجنا'),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            margin: const EdgeInsets.only(bottom: 48),
            child: Text(
              'هذه البرامج ثابتة لدعم العوائل المتعففة والأيتام المسجلين لدينا، حيث يتم شمول العوائل في بعض هذه البرامج أو جميعها وفقا لاحتياجات العائلة. بعد الكشف على العائلة ميدانيا والتأكد من صحة احتياجاتها، تشرع المؤسسة في توفيرها من خلال التبرعات الموجودة.',
              style: GoogleFonts.cairo(
                fontSize: 18,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildProgramCard(
                'برنامج المساعدات المالية',
                FontAwesomeIcons.handHoldingDollar,
              ),
              _buildProgramCard(
                'برنامج المساعدات الصحية',
                FontAwesomeIcons.heartPulse,
              ),
              _buildProgramCard(
                'برنامج المساعدات العينية',
                FontAwesomeIcons.boxOpen,
              ),
              _buildProgramCard('برنامج البناء', FontAwesomeIcons.trowelBricks),
              _buildProgramCard('برنامج الزواج', FontAwesomeIcons.ring),
              _buildProgramCard(
                'برنامج الثقافة',
                FontAwesomeIcons.bookOpenReader,
              ),
              _buildProgramCard(
                'التأهيل والاكتفاء الذاتي',
                FontAwesomeIcons.scissors,
              ),
              _buildProgramCard(
                'الدورات الصيفية (سفراء الولاية)',
                FontAwesomeIcons.graduationCap,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(String title, IconData icon) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(icon, size: 28, color: const Color(0xFF1B5E20)),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF5F7FA),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader('من نحن'),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              _buildInfoCard(
                title: 'نظرة عامة',
                content:
                    'مؤسسة خيرية انطلقت عام ٢٠١٥ بجهود بسيطة وبمبلغ زهيد، تعنى بنشر الثقافة بين أفراد المجتمع وكذلك توفير احتياجات الأيتام والمحتاجين ماديًا وعينيًا، ويتم دعم المؤسسة من بعض الإخوة المؤمنين ومن خلال برامجها المتعددة.',
                icon: FontAwesomeIcons.landmark,
              ),
              _buildInfoCard(
                title: 'رؤيتنا',
                content:
                    'نسعى لسد احتياجات الأيتام والمحتاجين وتوفير فرص العمل لهم من خلال الورش التدريبية في مركز التأهيل، اما من ناحية الثقافة تطمح إدارة المؤسسة لفتح دورات اكثر ضمن العمل الثقافي.',
                icon: FontAwesomeIcons.eye,
              ),
              _buildInfoCard(
                title: 'رسالتنا',
                content:
                    'مجموعة من الشباب تسعى لنشر الوعي الثقافي وكذلك تلبية احتياجات المحتاجين والأيتام.',
                icon: FontAwesomeIcons.handsHoldingChild,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FaIcon(icon, size: 32, color: const Color(0xFF1B5E20)),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: GoogleFonts.cairo(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader('المصاريف'),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildFinancialRow(
                  'السنة',
                  'المصاريف الخيرية',
                  'المصاريف الثقافية',
                  isHeader: true,
                ),
                const Divider(),
                _buildFinancialRow('سنوات سابقة', '9,390,000', '971,000'),
                _buildFinancialRow('2021', '73,087,500', '2,000,000'),
                _buildFinancialRow('2022', '34,859,500', '7,834,000'),
                _buildFinancialRow('2023', '49,435,500', '3,747,500'),
                _buildFinancialRow('2024', '69,670,750', '12,465,750'),
                _buildFinancialRow('2025', '92,479,750', '11,789,000'),
                const Divider(height: 32, thickness: 2),
                _buildFinancialRow(
                  'المجموع الكلي',
                  '328,923,000',
                  '38,807,250',
                  isHeader: true,
                  color: Color(0xFFE8F5E9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(
    String year,
    String charity,
    String cultural, {
    bool isHeader = false,
    Color? color,
  }) {
    final style = GoogleFonts.cairo(
      fontSize: isHeader ? 16 : 14,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: isHeader ? const Color(0xFF1B5E20) : Colors.black87,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(year, style: style, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Text(charity, style: style, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Text(cultural, style: style, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          _buildSectionHeader('ساهم معنا'),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Zain Cash Card
              _buildDonationCard(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/zain_logo.png',
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          '07842277961',
                          style: GoogleFonts.cairo(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _copyToClipboard(context, '07842277961'),
                      icon: const Icon(Icons.copy, size: 18),
                      label: Text(
                        'نسخ الرقم',
                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/zain_qr.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'امسح الباركود للدفع',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // MasterCard Card
              _buildDonationCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/mastercard_logo.png',
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'MasterCard',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          '7114067049',
                          style: GoogleFonts.cairo(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed:
                              () => _copyToClipboard(context, '7114067049'),
                          icon: const Icon(Icons.copy, size: 18),
                          label: Text(
                            'نسخ الرقم',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEB001B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Chip(
                      label: Text('بطاقة مصرفية'),
                      backgroundColor: Color(0xFFF5F7FA),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard({required Widget child}) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
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
          const SizedBox(height: 48),

          // Social Icons
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialIcon(
                FontAwesomeIcons.youtube,
                'https://youtube.com/@hussein.youth1?si=pYYUjv3ZejsMIdWv',
              ),
              _buildSocialIcon(
                FontAwesomeIcons.facebook,
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
                FontAwesomeIcons.whatsapp,
                'https://wa.me/+9647601199150',
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

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      onPressed: () => _launchUrl(url),
      icon: FaIcon(icon, color: Colors.white, size: 32),
      style: IconButton.styleFrom(
        hoverColor: Colors.white.withValues(alpha: 0.1),
        highlightColor: Colors.white.withValues(alpha: 0.2),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم نسخ الرقم: $text', style: GoogleFonts.cairo()),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _HeroClipper extends CustomClipper<Path> {
  const _HeroClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80); // Start slightly above bottom left

    // Create a smooth curve
    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(
      size.width - (size.width / 3.25),
      size.height - 80,
    );
    final secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Top right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
