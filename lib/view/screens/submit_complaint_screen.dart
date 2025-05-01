import 'package:easy_localization/easy_localization.dart';
import 'package:finance_app/constants/enums/status_enum.dart';
import 'package:finance_app/constants/styles/styles.dart';
import 'package:finance_app/data/models/complaint.dart';
import 'package:finance_app/logic/cubits/complaint/complaint_cubit.dart';
import 'package:finance_app/utils/local_storage.dart';
import 'package:finance_app/utils/validators.dart';
import 'package:finance_app/view/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitComplaintScreen extends StatefulWidget {
  const SubmitComplaintScreen({super.key});

  @override
  SubmitComplaintScreenState createState() => SubmitComplaintScreenState();
}

class SubmitComplaintScreenState extends State<SubmitComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();
  ComplaintTypeEnum? _type;

  Future<void> _getDataFromLocalStorage() async {
    try {
      final contactData = await LocalStorage.loadContactForm();
      _nameCtrl.text = contactData['name'] ?? 'null';
      _phoneCtrl.text = contactData['phone'] ?? 'null';
      _detailsCtrl.text = contactData['message'] ?? 'null';
    } catch (e) {
      debugPrint('error in getDataFromLocalStorage : $e');
    }
  }

  Future<void> saveDataInLocalStorage() async {
    try {
      await LocalStorage.saveComplaintForm(
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        details: _detailsCtrl.text,
        type: _type.toString(),
      );
    } catch (e) {
      debugPrint('error in saveDataInLocalStorage : $e');
    }
  }

  @override
  void initState() {
    _getDataFromLocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('submit_complaint'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ComplaintCubit, ComplaintState>(
          listener: (context, state) {
            if (state.status == StatusEnum.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Complaint submitted successfully')),
              );
            }
            if (state.status == StatusEnum.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormInput(
                      label: 'name'.tr(),
                      controller: _nameCtrl,
                      validator: Validators.nonEmpty,
                      onEditingComplete: saveDataInLocalStorage,
                    ),
                    FormInput(
                      label: 'phone'.tr(),
                      controller: _phoneCtrl,
                      validator: Validators.phone,
                      onEditingComplete: saveDataInLocalStorage,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField<ComplaintTypeEnum>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'complaint_type'.tr(),
                        ),
                        value: _type,
                        items: ComplaintTypeEnum.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString().split('.').last),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _type = v),
                        validator: (v) =>
                            v == null ? 'Please select a type' : null,
                      ),
                    ),
                    FormInput(
                      label: 'details'.tr(),
                      controller: _detailsCtrl,
                      validator: Validators.nonEmpty,
                      maxLines: 4,
                      onEditingComplete: saveDataInLocalStorage,
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.status == StatusEnum.loading
                          ? const CircularProgressIndicator(
                              key: ValueKey('loading'))
                          : ElevatedButton(
                              key: const ValueKey('submitBtn'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // submit logic
                                  final complaint = Complaint(
                                    name: _nameCtrl.text,
                                    phone: _phoneCtrl.text,
                                    type: _type!,
                                    details: _detailsCtrl.text,
                                  );
                                  context
                                      .read<ComplaintCubit>()
                                      .submitComplaint(complaint);
                                }
                              },
                              style: AppStyles.menuButton,
                              child: SizedBox(
                                  height: 48,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'submit'.tr(),
                                      style: AppStyles.menuButtonText,
                                    ),
                                  )),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
