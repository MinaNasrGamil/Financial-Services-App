import 'package:easy_localization/easy_localization.dart' as elocal;
import 'package:finance_app/constants/AppConstants.dart';
import 'package:finance_app/constants/styles/styles.dart';
import 'package:finance_app/utils/local_storage.dart';
import 'package:finance_app/utils/validators.dart';
import 'package:finance_app/view/widgets/form_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  ContactUsScreenState createState() => ContactUsScreenState();
}

class ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  Future<void> getDataFromLocalStorage() async {
    try {
      final contactData = await LocalStorage.loadContactForm();
      _nameCtrl.text = contactData['name'] ?? 'null';
      _phoneCtrl.text = contactData['phone'] ?? 'null';
      _messageCtrl.text = contactData['message'] ?? 'null';
    } catch (e) {
      debugPrint('error in getDataFromLocalStorage : $e');
    }
  }

  Future<void> saveDataInLocalStorage() async {
    debugPrint('i am in saveDataInLocalStorage');

    try {
      await LocalStorage.saveContactForm(
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        message: _messageCtrl.text,
      );
    } catch (e) {
      debugPrint('error in saveDataInLocalStorage : $e');
    }
  }

  @override
  void initState() {
    getDataFromLocalStorage();
    super.initState();
  }

  Future<void> openWhatsApp(String phoneNumber, {String? message}) async {
    // 1) Strip any “+” or non‐digit characters:
    final sanitized = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // 2) Build the WhatsApp URI:
    final uri = Uri.parse(
      'whatsapp://send?phone=$sanitized${message != null ? '&text=${Uri.encodeComponent(message)}' : ''}',
    );

    // 3) Try to launch it:
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to wa.me link (without "+") if the URI scheme fails:
      final fallback = Uri.parse(
          'https://wa.me/$sanitized${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}');
      if (await canLaunchUrl(fallback)) {
        await launchUrl(fallback, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp with either URI or fallback URL';
      }
    }
  }

  Future<void> sendEmail(
    String toEmail, {
    String subject = '',
    String body = '',
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );

    if (await canLaunchUrl(uri)) {
      // let Android/iOS show the chooser
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch email app';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contact_us'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: _contactInfo(
                  AppConstants.contactPhone, FontAwesomeIcons.whatsapp),
              onTap: () {
                openWhatsApp(AppConstants.contactPhone);
              },
            ),
            ListTile(
              title: _contactInfo(
                  AppConstants.contactEmail, FontAwesomeIcons.google),
              onTap: () {
                sendEmail(AppConstants.contactEmail);
              },
            ),
            Form(
              key: _formKey,
              child: Expanded(
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
                      FormInput(
                        label: 'message'.tr(),
                        controller: _messageCtrl,
                        validator: Validators.nonEmpty,
                        maxLines: 4,
                        onEditingComplete: saveDataInLocalStorage,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Thank you! We will contact you soon.'),
                              ),
                            );
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _contactInfo(String text, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffF5D9D9),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(
                iconData,
                size: 24,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
