import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  // Contact form
  static Future<void> saveContactForm(
      {String? name, String? phone, String? message}) async {
    debugPrint('i am in saveContactForm');

    final prefs = await _prefs;
    if (name != null) prefs.setString('contact_name', name);
    if (phone != null) prefs.setString('contact_phone', phone);
    if (message != null) prefs.setString('contact_message', message);
  }

  static Future<Map<String, String>> loadContactForm() async {
    final prefs = await _prefs;
    return {
      'name': prefs.getString('contact_name') ?? '',
      'phone': prefs.getString('contact_phone') ?? '',
      'message': prefs.getString('contact_message') ?? '',
    };
  }

  // Complaint form
  static Future<void> saveComplaintForm(
      {String? name, String? phone, String? type, String? details}) async {
    final prefs = await _prefs;
    if (name != null) prefs.setString('complaint_name', name);
    if (phone != null) prefs.setString('complaint_phone', phone);
    if (type != null) prefs.setString('complaint_type', type);
    if (details != null) prefs.setString('complaint_details', details);
  }

  static Future<Map<String, String>> loadComplaintForm() async {
    final prefs = await _prefs;
    return {
      'name': prefs.getString('complaint_name') ?? '',
      'phone': prefs.getString('complaint_phone') ?? '',
      'type': prefs.getString('complaint_type') ?? '',
      'details': prefs.getString('complaint_details') ?? '',
    };
  }
}
