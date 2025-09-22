import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';
import 'corner_widget.dart';
import 'my_way.dart';
import 'future_plans.dart';

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
                        buildFuturePlansSection(),

                        // Добавляем отступ внизу
                        SizedBox(height: isMobile ? 100 : 200),
                      ],
                    ),
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
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Привет, я\u00A0Рузанна.\nFlutter разработчик',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: isMobile ? AppSpacing.lg : AppSpacing.xl,
                  ),
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
          ),
          // Фотография (только на десктопе и планшете)
          if (!isMobile) Flexible(flex: 1, child: _buildProfilePhoto(isTablet)),
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
      right: isTablet ? 50 : 100,
      child: Container(
        width: isTablet ? 200 : 330,
        height: isTablet ? 200 : 330,
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
}

