import 'package:flutter/material.dart';
import 'package:shineup/core/di/service_locator.dart';
import 'package:shineup/core/localization/app_localizations.dart';
import 'package:shineup/core/network/api_client.dart';
import 'package:shineup/features/profile/data/models/car_models.dart';
import 'package:shineup/features/profile/domain/repositories/profile_repository.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  final _profileRepository = sl<ProfileRepository>();

  // Form fields
  String? _selectedCarTypeId;
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _plateController = TextEditingController();
  bool _defaultIs = true;

  // State
  List<CarTypeModel> _carTypes = [];
  bool _isLoadingTypes = true;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCarTypes();
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

  Future<void> _loadCarTypes() async {
    setState(() {
      _isLoadingTypes = true;
      _errorMessage = null;
    });
    try {
      final types = await _profileRepository.getCarTypes();
      if (!mounted) return;
      setState(() {
        _carTypes = types;
        _isLoadingTypes = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingTypes = false;
        _errorMessage = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoadingTypes = false;
        _errorMessage = AppLocalizations.of(context).failedCarTypes;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCarTypeId == null) {
      setState(() {
        _errorMessage = AppLocalizations.of(context).selectCarType;
        _isSubmitting = false;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final request = AddCarRequest(
        carTypeId: _selectedCarTypeId!,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        year: int.parse(_yearController.text.trim()),
        color: _colorController.text.trim(),
        plateNumber: _plateController.text.trim(),
        defaultIs: _defaultIs,
      );
      await _profileRepository.addCar(request);
      if (!mounted) return;
      Navigator.of(context).pop(true); // true = added successfully
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = AppLocalizations.of(context).failedAddCar;
      });
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: Color(0xFF004AC6)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          t.addVehicleTitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF004AC6),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Error message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Color(0xFFBA1A1A),
                    ),
                  ),
                ),

              // Car Type dropdown
              if (_isLoadingTypes)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(
                      color: Color(0xFF004AC6),
                    ),
                  ),
                )
              else
                _buildDropdown(
                  label: t.carType,
                  initialValue: _selectedCarTypeId,
                  items: _carTypes,
                  displayName: (ct) => ct.name,
                  onChanged: (v) => setState(() => _selectedCarTypeId = v),
                  validator: (v) => v == null ? t.selectCarType : null,
                ),
              const SizedBox(height: 16),

              // Brand
              _buildTextField(
                label: t.carBrand,
                controller: _brandController,
                hint: 'e.g. Toyota',
                validator: (v) => v == null || v.trim().isEmpty ? t.enterBrand : null,
              ),
              const SizedBox(height: 16),

              // Model
              _buildTextField(
                label: t.carModel,
                controller: _modelController,
                hint: 'e.g. Camry',
                validator: (v) => v == null || v.trim().isEmpty ? t.enterModel : null,
              ),
              const SizedBox(height: 16),

              // Year
              _buildTextField(
                label: t.carYear,
                controller: _yearController,
                hint: 'e.g. 2024',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return t.enterYear;
                  final year = int.tryParse(v.trim());
                  if (year == null || year < 1886 || year > DateTime.now().year + 1) {
                    return t.validYear;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Color
              _buildTextField(
                label: t.carColor,
                controller: _colorController,
                hint: 'e.g. White',
                validator: (v) => v == null || v.trim().isEmpty ? t.enterColor : null,
              ),
              const SizedBox(height: 16),

              // Plate Number
              _buildTextField(
                label: t.carPlate,
                controller: _plateController,
                hint: 'e.g. ABC-1234',
                validator: (v) => v == null || v.trim().isEmpty ? t.enterPlate : null,
              ),
              const SizedBox(height: 16),

              // Default checkbox
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _defaultIs,
                        onChanged: (v) => setState(() => _defaultIs = v ?? true),
                        activeColor: const Color(0xFF004AC6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      t.carDefault,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF191B23),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AC6),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFC3C6D7),
                    disabledForegroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          t.addCarBtn,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? initialValue,
    required List<CarTypeModel> items,
    required String Function(CarTypeModel) displayName,
    required ValueChanged<String?> onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4.5),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Color(0xFF434655),
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF004AC6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((ct) {
            return DropdownMenuItem(
              value: ct.id,
              child: Text(
                displayName(ct),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xFF191B23),
                ),
              ),
            );
          }).toList(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFF191B23),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4.5),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Color(0xFF434655),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFF191B23),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFF6B7280),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF004AC6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
