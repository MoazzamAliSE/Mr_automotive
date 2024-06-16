import 'package:auto_motive/main.dart';
import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/utils/utils.dart';
import 'package:auto_motive/view%20model/controller/fav_controller.dart';
import 'package:auto_motive/view%20model/controller/map_controller_obx.dart';
import 'package:auto_motive/view/available_services/available_services.dart';
import 'package:auto_motive/view/book_appointment/book_appointment.dart';
import 'package:auto_motive/view/common%20widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  double latitude = localUser!.latitude!;
  double longitude = localUser!.longitude!;
  final PolylinePoints polylinePoints = PolylinePoints();

  bool haveCurrentPosition = false;
  final List<Map> _coordinates = [];
  final scrollController = ScrollController();
  final controller = MapControllerObx();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

//   // Function to fetch route polyline points using Google Directions API
//   Future<List<LatLng>> fetchRoutePoints(LatLng origin, LatLng destination) async {
//     String apiUrl = "https://maps.googleapis.com/maps/api/directions/json" +
//         "?origin=${origin.latitude},${origin.longitude}" +
//         "&destination=${destination.latitude},${destination.longitude}" +
//         "&key=AIzaSyBr7Lm4Bg-NITFUTckkPHBdacMgNhSl8Z8"; // Replace with your Google Maps API key
//
//     final response = await http.get(Uri.parse(apiUrl));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print(data);
//       List<LatLng> points = [];
//       if (data["routes"].isNotEmpty) {
//         // Extract polyline points from the first route
//         List<dynamic> steps = data["routes"][0]["legs"][0]["steps"];
//         for (var step in steps) {
//           String pointsEncoded = step["polyline"]["points"];
//           points.addAll(_decodePolyline(pointsEncoded));
//         }
//       }
//       return points;
//     } else {
//       throw Exception('Failed to load route');
//     }
//   }
//
// // Function to decode polyline points
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;
//
//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;
//
//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;
//
//       double latitude = lat / 1E5;
//       double longitude = lng / 1E5;
//       points.add(LatLng(latitude, longitude));
//     }
//     return points;
//   }
//
// // Modify your drawRoute function to use fetchRoutePoints
//   void drawRoute(LatLng destination) async {
//     LatLng origin = LatLng(latitude, longitude); // Your current location
//     List<LatLng> routePoints = await fetchRoutePoints(origin, destination);
//
//     controller.polylines.clear();
//     controller.polylines.add(Polyline(
//       polylineId: const PolylineId('route'),
//       points: routePoints,
//       color: Colors.blue,
//       width: 3,
//     ));
//   }

  final Set<Marker> _markers = {};
  _calculateDistances() {
    for (var coords in _coordinates) {
      double distanceInMeters = Geolocator.distanceBetween(
        latitude,
        longitude,
        coords['cor'].latitude,
        coords['cor'].longitude,
      );
      _addMarker(coords['cor'], distanceInMeters / 1000, coords['data'],
          coords['isOther']); // Convert to kilometers
    }
  }

  void _addMarker(
      LatLng position, double distance, ServiceModel model, bool isOther) {
    final marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(
            isOther ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueBlue),
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: isOther
            ? InfoWindow(
                title: 'Book Appointment',
                onTap: () {
                  Get.to(() => BookAppointment(service: model));
                },
                snippet: '${distance.toStringAsFixed(1)} Km away',
              )
            : InfoWindow.noText);
    _markers.add(marker);
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.back();
        Utils.showSnackBar(
            'Error',
            'Location permissions are denied',
            const Icon(
              Icons.warning_amber,
              color: Colors.red,
            ));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.back();
      Utils.showSnackBar(
          'Error',
          'Location permissions are permanently denied, we cannot request permissions.',
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.back();
      Utils.showSnackBar(
          'Error',
          'Location services are disabled. Please enable it.',
          const Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    }
    final position = await Geolocator.getCurrentPosition();
    haveCurrentPosition = true;
    latitude = position.latitude;
    longitude = position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: darkBackgroundColor,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Emergency Booking',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomBackButton(
            onTap: () => Get.back(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('services').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  );
                } else {
                  List<ServiceModel>? services = snapshot.data?.docs
                      .map((e) => ServiceModel.fromFirestore(e))
                      .toList();
                  // services.removeWhere((element) => element.owner.id==localUser!.token);
                  if (services == null || services.isEmpty) {
                    return const SizedBox.shrink();
                  } else {
                    for (ServiceModel item in services) {
                      print(
                          "item.owner.id ${item.owner.id} and current id ${FirebaseAuth.instance.currentUser!.uid}");
                      _coordinates.add({
                        'cor': LatLng(item.latitude, item.longitude),
                        'data': item,
                        'isOther': item.owner.id !=
                            FirebaseAuth.instance.currentUser!.uid
                      });
                    }
                    _calculateDistances();

                    return Stack(
                      children: [
                        Positioned.fill(
                            child: Obx(() => GoogleMap(
                                // mapType: MapType.hybrid,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: true,
                                trafficEnabled: true,
                                myLocationEnabled: true,
                                polylines: controller.polylines.value,
                                myLocationButtonEnabled: true,
                                markers: _markers,
                                onTap: (argument) {},
                                onMapCreated: (controller) async {
                                  mapController = controller;
                                  if (!haveCurrentPosition) {
                                    await _determinePosition();
                                  }
                                  mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              zoom: 14,
                                              target: LatLng(
                                                  localUser!.latitude!,
                                                  localUser!.longitude!))));
                                },
                                initialCameraPosition: CameraPosition(
                                    zoom: 14,
                                    target: LatLng(localUser!.latitude!,
                                        localUser!.longitude!))))),
                        Positioned(
                            bottom: 100,
                            left: 1,
                            right: 1,
                            child: SizedBox(
                              height: 140,
                              width: MediaQuery.sizeOf(context).width,
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: services.length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      mapController.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                          target: LatLng(
                                              services[index].latitude,
                                              services[index].longitude),
                                          zoom: 14,
                                        )),
                                      );
                                      drawRoute(LatLng(services[index].latitude,
                                          services[index].longitude));
                                    },
                                    child: Container(
                                      height: 120,
                                      width:
                                          MediaQuery.sizeOf(context).width - 40,
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              color: Colors.white,
                                              width: 100,
                                              height: 100,
                                              child: CarouselSlider(
                                                  items: [
                                                    ...services[index]
                                                        .images
                                                        .map((element) => Stack(
                                                              fit: StackFit
                                                                  .expand,
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                      element,
                                                                  imageBuilder:
                                                                      (context,
                                                                          imageProvider) {
                                                                    return Image(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            )),
                                                  ],
                                                  options: CarouselOptions(
                                                    initialPage: 0,
                                                    viewportFraction: 1,
                                                    onPageChanged:
                                                        (index, reason) {},
                                                    enableInfiniteScroll: false,
                                                    reverse: false,
                                                    autoPlayInterval:
                                                        const Duration(
                                                            seconds: 3),
                                                    autoPlayAnimationDuration:
                                                        const Duration(
                                                            milliseconds: 800),
                                                    autoPlayCurve:
                                                        Curves.fastOutSlowIn,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                services[index].title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                services[index].owner.name,
                                                style: const TextStyle(
                                                    color: Colors.white70),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'RS ${services[index].price}',
                                                style: const TextStyle(
                                                    color: Colors.white70),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 17,
                                                  ),
                                                  Text(
                                                    '(${services[index].reviews.length})',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    calculateDistance(
                                                        latitude:
                                                            services[index]
                                                                .owner
                                                                .latitude,
                                                        longitude:
                                                            services[index]
                                                                .owner
                                                                .longitude),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.white30,
                                                child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.put(FavController())
                                                          .addToFavouriteServices(
                                                              id: services[
                                                                      index]
                                                                  .id,
                                                              service: services[
                                                                  index]);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Obx(
                                                        () => Icon(
                                                          Get.put(FavController())
                                                                  .favouriteServices
                                                                  .contains(
                                                                      services[
                                                                              index]
                                                                          .id)
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color: Get.put(
                                                                      FavController())
                                                                  .favouriteServices
                                                                  .contains(
                                                                      services[
                                                                              index]
                                                                          .id)
                                                              ? Colors.red
                                                              : Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                        Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => AvailableServices());
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: const Center(
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    );
                  }
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  calculateDistance({required double latitude, required double longitude}) {
    double distanceInMeters = Geolocator.distanceBetween(
      latitude,
      longitude,
      localUser!.latitude!, // latitude 2
      localUser!.longitude!, // longitude 2
    );
    if (distanceInMeters > 1000) {
      double distanceInKilometers = distanceInMeters / 1000;
      return '${distanceInKilometers.toStringAsFixed(1)} Km';
    }
    return '${distanceInMeters.toStringAsFixed(1)} m';
  }

  void drawRoute(LatLng latLng) {
    controller.polylines.clear();
    controller.polylines.add(Polyline(
      jointType: JointType.round,
      geodesic: true,
      polylineId: const PolylineId('route'),
      points: [LatLng(latitude, longitude), latLng],
      color: Colors.blue,
      width: 3,
    ));
  }
}
