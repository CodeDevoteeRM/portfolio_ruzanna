import 'package:flutter/material.dart';
import 'time_line.dart';

class DevelopmentTimeline extends StatefulWidget {
  const DevelopmentTimeline({super.key});

  @override
  State<DevelopmentTimeline> createState() => _DevelopmentTimelineState();
}

class _DevelopmentTimelineState extends State<DevelopmentTimeline> {
  final List<Map<String, dynamic>> _timelineData = [
  {
    'year': 'Год 1 (2023)',
    'level': 'Junior Level',
    'icon': Icons.eco,
    'title': 'Основы и первые проекты',
    'description': 'Изучение Flutter с нуля, создание первых коммерческих приложений и освоение основных паттернов разработки.',
    'stats': ['3 проекта'],
    'technologies': ['Dart', 'Flutter SDK', 'Provider', 'HTTP'],
    'projectExamples': ['Weather App', 'Todo Manager'],
    'position': 0, // 0 - слева, 1 - справа
  },
  {
    'year': 'Год 2 (2024)',
    'level': 'Middle Level',
    'icon': Icons.rocket_launch, 
    'title': 'Продвинутые технологии',
    'description': 'Освоение сложных архитектурных паттернов, изучение BLoC, работа с нативным кодом и создание enterprise решений.',
    'stats': ['6 проектов'],
    'technologies': ['BLoC', 'Clean Architecture', 'Platform Channels', 'Unit Testing', 'Custom Plugins'],
    'projectExamples': ['Banking App', 'Healthcare Platform'],
    'position': 1,
  },
  // {
  //   'year': 'Год 3 (2025)',
  //   'level': 'Senior Level',
  //   'icon': Icons.trending_up,
  //   'title': 'Экспертиза и лидерство',
  //   'description': '',
  //   'stats': ['8 проектов'],
  //   'technologies': ['Riverpod', 'GraphQL', 'TensorFlow Lite', 'WebRTC'],
  //   'projectExamples': [],
  //   'position': 0,
  // },
];

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Левая колонка
        Expanded(
          child: Column(
            children: [
              for (int i = 0; i < _timelineData.length; i++)
                if (_timelineData[i]['position'] == 0)
                  TimelineItem(
                    data: _timelineData[i],
                    index: i,
                    isLeft: true,
                  ),
            ],
          ),
        ),

        // Центральная линия с кругами
        Container(
          width: 60,
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              for (int i = 0; i < _timelineData.length; i++)
                TimelineCircle(
                  index: i + 1,
                  isActive: true,
                  // isFuture: _timelineData[i]['isFuture'] ?? false,
                ),
            ],
          ),
        ),

        // Правая колонка
        Expanded(
          child: Column(
            children: [
              for (int i = 0; i < _timelineData.length; i++)
                if (_timelineData[i]['position'] == 1)
                  TimelineItem(
                    data: _timelineData[i],
                    index: i,
                    isLeft: false,
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        for (int i = 0; i < _timelineData.length; i++)
          Column(
            children: [
              TimelineCircle(
                index: i + 1,
                isActive: true,
                // isFuture: _timelineData[i]['isFuture'] ?? false,
              ),
              TimelineItem(
                data: _timelineData[i],
                index: i,
                isLeft: i % 2 == 0, // Определение позиции (четные - слева, нечетные - справа)
                isMobile: true,
              ),
            ],
          ),
      ],
    );
  }
}
