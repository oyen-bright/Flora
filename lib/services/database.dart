import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/models/content_model.dart';

class DatabaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String uId;
  DatabaseService({this.uId});
  final CollectionReference floraUserCollection =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference floraMovieCollection =
      FirebaseFirestore.instance.collection('Movies');

  Future updateUserData({String userEmail, String userId}) async {
    return await floraUserCollection.doc(uId).set({
      'userEmail': userEmail,
      'userId': userId,
      'userMovieList': [],
      'userPaidMovieList': [],
    });
  }

  Future updateMovieData({
    String name,
    String imageUrl,
    String titleImageUrl,
    String videoUrl,
    String description,
    String price,
    String videoId,
    String noDownload,
    String category,
    String color,
    String videoPreviewUrl,
    String year,
    String pgRating,
    String dateUploaded,
    String quality,
    Map rating,
    bool isTopMovie,
    bool isTrending,
    String noOfPayment,
  }) async {
    DateTime dateToday = new DateTime.now();
    String date = dateToday.toString().substring(0, 10);
    print(date);

    return await floraMovieCollection.add({
      'name': name,
      'imageUrl': imageUrl,
      'titleImageUrl': titleImageUrl,
      'videoUrl': videoUrl,
      'description': description,
      'price': price,
      'videoId': videoId,
      'noDownload': noDownload,
      'category': category,
      'color': color,
      'videoPreviewUrl': videoPreviewUrl,
      'year': year,
      'pgRating': pgRating,
      'dateUploaded': date,
      'quality': quality,
      'rating': rating,
      'noOfPayment': noOfPayment,
      'isTrending': isTrending,
      'isTopMovie': isTopMovie,
    }).then((value) => {print(value.id), updateNewMovieId(movieId: value.id)});
  }

  Future updateNewMovieId({String movieId}) async {
    print(movieId);
    return await floraMovieCollection.doc(movieId).update({'videoId': movieId});
  }
// FirebaseFirestore.instance.collection('collection_name').doc('document_id').update({'field_name': 'Some new data'});

  Future updateUserMylist({String userId}) async {
    return await floraUserCollection
        .doc(userId)
        .collection("usersMovielist")
        .add({
      'userMovieList': [],
      'userPaidMovieList': [],
    });
  }

  Future updateUserMoviesPaymentList({String userId}) async {
    return await floraUserCollection
        .doc(userId)
        .collection("usersPaymentlist")
        .add({});
  }

  Future updateUserMovieList({String movieId}) async {
    User user = auth.currentUser;
    final uid = user.uid;
    print(movieId);
    print(uid);
    QuerySnapshot querySnapshot = await floraUserCollection
        .where('userMovieList', arrayContains: movieId)
        .get();
    if (querySnapshot.docs != null) {
      return await floraUserCollection.doc(uid).update({
        'userMovieList': FieldValue.arrayUnion([movieId])
      });
    }
  }

  Future updateUserPaidMovieList({String movieId}) async {
    User user = auth.currentUser;
    final uid = user.uid;
    print(movieId);
    print(uid);
    QuerySnapshot querySnapshot = await floraUserCollection
        .where('userPaidMovieList', arrayContains: movieId)
        .get();
    if (querySnapshot.docs != null) {
      return await floraUserCollection.doc(uid).update({
        'userPaidMovieList': FieldValue.arrayUnion([movieId])
      });
    }
  }

  Future updateMovieRating(
      {String movieId, int noOfRatings, String totalRatings}) async {
    print(movieId);
    print(noOfRatings);
    print(totalRatings);

    return await floraMovieCollection.doc(movieId).update({
      'rating.noOfRatings': noOfRatings + 1,
      'rating.totalRatings': totalRatings
    });
  }

  final CollectionReference movie =
      FirebaseFirestore.instance.collection('Movies');

// GET ALL MOVIE LIST

  List<Content> _allMovieListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Content(
          name: doc['name'],
          category: doc['category'],
          description: doc['description'],
          imageUrl: doc['imageUrl'],
          noDownload: doc['noDownload'],
          price: doc['price'],
          titleImageUrl: doc['titleImageUrl'],
          videoId: doc['videoId'],
          videoUrl: doc['videoUrl'],
          videoPreviewUrl: doc['videoPreviewUrl'],
          year: doc['year'],
          pgRating: doc['pgRating'],
          dateUploaded: doc['dateUploaded'].toString(),
          quality: doc['quality'],
          rating: doc['rating'],
          noOfPayment: doc['noOfPayment'],
          isTopMovie: doc['isTopMovie'],
          isTrending: doc['isTrending'],
          subName: doc['subName']);
    }).toList();
  }

  final CollectionReference movieList =
      FirebaseFirestore.instance.collection('Movies');

  Stream<QuerySnapshot> get allMovieList {
    return movieList.snapshots();
  }

  Stream<List<Content>> get allMovieListm {
    print(movieList.snapshots());
    print('AM AM WORKING FOR REAL');

    return movieList.snapshots().map(_allMovieListFromSnapshots);
  }

  Future getPaidMovieList() async {
    User user = auth.currentUser;
    final uid = user.uid;
    QuerySnapshot querySnapshot = await floraUserCollection
        .where('userId', isEqualTo: uid.toString())
        .get();
    List alldata = querySnapshot.docs[0]['userPaidMovieList'];
    return alldata;
  }

  void deleteFromUserMovieList({String movieId, bool deleteall}) async {
    User user = auth.currentUser;
    final uid = user.uid;
    try {
      if (deleteall == true) {
        floraUserCollection.doc(user.uid).update({'userMovieList': []});
      } else {
        floraUserCollection.doc(user.uid).update({
          'userMovieList': FieldValue.arrayRemove([movieId]),
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future getUsersMovieList() async {
    User user = auth.currentUser;
    final uid = user.uid;
    print('username' + user.uid);
    QuerySnapshot querySnapshot = await floraUserCollection
        .where('userId', isEqualTo: uid.toString())
        .get();
    List alldata = querySnapshot.docs[0]['userMovieList'];
    print(alldata);
    return alldata;
  }

  Future<List<Content>> getData({String category}) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await movieList.where('category', isEqualTo: category).get();
    List<Content> allData;
    // Get data from docs and convert map to List
    allData = querySnapshot.docs
        .map((doc) => Content(
            name: doc['name'],
            category: doc['category'],
            description: doc['description'],
            imageUrl: doc['imageUrl'],
            noDownload: doc['noDownload'],
            price: doc['price'],
            titleImageUrl: doc['titleImageUrl'],
            videoId: doc['videoId'],
            videoUrl: doc['videoUrl'],
            videoPreviewUrl: doc['videoPreviewUrl'],
            year: doc['year'],
            pgRating: doc['pgRating'],
            dateUploaded: doc['dateUploaded'].toString(),
            quality: doc['quality'],
            rating: doc['rating'],
            noOfPayment: doc['noOfPayment'],
            isTopMovie: doc['isTopMovie'],
            isTrending: doc['isTrending'],
            subName: doc['subName']))
        .toList();

    // if (allData.isEmpty) {
    //   print('empty');
    // } else {
    //   print('dk');
    // }
    // if (allData == null) {
    //   print('other emptye');
    // } else {
    //   print('massia');
    // }
    // print(allData);
    return allData;
  }
}
