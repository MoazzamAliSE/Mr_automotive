import 'package:auto_motive/main.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/view%20model/controller/add_services_controller.dart';
import 'package:auto_motive/view%20model/controller/add_spare_part_controller.dart';
import 'package:auto_motive/view/add_services/service/components/enum_type.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OpenMap extends StatefulWidget {
  const OpenMap({super.key, required this.serviceType});

  final MapScreenType serviceType;

  @override
  State<OpenMap> createState() => _OpenMapState();
}

class _OpenMapState extends State<OpenMap> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
                onTap: (argument) async {
                  try {
                    setState(() {
                      isLoading=true;
                    });
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      argument.latitude,
                      argument.longitude,
                    );
                    if (widget.serviceType == MapScreenType.service) {
                      Get.put(AddServiceController()).location.text =
                      '${placemarks[0].locality}, ${placemarks[0].country}';
                      Get.put(AddServiceController()).longitude = argument.longitude;
                      Get.put(AddServiceController()).latitude = argument.latitude;
                      Get.put(AddServiceController()).selectedLocation.value =
                      '${placemarks[0].locality}, ${placemarks[0].country}';
                    } else {
                      Get.put(AddSparePartController()).location.text =
                      '${placemarks[0].locality}, ${placemarks[0].country}';
                      Get.put(AddSparePartController()).longitude =
                          argument.longitude;
                      Get.put(AddSparePartController()).latitude = argument.latitude;
                      Get.put(AddSparePartController()).selectedLocation.value =
                      '${placemarks[0].locality}, ${placemarks[0].country}';
                    }
                    Get.back();
                    setState(() {
                      isLoading=false;
                    });
                  } catch (_) {
                    setState(() {
                      isLoading=false;
                    });
                    print(_.toString());
                  }
                },
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(localUser!.latitude!, localUser!.longitude!),
                  zoom: 14,
                )),
           if(isLoading) Container(
              color: Colors.black45,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Get location...',style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

//
// class OpenMap extends StatelessWidget {
//   const OpenMap({super.key, required this.screenType});
//
//   final MapScreenType screenType;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: darkBackgroundColor,
//       body: SafeArea(
//         child: FlutterMap(
//           options: MapOptions(
//             initialCenter:  lt.LatLng(localUser!.latitude!, localUser!.longitude!),
//             onTap: (tapPosition, point) async {
//               try {
//                 List<Placemark> placemarks = await placemarkFromCoordinates(
//                   point.latitude,
//                   point.longitude,
//                 );
//                 if (screenType == MapScreenType.service) {
//                   Get.put(AddServiceController()).location.text =
//                       '${placemarks[0].locality}, ${placemarks[0].country}';
//                   Get.put(AddServiceController()).longitude = point.longitude;
//                   Get.put(AddServiceController()).latitude = point.latitude;
//                   Get.put(AddServiceController()).selectedLocation.value =
//                       '${placemarks[0].locality}, ${placemarks[0].country}';
//                 }else{
//                   Get.put(AddSparePartController()).location.text =
//                   '${placemarks[0].locality}, ${placemarks[0].country}';
//                   Get.put(AddSparePartController()).longitude = point.longitude;
//                   Get.put(AddSparePartController()).latitude = point.latitude;
//                   Get.put(AddSparePartController()).selectedLocation.value =
//                   '${placemarks[0].locality}, ${placemarks[0].country}';
//                 }
//                 Get.back();
//               } catch (_) {}
//             },
//           ),
//           children: [
//             TileLayer(
//               urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               // subdomains: ['a', 'b', 'c'],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
