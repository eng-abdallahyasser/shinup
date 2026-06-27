import 'package:flutter/material.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/features/profile/data/models/address_models.dart';
import 'package:shinup/features/profile/domain/repositories/profile_repository.dart';

class AddressDetailPage extends StatefulWidget {
  final String addressId;

  const AddressDetailPage({super.key, required this.addressId});

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

enum _AddressDetailStatus { loading, loaded, saving, error }

class _AddressDetailPageState extends State<AddressDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _profileRepository = sl<ProfileRepository>();

  _AddressDetailStatus _status = _AddressDetailStatus.loading;
  String? _errorMessage;

  AddressModel? _address;

  final _titleController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isDefault = false;
  bool _isSettingDefault = false;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadAddress() async {
    _status = _AddressDetailStatus.loading;
    _errorMessage = null;
    if (mounted) setState(() {});
    try {
      final address = await _profileRepository.getAddress(widget.addressId);
      if (!mounted) return;
      _address = address;
      _titleController.text = address.title;
      _cityController.text = address.city;
      _areaController.text = address.area;
      _streetController.text = address.street;
      _buildingController.text = address.buildingNumber;
      _notesController.text = address.notes ?? '';
      _isDefault = address.defaultIs;
      _status = _AddressDetailStatus.loaded;
      if (mounted) setState(() {});
    } catch (_) {
      if (!mounted) return;
      _status = _AddressDetailStatus.error;
      _errorMessage = AppLocalizations.of(context).failedLoadAddress;
      if (mounted) setState(() {});
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    _status = _AddressDetailStatus.saving;
    _errorMessage = null;
    if (mounted) setState(() {});

    try {
      final request = UpdateAddressRequest(
        title: _titleController.text.trim(),
        city: _cityController.text.trim(),
        area: _areaController.text.trim(),
        street: _streetController.text.trim(),
        buildingNumber: _buildingController.text.trim(),
        notes: _notesController.text.trim(),
      );
      await _profileRepository.updateAddress(widget.addressId, request);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      _status = _AddressDetailStatus.loaded;
      _errorMessage = AppLocalizations.of(context).failedUpdateAddress;
      if (mounted) setState(() {});
    }
  }

  Future<void> _toggleDefault() async {
    _isSettingDefault = true;
    if (mounted) setState(() {});
    try {
      await _profileRepository.setDefaultAddress(widget.addressId);
      if (!mounted) return;
      _isDefault = true;
      _isSettingDefault = false;
      if (mounted) setState(() {});
    } catch (_) {
      if (!mounted) return;
      _isSettingDefault = false;
      if (mounted) setState(() {});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context).failedSetDefaultAddress)),
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
          t.editAddressTitle,
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
      case _AddressDetailStatus.loading:
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF004AC6)),
        );

      case _AddressDetailStatus.error:
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
                  _errorMessage ?? t.failedLoadAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF434655),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _loadAddress,
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

      case _AddressDetailStatus.loaded:
      case _AddressDetailStatus.saving:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.location_on_rounded,
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
                              _address!.title,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0xFF191B23),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _address!.displayAddress,
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

                _buildField(
                    t.addressTitle, _titleController, t.enterAddressTitle),
                const SizedBox(height: 16),
                _buildField(t.addressCity, _cityController, t.enterCity),
                const SizedBox(height: 16),
                _buildField(t.addressArea, _areaController, t.enterArea),
                const SizedBox(height: 16),
                _buildField(t.addressStreet, _streetController, t.enterStreet),
                const SizedBox(height: 16),
                _buildField(
                    t.addressBuilding, _buildingController, t.enterBuilding),
                const SizedBox(height: 16),
                _buildField(t.addressNotes, _notesController, null,
                    required: false),
                const SizedBox(height: 24),

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
                              t.setAsDefaultAddress,
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
                                  ? t.defaultAddressSubtitle
                                  : t.setDefaultAddressSubtitle,
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
                          onPressed:
                              _isSettingDefault ? null : _toggleDefault,
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

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed:
                        _status == _AddressDetailStatus.saving ? null : _save,
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
                    child: _status == _AddressDetailStatus.saving
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
                      t.deleteAddress,
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
              t.deleteAddress,
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
              t.deleteAddressConfirm,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF434655),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.deleteAddressWarning,
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
      _status = _AddressDetailStatus.saving;
      if (mounted) setState(() {});
      try {
        await _profileRepository.deleteAddress(widget.addressId);
        if (!mounted) return;
        Navigator.of(context).pop(true);
      } catch (_) {
        if (!mounted) return;
        _status = _AddressDetailStatus.loaded;
        _errorMessage = AppLocalizations.of(context).failedDeleteAddress;
        if (mounted) setState(() {});
      }
    }
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    String? validationMessage, {
    bool required = true,
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
              borderSide:
                  const BorderSide(color: Color(0xFF004AC6), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
            errorStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: Color(0xFFE53935),
            ),
          ),
          validator: required
              ? (v) =>
                  v == null || v.trim().isEmpty ? validationMessage : null
              : null,
        ),
      ],
    );
  }
}
