import 'package:cloud_firestore/cloud_firestore.dart';

class Artwork {
  String id;
  String title;
  String artistName;
  String description;
  double price;
  String artStyle;
  String imageUrl;
  String artistEmail;
  String phoneNo;
  bool isFavorite;

  Artwork({
    required this.id,
    required this.title,
    required this.artistName,
    required this.description,
    required this.price,
    required this.artStyle,
    required this.imageUrl,
    required this.artistEmail,
    required this.phoneNo,
    required this.isFavorite,
  });

  // Convert a Artwork object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artistName': artistName,
      'description': description,
      'price': price,
      'artStyle': artStyle,
      'imageUrl': imageUrl,
      'artistEmail': artistEmail,
      'phoneNo': phoneNo,
      'isFavorite': isFavorite
    };
  }

  // Create a Artwork object from a DocumentSnapshot
  factory Artwork.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Artwork(
      id: doc.id,
      title: data['title'],
      artistName: data['artistName'],
      description: data['description'],
      price: data['price'].toDouble(),
      artStyle: data['artStyle'],
      imageUrl: data['imageUrl'],
      artistEmail: data['artistEmail'],
      phoneNo: data['phoneNo'],
      isFavorite: data['isFavorite'],
    );
  }
}
