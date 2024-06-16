import 'package:auto_motive/model/service_model.dart';
import 'package:auto_motive/res/app_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SellServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sell({required ServiceModel service}) async {
    ServiceModel postData = ServiceModel(
        id: service.id,
        name: service.name,
        title: service.title,
        number: service.number,
        description: service.description,
        price: service.price,
        location: service.location,
        experience: service.experience,
        reviews: service.reviews,
        skill: service.skill,
        ratings: service.ratings,
        owner: Owner(
            name: service.owner.name,
            date: service.owner.date,
            id: service.owner.id,
            contact: service.owner.contact,
            latitude: service.owner.latitude,
            longitude: service.owner.longitude),
        images: service.images,
        timeStamp: service.timeStamp,
        longitude: service.longitude,
        latitude: service.latitude);
    // Map<String, dynamic> postData = {
    //   'id': service.id,
    //   'timestamp': service.timeStamp,
    //   'name': service.name,
    //   'title': service.title,
    //   'location': service.location,
    //   'price': service.price,
    //   'skill': service.skill,
    //   'experience': service.experience,
    //   'description': service.description,
    //   'number': service.number,
    //   'owner': {
    //     'name': service.owner.name,
    //     'id': service.owner.id,
    //     'latitude': localUser!.latitude,
    //     'longitude': localUser!.longitude,
    //     'contact': service.owner.contact,
    //     'date': service.owner.date,
    //     'profilePicture': service.owner.profilePicture,
    //   },
    //   'images': service.images,
    // };
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setString('PHONENUMBER', postData.owner.contact.toString());

    _db
        .collection(AppCollections.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'myServices': FieldValue.arrayUnion([service.id]),
    });
    await _db
        .collection(AppCollections.servicesCollection)
        .doc(postData.id)
        .set(postData.toMap());
  }

  Future<void> addToFavourite({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'favouriteServices': FieldValue.arrayUnion([id])
    });
  }

  Future<void> removeFavourite({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'favouriteServices': FieldValue.arrayRemove([id])
    });
  }

  // Future<void> addFarmPost({required FarmPostModel post, required String type}) async {
  //   Map<String, dynamic> postData = {
  //     'id': post.id,
  //     'timestamp' : DateTime.now().microsecondsSinceEpoch.toString(),
  //     'name': post.name,
  //     'price': post.price,
  //     'startDate': post.startDate,
  //     'endDate': post.endDate,
  //     'acre': post.acre,
  //     'minQuantity': post.minQuantity,
  //     'maxQuantity': post.maxQuantity,
  //     'owner': {
  //       'name': post.owner.name,
  //       'latitude' : user!.latitude,
  //       'longitude' : user!.longitude,
  //       'id': post.owner.id,
  //       'contact' : post.owner.contact,
  //       'date': post.owner.date,
  //       'profilePicture': post.owner.profilePicture,
  //     },
  //     'images': post.images,
  //   };
  //   _db.collection(AppCollections.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).update({
  //     'myFarms' : FieldValue.arrayUnion([post.id]),
  //   });
  //   _db.collection('farm_posts').doc(post.id).set(postData);
  //   await _db.collection('${type.toLowerCase()}_${user!.nearestLocations[0].toString()}').doc(post.id).set(postData);
  // }
  //
  //
  //
  // Future<List<AnimalPostModel>> getAnimals({required PostFilters filter,required String location}) async {
  //   final querySnapshot = await _db.collection(filter == PostFilters.all ? 'animal_posts' : 'animal_$location')
  //       .orderBy('timestamp', descending: true)
  //       .get();
  //   return querySnapshot.docs.map((doc) => AnimalPostModel.fromFirestore(doc)).toList();
  // }
  //
  //
  // Future<List<FarmPostModel>> getFarms({required PostFilters filter,required String location}) async {
  //   final querySnapshot = await _db.collection(filter == PostFilters.all ? 'farm_posts' : 'farm_$location')
  //       .orderBy('timestamp', descending: true)
  //       .get();
  //   return querySnapshot.docs.map((doc) => FarmPostModel.fromFirestore(doc)).toList();
  // }
  //
  //
  //
  // Future<List<FarmPostModel>> getMyFarms()async{
  //   DocumentSnapshot eventDoc = await _db.collection(AppCollections.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).get();
  //   try{
  //     List<dynamic> list=await eventDoc.get('myFarms');
  //     final querySnapshot = await _db.collection('farm_${user!.nearestLocations[0]}')
  //         .orderBy('timestamp', descending: true).where(FieldPath.documentId,whereIn: list)
  //         .get();
  //     return querySnapshot.docs.map((doc) => FarmPostModel.fromFirestore(doc)).toList();
  //   }catch(_){
  //     return [];
  //   }
  // }
  //
  // Future<List<AnimalPostModel>> getMyAnimals()async{
  //   DocumentSnapshot eventDoc = await _db.collection(AppCollections.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).get();
  //   try{
  //     List<dynamic> list=await eventDoc.get('myAnimals');
  //     final querySnapshot = await _db.collection('animal_${user!.nearestLocations[0]}')
  //         .orderBy('timestamp', descending: true).where(FieldPath.documentId,whereIn: list)
  //         .get();
  //     return querySnapshot.docs.map((doc) => AnimalPostModel.fromFirestore(doc)).toList();
  //   }catch(_){
  //     return [];
  //   }
  // }
}
