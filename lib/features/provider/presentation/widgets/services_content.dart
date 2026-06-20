import 'package:flutter/material.dart';

// ═════════════════════════════════════════════════════════════════════════════
//  Service Data
// ═════════════════════════════════════════════════════════════════════════════

class ServiceData {
  final String name;
  final String description;
  final String price;
  final String duration;

  const ServiceData({
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });
}

// ═════════════════════════════════════════════════════════════════════════════
//  Services Content
// ═════════════════════════════════════════════════════════════════════════════

class ServicesContent extends StatelessWidget {
  const ServicesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      color: const Color(0xFFFAF8FF),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Wash & Care group ─────────────────────────────────
          ServiceGroup(
            icon: Icons.local_car_wash_outlined,
            title: 'Wash & Care',
            services: [
              ServiceData(
                name: 'Exterior Wash',
                description:
                    'Full exterior hand wash with premium shampoo and spot-free rinse.',
                price: '\$35',
                duration: '30 min',
              ),
              ServiceData(
                name: 'Interior Detail',
                description:
                    'Complete interior cleaning including vacuum, dashboard, and windows.',
                price: '\$65',
                duration: '45 min',
              ),
            ],
          ),
          SizedBox(height: 24),
          // ── Repair & Maintenance group ────────────────────────
          ServiceGroup(
            icon: Icons.build_outlined,
            title: 'Repairs & Maintenance',
            services: [
              ServiceData(
                name: 'Oil Change',
                description:
                    'Full synthetic oil change with filter replacement and fluid top-up.',
                price: '\$45',
                duration: '20 min',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Service Group
// ═════════════════════════════════════════════════════════════════════════════

class ServiceGroup extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<ServiceData> services;

  const ServiceGroup({
    super.key,
    required this.icon,
    required this.title,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
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
        // Service cards
        ...List.generate(services.length, (index) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: index < services.length - 1 ? 16 : 0),
            child: ServiceCard(data: services[index]),
          );
        }),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
//  Service Card
// ═════════════════════════════════════════════════════════════════════════════

class ServiceCard extends StatelessWidget {
  final ServiceData data;

  const ServiceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEDEDF9)),
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
          // ── Top row: Name + description + price ───────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name + description
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
              // Price
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
          // ── Bottom row: Duration + Add button ─────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Duration
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 15,
                    color: const Color(0xFF434655),
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
              // Add button
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFC3C6D7)),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 21 / 14,
                    color: Color(0xFF191B23),
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
