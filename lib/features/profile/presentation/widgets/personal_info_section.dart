import 'package:flutter/material.dart';

class PersonalInfoSection extends StatefulWidget {
  final bool isEditing;
  final String fullName;
  final String email;
  final String phone;
  final String personalInfoLabel;
  final String fullNameLabel;
  final String emailAddressLabel;
  final String phoneNumberLabel;
  final String editLabel;
  final String saveLabel;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onSave;

  const PersonalInfoSection({
    super.key,
    required this.isEditing,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.personalInfoLabel,
    required this.fullNameLabel,
    required this.emailAddressLabel,
    required this.phoneNumberLabel,
    required this.editLabel,
    required this.saveLabel,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onSave,
  });

  @override
  State<PersonalInfoSection> createState() => _PersonalInfoSectionState();
}

class _PersonalInfoSectionState extends State<PersonalInfoSection> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void didUpdateWidget(PersonalInfoSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync controllers when data changes externally while not editing
    if (!widget.isEditing) {
      if (oldWidget.fullName != widget.fullName) {
        _nameController.text = widget.fullName;
      }
      if (oldWidget.email != widget.email) {
        _emailController.text = widget.email;
      }
      if (oldWidget.phone != widget.phone) {
        _phoneController.text = widget.phone;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            widget.personalInfoLabel,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
              color: Color(0xFF434655),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Card
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
          child: Column(
            children: [
              _buildField(
                label: widget.fullNameLabel,
                controller: _nameController,
                onChanged: widget.onNameChanged,
                readOnly: !widget.isEditing,
              ),
              const SizedBox(height: 16),
              _buildField(
                label: widget.emailAddressLabel,
                controller: _emailController,
                onChanged: widget.onEmailChanged,
                readOnly: !widget.isEditing,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildPhoneField(
                label: widget.phoneNumberLabel,
                controller: _phoneController,
                onChanged: widget.onPhoneChanged,
                readOnly: !widget.isEditing,
              ),
              const SizedBox(height: 16),
              // Save button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: widget.isEditing ? widget.onSave : null,
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
                  child: Text(
                    widget.saveLabel,
                    style: const TextStyle(
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
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: Color(0xFF434655),
          ),
        ),
        const SizedBox(height: 4.5),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFF191B23),
          ),
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
            filled: readOnly,
            fillColor: readOnly ? const Color(0xFFF8F8FC) : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: Color(0xFF434655),
          ),
        ),
        const SizedBox(height: 4.5),
        Stack(
          children: [
            TextField(
              controller: controller,
              readOnly: readOnly,
              onChanged: onChanged,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF191B23),
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 64,
                  top: 13,
                  bottom: 13,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF004AC6)),
                ),
                filled: readOnly,
                fillColor:
                    readOnly ? const Color(0xFFF8F8FC) : Colors.transparent,
              ),
            ),
            if (widget.isEditing)
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Edit phone action - can be customized
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        widget.editLabel,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: Color(0xFF004AC6),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
