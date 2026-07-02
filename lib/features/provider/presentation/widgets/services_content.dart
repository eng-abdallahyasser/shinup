import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';

class ServiceData {
  final String id;
  final String name;
  final String description;
  final String price;
  final String duration;

  const ServiceData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });
}

class ServiceCategoryGroup {
  final String categoryName;
  final List<ServiceData> services;

  const ServiceCategoryGroup({
    required this.categoryName,
    required this.services,
  });
}

class ServicesContent extends StatelessWidget {
  final List<ServiceCategoryGroup> groups;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const ServicesContent({
    super.key,
    required this.groups,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      color: const Color(0xFFFAF8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(groups.length, (index) {
          final isLast = index == groups.length - 1;
          return Column(
            children: [
              ServiceGroup(
                icon: Icons.local_car_wash_outlined,
                title: groups[index].categoryName,
                services: groups[index].services,
                selectedIds: selectedIds,
                onToggle: onToggle,
              ),
              if (!isLast) const SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }
}

class ServiceGroup extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<ServiceData> services;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const ServiceGroup({
    super.key,
    required this.icon,
    required this.title,
    required this.services,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF004AC6)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 28 / 20,
                color: Color(0xFF191B23),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(services.length, (index) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: index < services.length - 1 ? 16 : 0),
            child: ServiceCard(
              data: services[index],
              isSelected: selectedIds.contains(services[index].id),
              onToggle: onToggle,
            ),
          );
        }),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final ServiceData data;
  final bool isSelected;
  final ValueChanged<String> onToggle;

  const ServiceCard({
    super.key,
    required this.data,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected
              ? const Color(0xFF004AC6)
              : const Color(0xFFEDEDF9),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF191B23),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.description,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xFF434655),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                child: Text(
                  data.price,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 24 / 16,
                    color: Color(0xFF004AC6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 15,
                    color: Color(0xFF434655),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.duration,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 20 / 14,
                      color: Color(0xFF434655),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => onToggle(data.id),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF004AC6)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF004AC6)
                          : const Color(0xFFC3C6D7),
                    ),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    isSelected
                        ? AppLocalizations.of(context).providerServiceAdded
                        : AppLocalizations.of(context).providerServiceAdd,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 21 / 14,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF191B23),
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
}
