import 'package:easy_localization/easy_localization.dart';
import 'package:finance_app/constants/styles/styles.dart';
import 'package:finance_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutCompanyScreen extends StatefulWidget {
  const AboutCompanyScreen({super.key});

  @override
  State<AboutCompanyScreen> createState() => _AboutCompanyScreenState();
}

class _AboutCompanyScreenState extends State<AboutCompanyScreen> {
  bool _isPermissionGranted = false;
  bool _isGettingLocation = false;
  double lat = 0.0;
  double lag = 0.0;

  void _savePlace(double lat, double lag) {
    setState(() {
      this.lat = lat;
      this.lag = lag;
      _isGettingLocation = false;
    });
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _isPermissionGranted = false;
        return;
      }
    }
    _isPermissionGranted = true;

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    _savePlace(lat, lng);
  }

  void openMap(double latitude, double longitude) async {
    final googleMapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch Google Maps";
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about_company'.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.usegalileo.ai/sdxl10/dd933011-02e8-4853-a636-95c9f3304dde.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('overview'.tr()),
                  const SizedBox(height: 8),
                  const Text(
                      'Brief description of the company overview, Brief description of the company overview, Brief description of the company overview.'),
                  const SizedBox(height: 24),
                  _buildSectionTitle('mission'.tr()),
                  const SizedBox(height: 8),
                  const Text('Brief description of the company mission.'),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('vision'.tr()),
                            const SizedBox(height: 8),
                            const Text(
                                'Brief description of the company vision, Brief description of the company vision, Brief description of the company vision.'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: 150,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://cdn.usegalileo.ai/sdxl10/938688d5-3427-4c2c-ad22-5506efdc8f3c.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildLocationTitle('location'.tr()),
                  const SizedBox(height: 16),
                  _isGettingLocation
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _isPermissionGranted
                          ? InkWell(
                              onTap: () {
                                openMap(lat, lag);
                              },
                              child: SizedBox(
                                height: 400,
                                width: double.infinity,
                                child: Image.network(
                                  'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lag=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lag&key=AIzaSyDlPpAa3dIzQ2wGeeGJXKt7NJu6_yGwFqw',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        AppStyles.primary)),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.about);
                                },
                                child: SizedBox(
                                  height: 48,
                                  child: Center(
                                    child: Text(
                                      'location_button'.tr(),
                                      style: AppStyles.menuButtonText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLocationTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
