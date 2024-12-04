import 'package:art_hive_app/headers.dart';
import 'dart:io';

class ArtworkController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final UserController userController = Get.find<UserController>();

  final RxList<Artwork> originalArtworks = <Artwork>[].obs; // Original data
  final RxList<Artwork> artworks = <Artwork>[].obs; // Displayed data

  // Fetch artworks by the current artist
  Future<void> fetchMyArtwork() async {
    try {
      final String userEmail =
          userController.user.value!.email; // Get the current user's email
      final QuerySnapshot snapshot = await _firestore
          .collection('artworks')
          .where('artistEmail', isEqualTo: userEmail)
          .get();
      artworks.clear();
      artworks.value =
          snapshot.docs.map((doc) => Artwork.fromDocument(doc)).toList();
    } catch (e) {
      debugPrint('Error fetching my artworks: $e');
    }
  }

  // Fetch Favorite artworks
  Future<void> fetchFavoriteArtwork() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('artworks')
          .where('favoritedBy', arrayContains: userController.user.value!.email)
          .get();
      artworks.clear();
      artworks.value =
          snapshot.docs.map((doc) => Artwork.fromDocument(doc)).toList();
    } catch (e) {
      debugPrint('Error fetching favorite artworks: $e');
    }
  }

  // Update the isFavorite status of an artwork
  Future<void> updateFavoriteStatus(
      String artworkId, bool isFavorite, bool ishome) async {
    try {
      if (isFavorite) {
        // Add user email to the favoritedBy array
        await _firestore.collection('artworks').doc(artworkId).update({
          'favoritedBy':
              FieldValue.arrayUnion([userController.user.value!.email]),
        });
      } else {
        // Remove user email from the favoritedBy array
        await _firestore.collection('artworks').doc(artworkId).update({
          'favoritedBy':
              FieldValue.arrayRemove([userController.user.value!.email]),
        });
      }

      // Optionally update the local list of artworks if needed
      ishome ? fetchArtworks() : fetchFavoriteArtwork();
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  // Fetch all artworks
  Future<void> fetchArtworks() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('artworks').get();
      originalArtworks.clear();
      artworks.clear();

      final fetchedArtworks =
          snapshot.docs.map((doc) => Artwork.fromDocument(doc)).toList();
      originalArtworks.addAll(fetchedArtworks);
      artworks.addAll(fetchedArtworks); // Populate both lists
    } catch (e) {
      debugPrint('Error fetching artworks: $e');
    }
  }

  void searchArtworks(String query) {
    debugPrint("Original artworks count: ${originalArtworks.length}");
    if (query.isNotEmpty) {
      final filtered = originalArtworks.where((artwork) {
        final titleLower = artwork.title.toLowerCase();
        final artistLower = artwork.artistName.toLowerCase();
        final styleLower = artwork.artStyle.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) ||
            artistLower.contains(searchLower) ||
            styleLower.contains(searchLower);
      }).toList();
      debugPrint("Filtered artworks count: ${filtered.length}");
      artworks.assignAll(filtered); // Update displayed list
    } else {
      artworks.assignAll(originalArtworks); // Reset to original data
    }
  }

  // Add new artwork
  Future<void> addArtwork(
      Artwork artwork, File imageFile, bool isprofile) async {
    try {
      // Upload the image to Firebase Storage
      final String imageUrl = await uploadImage(imageFile, isprofile);
      final String userEmail =
          userController.user.value!.email; // Get the current user's email

      // Save the artwork data in Firestore
      final DocumentReference docRef =
          await _firestore.collection('artworks').add({
        'title': artwork.title,
        'artistName': artwork.artistName,
        'description': artwork.description,
        'price': artwork.price,
        'artStyle': artwork.artStyle,
        'imageUrl': imageUrl,
        'artistEmail': userEmail,
        'phoneNo': artwork.phoneNo,
        'isFavorite': false,
        'favoritedBy': []
      });

      // Use the generated ID if needed
      final String generatedId = docRef.id;

      // Optionally update your local Artwork object with the ID
      artwork.id = generatedId;

      // Update the local list of artworks
      fetchArtworks();
    } catch (e) {
      print('Error adding artwork: $e');
    }
  }

  // Edit existing artwork
  Future<void> editArtwork(
      Artwork artwork, File? imageFile, bool isprofile) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        // If a new image is provided, upload it and update the URL
        imageUrl = await uploadImage(imageFile, isprofile);
      }

      final String userEmail =
          userController.user.value!.email; // Get the current user's email

      // Update the artwork data in Firestore
      await _firestore.collection('artworks').doc(artwork.id).update({
        'title': artwork.title,
        'artistName': artwork.artistName,
        'description': artwork.description,
        'price': artwork.price,
        'artStyle': artwork.artStyle,
        'imageUrl': imageUrl ??
            artwork
                .imageUrl, // Use the existing image URL if no new image is uploaded
        'artistEmail': userEmail,
        'phoneNo': artwork.phoneNo
      });

      // Update the local list of artworks
      fetchArtworks();
    } catch (e) {
      print('Error editing artwork: $e');
    }
  }

  // function to update artist email for all artworks
  Future<void> updateArtistEmail(String oldEmail, String newEmail) async {
    try {
      // Fetch all artworks where the artistEmail matches the oldEmail
      final QuerySnapshot snapshot = await _firestore
          .collection('artworks')
          .where('artistEmail', isEqualTo: oldEmail)
          .get();

      debugPrint(
          "***********${snapshot.docs.length} artworks found for artistEmail************");

      // Update the artistEmail for each artwork
      for (var doc in snapshot.docs) {
        await _firestore.collection('artworks').doc(doc.id).update({
          'artistEmail': newEmail,
        });
      }

      // Fetch all artworks where 'favoritedBy' array contains the oldEmail
      final QuerySnapshot favoritedSnapshot = await _firestore
          .collection('artworks')
          .where('favoritedBy', arrayContains: oldEmail)
          .get();

      debugPrint(
          "***********${favoritedSnapshot.docs.length} artworks found for favoritedBy************");

      // Update the favoritedBy array for each artwork
      for (var doc in favoritedSnapshot.docs) {
        await _firestore.collection('artworks').doc(doc.id).update({
          'favoritedBy': FieldValue.arrayRemove([oldEmail]), // Remove oldEmail
        });

        await _firestore.collection('artworks').doc(doc.id).update({
          'favoritedBy': FieldValue.arrayUnion([newEmail]), // Add newEmail
        });
      }

      // Optionally, refresh the local list of artworks
      // fetchArtworks();

      debugPrint(
          "***********Artist email and favoritedBy updated successfully************");
    } catch (e) {
      debugPrint('Error updating artist email or favoritedBy: $e');
    }
  }

  // Delete an artwork
  Future<void> deleteArtwork(String id) async {
    try {
      await _firestore.collection('artworks').doc(id).delete();
      fetchMyArtwork(); // Update the local list after deletion
    } catch (e) {
      print('Error deleting artwork: $e');
    }
  }

  // Delete all artworks where artistEmail matches the provided email
  Future<void> deleteArtworksByArtistEmail(String email) async {
    try {
      // Fetch all artworks where the artistEmail matches the provided email
      final QuerySnapshot snapshot = await _firestore
          .collection('artworks')
          .where('artistEmail', isEqualTo: email)
          .get();

      // Delete each artwork document
      for (var doc in snapshot.docs) {
        await _firestore.collection('artworks').doc(doc.id).delete();
      }

      // Optionally, refresh the local list of artworks if needed
      fetchArtworks();
    } catch (e) {
      debugPrint('Error deleting artworks by artist email: $e');
    }
  }

  // Upload an image to Firebase Storage
  Future<String> uploadImage(File imageFile, bool isprofile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}';
      final Reference storageRef;
      if (isprofile) {
        storageRef = _storage.ref().child('users/$fileName');
      } else {
        storageRef = _storage.ref().child('artworks/$fileName');
      }
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  // Pick an image from gallery or camera
  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // or ImageSource.camera
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
