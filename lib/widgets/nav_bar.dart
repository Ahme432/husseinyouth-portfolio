import 'package:apps_yother/widgets/web_hover_effect.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProgramsTap;
  final VoidCallback onAppsTap;
  final VoidCallback onContactTap;
  final VoidCallback onDonateTap;

  const NavBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProgramsTap,
    required this.onAppsTap,
    required this.onContactTap,
    required this.onDonateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Name
          Row(
            children: [
              Image.asset('assets/images/foundation_logo.png', height: 50),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مؤسسة شباب الحسين',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00897B),
                    ),
                  ),
                  Text(
                    'للمساعدات الإنسانية',
                    style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          // Navigation Links (Desktop)
          if (MediaQuery.of(context).size.width > 800)
            Row(
              children: [
                _NavLink(title: 'الرئيسية', onTap: onHomeTap),
                _NavLink(title: 'عن المؤسسة', onTap: onAboutTap),
                _NavLink(title: 'البرامج', onTap: onProgramsTap),
                _NavLink(title: 'تطبيقاتنا', onTap: onAppsTap),
                _NavLink(title: 'تواصل معنا', onTap: onContactTap),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: onDonateTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00897B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'تبرع الآن',
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          else
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: Color(0xFF00897B)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (item) {
                switch (item) {
                  case 0:
                    onHomeTap();
                    break;
                  case 1:
                    onAboutTap();
                    break;
                  case 2:
                    onProgramsTap();
                    break;
                  case 3:
                    onAppsTap();
                    break;
                  case 4:
                    onContactTap();
                    break;
                  case 5:
                    onDonateTap();
                    break;
                }
              },
              itemBuilder:
                  (context) => [
                    _buildPopupMenuItem(0, 'الرئيسية', Icons.home),
                    _buildPopupMenuItem(1, 'عن المؤسسة', Icons.info),
                    _buildPopupMenuItem(2, 'البرامج', Icons.work),
                    _buildPopupMenuItem(3, 'تطبيقاتنا', Icons.apps),
                    _buildPopupMenuItem(4, 'تواصل معنا', Icons.phone),
                    const PopupMenuDivider(),
                    PopupMenuItem<int>(
                      value: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00897B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'تبرع الآن',
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
            ),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(
    int value,
    String title,
    IconData icon,
  ) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00897B), size: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WebHoverEffect(
      builder: (context, isHovered) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color:
                  isHovered ? const Color(0xFF00897B) : const Color(0xFF455A64),
            ),
          ),
        );
      },
      onTap: onTap,
    );
  }
}
