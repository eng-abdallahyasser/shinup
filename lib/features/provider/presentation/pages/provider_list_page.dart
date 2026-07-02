
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/routes/app_pages.dart';
import 'package:shineup/features/provider/data/models/nearby_worker_model.dart';
import 'package:shineup/features/provider/domain/repositories/provider_repository.dart';

class ProviderListPage extends StatefulWidget {
  final String serviceId;
  final String serviceName;

  const ProviderListPage({
    super.key,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  State<ProviderListPage> createState() => _ProviderListPageState();
}

class _ProviderListPageState extends State<ProviderListPage> {
  final ProviderRepository _repository = sl<ProviderRepository>();

  List<NearbyWorkerResult> _workers = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  Future<void> _loadWorkers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      Position position;
      try {
        position = await Geolocator.getCurrentPosition();
      } catch (_) {
        position = Position(
          longitude: 46.6753,
          latitude: 24.7136,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      }

      final workers = await _repository.getNearbyWorkers(
        latitude: position.latitude,
        longitude: position.longitude,
        serviceIds: [widget.serviceId],
      );
      if (mounted) {
        setState(() {
          _workers = workers;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8FF),
        title: Text(
          widget.serviceName,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xFF191B23),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF737686),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadWorkers,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    if (_workers.isEmpty) {
      return Center(
        child: Text(
          'No providers available',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xFF737686),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
      itemCount: _workers.length,
      itemBuilder: (context, index) {
        return _WorkerCard(
          worker: _workers[index],
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRouter.providerDetail,
              arguments: _workers[index].providerMemberId,
            );
          },
        );
      },
    );
  }
}

class _WorkerCard extends StatelessWidget {
  final NearbyWorkerResult worker;
  final VoidCallback onTap;

  const _WorkerCard({required this.worker, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final firstItem = worker.items.isNotEmpty ? worker.items.first : null;
    final price = firstItem?.priceCustomer ?? '';
    final currency = firstItem?.currency ?? '';
    final duration = firstItem?.minutesDuration ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFF3F3FE)),
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
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 28,
                      color: Color(0xFF004AC6),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.memberDisplayName,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF191B23),
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (worker.companyName != null)
                        Text(
                          worker.companyName!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            height: 18 / 13,
                            color: Color(0xFF737686),
                          ),
                        ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: const Color(0xFF434655),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDistance(worker.distanceMeters),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 16 / 12,
                              color: Color(0xFF434655),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: const Color(0xFF434655),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${worker.minutesEta} min',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 16 / 12,
                              color: Color(0xFF434655),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (price.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$price $currency',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF191B23),
                        ),
                      ),
                      if (duration > 0)
                        Text(
                          '$duration min',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 16 / 12,
                            color: Color(0xFF737686),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
    return '${meters.toInt()} m';
  }
}
