import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

Widget buildFuturePlansSection() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.primaryDark.withOpacity(0.9), AppColors.primaryDark],
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
              style: TextStyle(fontSize: 18, color: Colors.white70),
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
                // Wrap(
                //   spacing: 20,
                //   runSpacing: 20,
                //   alignment: WrapAlignment.center,
                //   children: [
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
                //   ],
                // ),
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
            child: Icon(icon, color: AppColors.accentTeal, size: 24),
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
