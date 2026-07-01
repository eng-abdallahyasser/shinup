import 'package:flutter/material.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/features/profile/data/models/car_models.dart';
import 'package:shineup/features/profile/domain/repositories/profile_repository.dart';

class CarDetailPage extends StatefulWidget {
  final String carId;

  const CarDetailPage({super.key, required this.carId});

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

enum _CarDetailStatus { loading, loaded, saving, error }

class _CarDetailPageState extends State<CarDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _profileRepository = sl<ProfileRepository>();

  _CarDetailStatus _status = _CarDetailStatus.loading;
  String? _errorMessage;

  UserCarModel? _car;

  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _plateController = TextEditingController();

  bool _isDefault = false;
  bool _isSettingDefault = false;

  @override
  void initState() {
    super.initState();
    _loadCar();
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  Future<void> _loadCar() async {
    setState(() {
      _status = _CarDetailStatus.loading;
      _errorMessage = null;
    });
    try {
      final car = await _profileRepository.getCar(widget.carId);
      if (!mounted) return;
      setState(() {
        _car = car;
        _brandController.text = car.brand;
        _modelController.text = car.model;
        _yearController.text = car.year.toString();
        _colorController.text = car.color;
        _plateController.text = car.plateNumber;
        _isDefault = car.defaultIs;
        _status = _CarDetailStatus.loaded;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _CarDetailStatus.error;
        _errorMessage = AppLocalizations.of(context).failedLoadCar;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _status = _CarDetailStatus.saving;
      _errorMessage = null;
    });

    try {
      final request = UpdateCarRequest(
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        year: int.parse(_yearController.text.trim()),
        color: _colorController.text.trim(),
        plateNumber: _plateController.text.trim(),
      );
      await _profileRepository.updateCar(widget.carId, request);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _CarDetailStatus.loaded;
        _errorMessage = AppLocalizations.of(context).failedUpdateCar;
      });
    }
  }

  Future<void> _toggleDefault() async {
    setState(() => _isSettingDefault = true);
    try {
      await _profileRepository.setDefaultCar(widget.carId);
      if (!mounted) return;
      setState(() {
        _isDefault = true;
        _isSettingDefault = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSettingDefault = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).failedSetDefault)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF004AC6)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          t.editVehicleTitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF004AC6),
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(t),
    );
  }

  Widget _buildBody(AppLocalizations t) {
    switch (_status) {
      case _CarDetailStatus.loading:
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF004AC6)),
        );

      case _CarDetailStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.signal_wifi_off_rounded,
                  size: 48,
                  color: Color(0xFF737686),
                ),
                const SizedBox(height: 16),
                Text(
                  _errorMessage ?? t.failedLoadCar,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF434655),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _loadCar,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AC6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case _CarDetailStatus.loaded:
      case _CarDetailStatus.saving:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Car Type Info ─────────────────────────────────────
                Container(
                  width: double.infinity,
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
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEDEDF9),
                          borderRadius:
                              BorderRadius.all(Radius.circular(32)),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions_car_rounded,
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
                              _car!.displayName,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0xFF191B23),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_car!.carType.name} • ${_car!.plateNumber}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF737686),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Error Banner ──────────────────────────────────────
                if (_errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 18,
                          color: Color(0xFFE53935),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: Color(0xFFC62828),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // ── Form Fields ───────────────────────────────────────
                _buildField(t.carBrand, _brandController, t.enterBrand, false),
                const SizedBox(height: 16),
                _buildField(t.carModel, _modelController, t.enterModel, false),
                const SizedBox(height: 16),
                _buildField(t.carYear, _yearController, t.enterYear, true,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildField(t.carColor, _colorController, t.enterColor, false),
                const SizedBox(height: 16),
                _buildField(
                    t.carPlate, _plateController, t.enterPlate, false),
                const SizedBox(height: 32),

                // ── Set as Default ────────────────────────────────────
                Container(
                  width: double.infinity,
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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _isDefault
                              ? const Color(0xFF004AC6).withValues(alpha: 0.1)
                              : const Color(0xFFEDEDF9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.star_rounded,
                          size: 20,
                          color: _isDefault
                              ? const Color(0xFF004AC6)
                              : const Color(0xFFC3C6D7),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.setAsDefault,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFF191B23),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _isDefault
                                  ? t.defaultVehicleSubtitle
                                  : t.setDefaultSubtitle,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xFF737686),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isDefault)
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 20,
                          color: Color(0xFF004AC6),
                        )
                      else
                        TextButton(
                          onPressed: _isSettingDefault ? null : _toggleDefault,
                          child: _isSettingDefault
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF004AC6),
                                  ),
                                )
                              : Text(
                                  t.setDefaultBtn,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Color(0xFF004AC6),
                                  ),
                                ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ── Save Button ───────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed:
                        _status == _CarDetailStatus.saving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004AC6),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          const Color(0xFF004AC6).withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      elevation: 0,
                    ),
                    child: _status == _CarDetailStatus.saving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            t.save,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Delete Vehicle Button ───────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: _confirmDelete,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE53935),
                      side: const BorderSide(color: Color(0xFFE53935)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.delete_outline_rounded, size: 20),
                    label: Text(
                      t.deleteVehicle,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
    }
  }

  Future<void> _confirmDelete() async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF0F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Color(0xFFE53935),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              t.deleteVehicle,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF191B23),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.deleteVehicleConfirm,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF434655),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.deleteVehicleWarning,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Color(0xFF737686),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              t.cancel,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF737686),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              elevation: 0,
            ),
            child: Text(
              t.delete,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _status = _CarDetailStatus.saving);
      try {
        await _profileRepository.deleteCar(widget.carId);
        if (!mounted) return;
        Navigator.of(context).pop(true);
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _status = _CarDetailStatus.loaded;
          _errorMessage = AppLocalizations.of(context).failedDeleteCar;
        });
      }
    }
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    String validationMessage,
    bool isNumeric, {
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.6,
              color: Color(0xFF737686),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xFF191B23),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFF004AC6), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFFE53935), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
            errorStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: Color(0xFFE53935),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return validationMessage;
            }
            if (isNumeric) {
              final year = int.tryParse(value.trim());
              if (year == null || year < 1900 || year > 2100) {
                return AppLocalizations.of(context).validYear;
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
