import 'package:auto_motive/model/user_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/view/common%20widgets/custom_app_bar.dart';
import 'package:auto_motive/view/common%20widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      appBar: const CustomAppBar(
        title: 'User Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    user.name ?? 'John Doe',
                    style: AppTextStyles.white16BoldTextStyle,
                  ),
                  const SizedBox(height: 8.0),
                  const Row(),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.white),
                title: const Text(
                  'Phone Number:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: Text(
                  user.phoneNumber ?? '+1234567890',
                  style: AppTextStyles.white16TextStyle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.white),
                title: const Text(
                  'Email:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: Text(
                  user.email ?? 'johndoe@example.com',
                  style: AppTextStyles.white16TextStyle,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.white),
                title: const Text(
                  'Location:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: FutureBuilder<String?>(
                  future:
                      _getCityFromCoordinates(user.latitude, user.longitude),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text(
                        'Error fetching location data',
                        style: AppTextStyles.white16TextStyle,
                      );
                    } else {
                      return Text(
                        snapshot.data ?? 'Unknown',
                        style: AppTextStyles.white16TextStyle,
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const CustomCard(
              child: ListTile(
                leading: Icon(Icons.cake, color: Colors.white),
                title: Text(
                  'Date of Birth:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: Text(
                  "user.dateOfBirth" ?? 'N/A',
                  style: AppTextStyles.white16TextStyle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const CustomCard(
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'Gender:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: Text(
                  "user.gender" ?? 'N/A',
                  style: AppTextStyles.white16TextStyle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.build, color: Colors.white),
                title: const Text(
                  'Services:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: user.myServices.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: user.myServices
                            .map<Widget>((service) => Text(
                                  '- $service',
                                  style: AppTextStyles.white16TextStyle,
                                ))
                            .toList(),
                      )
                    : const Text(
                        'No services available',
                        style: AppTextStyles.white16TextStyle,
                      ),
              ),
            ),
            const SizedBox(height: 16.0),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.build_circle, color: Colors.white),
                title: const Text(
                  'Spare Parts:',
                  style: AppTextStyles.white16BoldTextStyle,
                ),
                subtitle: user.mySpareParts.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: user.mySpareParts
                            .map<Widget>((part) => Text(
                                  '- $part',
                                  style: AppTextStyles.white16TextStyle,
                                ))
                            .toList(),
                      )
                    : const Text(
                        'No spare parts available',
                        style: AppTextStyles.white16TextStyle,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _getCityFromCoordinates(
      double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) return null;
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        return placemarks[0].locality;
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
