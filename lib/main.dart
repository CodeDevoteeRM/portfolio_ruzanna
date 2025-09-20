import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';
import 'corner_widget.dart';
import 'my_way.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio - Рузанна',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 150, 136),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.grey, height: 1.5),
        ),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.mobile;
    final isTablet = screenWidth < AppBreakpoints.tablet;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                color: AppColors.primaryDark,
                child: Stack(
                  children: [
                    if (!isMobile) ...[
                      const Positioned(
                        top: 0,
                        left: 0,
                        child: CornerWidget(
                          text: "PORTFOLIO",
                          alignment: Alignment.topLeft,
                          inverted: true,
                        ),
                      ),
                    ],
                    
                    // Основной контент
                    Column(
                      children: [
                        _buildMainContent(context, isMobile, isTablet),
                        
                        // Таймлайн развития
                        const DevelopmentTimeline(),
                        
                        // Планы на будущее
                        _buildFuturePlansSection(),
                        
                        // Добавляем отступ внизу
                        SizedBox(height: isMobile ? 100 : 200),
                      ],
                    ),

                    // Фотография (только на десктопе и планшете)
                    if (!isMobile) _buildProfilePhoto(isTablet),

                    // Мобильная навигация
                    if (isMobile) _buildMobileNavigation(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.only(
        top: isMobile ? 80 : 120,
        left: isMobile ? AppSpacing.lg : (isTablet ? 100 : 170),
        right: isMobile ? AppSpacing.lg : (isTablet ? 100 : 170),
        bottom: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Привет, я\u00A0Рузанна.\nFlutter разработчик',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: isMobile ? 22 : 25),
          ),
          SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.lg),
          Text(
            'Создаю красивые и\u00A0производительные мобильные приложения '
            'на\u00A0Flutter. Специализируюсь на\u00A0кроссплатформенной разработке, '
            '3D-интеграции и\u00A0современном UI/UX дизайне.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: isMobile ? 14 : 16),
          ),
          SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
          _buildActionButtons(isMobile),
        ],
      ),
    );
  }

  Widget _buildFuturePlansSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryDark.withOpacity(0.9),
            AppColors.primaryDark,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // Заголовок раздела
              const Text(
                'Планы на будущее',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Направления развития и новые вызовы',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Сетка планов
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 3,
                children: [
                  _buildPlanCard(
                    icon: Icons.microwave_sharp,
                    title: 'Архитектура микросервисов',
                    subtitle: 'Глубокое изучение distributed systems',
                  ),
                  _buildPlanCard(
                    icon: Icons.leak_add_rounded,
                    title: 'AI/ML экспертиза',
                    subtitle: 'Специализация на ИИ в мобильных приложениях',
                  ),
                  _buildPlanCard(
                    icon: Icons.manage_accounts,
                    title: 'Продуктовое мышление',
                    subtitle: 'Развитие навыков продакт-менеджмента',
                  ),
                ],
              ),

              // Декоративный элемент
              const SizedBox(height: 40),
              Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.accentTeal,
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accentTeal.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentTeal.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Эмодзи
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.accentTeal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accentTeal.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: AppColors.accentTeal,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Текст
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        FilledButton.tonal(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Исследовать проекты'),
              SizedBox(width: 8),
              Icon(Icons.arrow_right_alt, size: 20),
            ],
          ),
        ),
        OutlinedButton(onPressed: () {}, child: Text('Начать сотрудничество')),
      ],
    );
  }

  Widget _buildProfilePhoto(bool isTablet) {
    return Positioned(
      top: 70,
      right: isTablet ? 50 : 150,
      child: Container(
        width: isTablet ? 150 : 200,
        height: isTablet ? 150 : 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          image: const DecorationImage(
            image: AssetImage('assets/photo1.jpeg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return Positioned(
      bottom: AppSpacing.lg,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.secondaryDark.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _MobileNavButton(icon: Icons.work, label: 'Проекты'),
            _MobileNavButton(icon: Icons.code, label: 'Навыки'),
            _MobileNavButton(icon: Icons.email, label: 'Контакты'),
          ],
        ),
      ),
    );
  }
}

class _MobileNavButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MobileNavButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}