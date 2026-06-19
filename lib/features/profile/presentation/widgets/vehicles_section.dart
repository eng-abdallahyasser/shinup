import 'package:flutter/material.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/features/profile/data/models/car_models.dart';

class VehiclesSection extends StatelessWidget {
  final List<UserCarModel> vehicles;
  final String myVehiclesLabel;
  final String addVehicleLabel;
  final String noVehiclesLabel;
  final VoidCallback? onAddVehicle;
  final void Function(UserCarModel vehicle)? onEditCar;

  const VehiclesSection({
    super.key,
    required this.vehicles,
    required this.myVehiclesLabel,
    required this.addVehicleLabel,
    required this.noVehiclesLabel,
    this.onAddVehicle,
    this.onEditCar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                myVehiclesLabel.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.6,
                  color: Color(0xFF434655),
                ),
              ),
              GestureDetector(
                onTap: onAddVehicle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      size: 14,
                      color: Color(0xFF004AC6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      addVehicleLabel,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF004AC6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (vehicles.isEmpty)
          // Empty state card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
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
                const Icon(
                  Icons.directions_car_outlined,
                  size: 48,
                  color: Color(0xFFC3C6D7),
                ),
                const SizedBox(height: 16),
                Text(
                  noVehiclesLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF737686),
                  ),
                ),
              ],
            ),
          )
        else
          // Vehicle cards
          ...vehicles.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _VehicleCard(
                  vehicle: v,
                  onEdit: onEditCar != null ? () => onEditCar!(v) : null,
                ),
              )),
      ],
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final UserCarModel vehicle;
  final VoidCallback? onEdit;

  const _VehicleCard({required this.vehicle, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Vehicle icon
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFEDEDF9),
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: const Center(
                  child: Icon(
                    Icons.directions_car_rounded,
                    size: 22,
                    color: Color(0xFF004AC6),
                  ),
                ),
              ),
              if (vehicle.defaultIs)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFF004AC6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Vehicle info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      vehicle.displayName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF191B23),
                      ),
                    ),
                    if (vehicle.defaultIs) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF004AC6).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          AppLocalizations.of(context).defaultBadge,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Color(0xFF004AC6),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  vehicle.plateNumber,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF434655),
                  ),
                ),
              ],
            ),
          ),
          // Edit button
          IconButton(
            onPressed: onEdit,
            icon: const Icon(
              Icons.edit_outlined,
              size: 18,
              color: Color(0xFF737686),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}
