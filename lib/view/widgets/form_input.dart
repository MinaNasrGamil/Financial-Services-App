import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String label;
  final String? Function(String?) validator;
  final void Function() onEditingComplete;
  final TextEditingController controller;
  final int maxLines;

  const FormInput({
    super.key,
    required this.label,
    required this.validator,
    required this.onEditingComplete,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            onEditingComplete: onEditingComplete,
            controller: controller,
            validator: validator,
            maxLines: maxLines,
            decoration: InputDecoration(
              label: Text(
                'input_label'.tr() + ' $label',
                style: TextStyle(color: Color(0xff737373)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
