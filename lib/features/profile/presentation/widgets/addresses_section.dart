import 'package:flutter/material.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/features/profile/data/models/address_models.dart';

class AddressesSection extends StatelessWidget {
  final List<AddressModel> addresses;
  final String myAddressesLabel;
  final String addAddressLabel;
  final String noAddressesLabel;
  final VoidCallback? onAddAddress;
  final void Function(AddressModel address)? onEditAddress;

  const AddressesSection({
    super.key,
    required this.addresses,
    required this.myAddressesLabel,
    required this.addAddressLabel,
    required this.noAddressesLabel,
    this.onAddAddress,
    this.onEditAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                myAddressesLabel.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.6,
                  color: Color(0xFF434655),
                ),
              ),
              GestureDetector(
                onTap: onAddAddress,
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
                      addAddressLabel,
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
        if (addresses.isEmpty)
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
                  Icons.location_on_outlined,
                  size: 48,
                  color: Color(0xFFC3C6D7),
                ),
                const SizedBox(height: 16),
                Text(
                  noAddressesLabel,
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
          ...addresses.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _AddressCard(
                  address: a,
                  onEdit: onEditAddress != null ? () => onEditAddress!(a) : null,
                ),
              )),
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onEdit;

  const _AddressCard({required this.address, this.onEdit});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    Icons.location_on_rounded,
                    size: 22,
                    color: Color(0xFF004AC6),
                  ),
                ),
              ),
              if (address.defaultIs)
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF191B23),
                      ),
                    ),
                    if (address.defaultIs) ...[
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
                  address.displayAddress,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF434655),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${address.city} • Building ${address.buildingNumber}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF737686),
                  ),
                ),
              ],
            ),
          ),
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
