import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

class TimelineItem extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final bool isLeft;
  final bool isMobile;

  const TimelineItem({
    super.key,
    required this.data,
    required this.index,
    required this.isLeft,
    this.isMobile = false,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Контроллер анимации
  late Animation<Offset> _offsetAnimation; // Анимация смещения
  late Animation<double> _fadeAnimation; // Анимация прозрачности

  @override
  void initState() {
    super.initState();
    // создание
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this, // Провайдер кадров
    );
    // настройка
    _offsetAnimation =
        Tween<Offset>(
          begin: Offset(
            widget.isLeft ? -0.5 : 0.5,
            0.0,
          ), // Начальное положение (влево или вправо в зависимости от позиции)
          end: Offset.zero, // Конечное
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut, // Кривая анимации
          ),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    // Запуск анимации с задержкой
    Future.delayed(Duration(milliseconds: widget.index * 300), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  // Очистка ресурсов
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFuture = widget.data['isFuture'] ?? false;

    // Применение анимации
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: widget.isMobile ? double.infinity : 320,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isFuture
                ? AppColors.accentTeal.withOpacity(0.1)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isFuture
                  ? AppColors.accentTeal.withOpacity(0.4)
                  : AppColors.accentTeal.withOpacity(0.3),
              width: isFuture ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentTeal.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: widget.isLeft
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // Заголовок и год
              Text(
                widget.data['year'],
                style: TextStyle(
                  color: isFuture ? AppColors.accentTeal : AppColors.accentTeal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Уровень и эмодзи
              Row(
                mainAxisAlignment: widget.isLeft
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    widget.data['level'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(widget.data['icon']),
                ],
              ),
              const SizedBox(height: 16),

              // Заголовок этапа
              Text(
                widget.data['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                textAlign: widget.isLeft ? TextAlign.right : TextAlign.left,
              ),
              const SizedBox(height: 12),

              // Описание
              Text(
                widget.data['description'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: widget.isLeft ? TextAlign.right : TextAlign.left,
              ),
              const SizedBox(height: 16),

              // Статистика (только для прошлых этапов)
              if (!isFuture && widget.data['stats'].isNotEmpty)
                Wrap(
                  alignment: widget.isLeft
                      ? WrapAlignment.end
                      : WrapAlignment.start,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    for (var stat in widget.data['stats'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentTeal.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          stat,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),

              if (!isFuture && widget.data['stats'].isNotEmpty)
                const SizedBox(height: 16),

              // Технологии
              if (!isFuture && widget.data['technologies'].isNotEmpty) ...[
                const Text(
                  'Ключевые технологии:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  alignment: widget.isLeft
                      ? WrapAlignment.end
                      : WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    for (var tech in widget.data['technologies'])
                      Chip(
                        label: Text(tech, style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppColors.accentTeal.withOpacity(0.2),
                        labelStyle: const TextStyle(color: Colors.white),
                        side: BorderSide.none,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // Проекты
              if (!isFuture && widget.data['projectExamples'].isNotEmpty) ...[
                const Text(
                  'Крупные проекты:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: widget.isLeft
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    for (var project in widget.data['projectExamples'])
                      Text(
                        '• $project',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ],

              // Специальный контент для будущих планов
              if (isFuture) ...[
                const SizedBox(height: 16),
                _buildFuturePlans(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFuturePlans() {
    final plans = [
      {
        'icon': '💻',
        'title': 'Flutter для Web/Desktop',
        'subtitle': 'Освоение мультиплатформенной разработки',
      },
      {
        'icon': '🏗️',
        'title': 'Архитектура микросервисов',
        'subtitle': 'Глубокое изучение distributed systems',
      },
      {
        'icon': '🤖',
        'title': 'AI/ML экспертиза',
        'subtitle': 'Специализация на ИИ в мобильных приложениях',
      },
      {
        'icon': '📊',
        'title': 'Продуктовое мышление',
        'subtitle': 'Развитие навыков продакт-менеджмента',
      },
    ];

    return Column(
      crossAxisAlignment: widget.isLeft
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        for (var plan in plans)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentTeal.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.accentTeal.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: widget.isLeft
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (!widget.isLeft) ...[
                  Text(plan['icon']!, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: widget.isLeft
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        plan['subtitle']!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isLeft) ...[
                  const SizedBox(width: 12),
                  Text(plan['icon']!, style: const TextStyle(fontSize: 20)),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class TimelineCircle extends StatelessWidget {
  final int index;
  final bool isActive;
  // final bool isFuture;

  const TimelineCircle({
    super.key,
    required this.index,
    required this.isActive,
    // this.isFuture = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Вертикальная линия
          Container(
            width: 2,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.accentTeal.withOpacity(0.6),
                  AppColors.accentTeal.withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.2, 0.8, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Круг с цифрой
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: isFuture ? Colors.transparent : AppColors.accentTeal,
              color: AppColors.accentTeal,
              border: Border.all(
                // color: isFuture ? AppColors.accentTeal : Colors.white,
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                if (isActive)
                  BoxShadow(
                    color: AppColors.accentTeal.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
