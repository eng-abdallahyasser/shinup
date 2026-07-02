import 'package:flutter/material.dart';
import 'package:shineup/core/localization/app_localizations.dart';

class BottomCta extends StatelessWidget {
  final double totalCost;
  final int itemCount;
  final VoidCallback? onBookNow;

  const BottomCta({
    super.key,
    this.totalCost = 0,
    this.itemCount = 0,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFFAF8FF),
          border: Border(
            top: BorderSide(color: Color(0xFFC3C6D7)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Price info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemCount > 0
                      ? '$itemCount ${t.providerCtaServices}'
                      : t.providerCtaTotal,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 16 / 12,
                    letterSpacing: 0.6,
                    color: Color(0xFF737686),
                  ),
                ),
                Text(
                  itemCount > 0 ? '\$${totalCost.toStringAsFixed(0)}' : t.providerCtaSelectServices,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 28 / 20,
                    color: itemCount > 0
                        ? const Color(0xFF191B23)
                        : const Color(0xFF737686),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Book Now button
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: itemCount > 0 ? onBookNow : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AC6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    disabledBackgroundColor: const Color(0xFFC3C6D7),
                    disabledForegroundColor: const Color(0xFF737686),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  child: Text(
                    t.providerCtaBookNow,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 24 / 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
