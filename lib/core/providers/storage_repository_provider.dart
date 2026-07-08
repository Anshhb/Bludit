// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:redd_clone/core/failure.dart';
// import 'package:redd_clone/core/providers/firebase_providers.dart';
// import 'package:redd_clone/core/type_defs.dart';

// final storageRepositoryProvider = Provider(
//   (ref) => StorageRepository(
//     firebasestorage: ref.watch(storageProvider),
//   ),
// );

// class StorageRepository {
//   final FirebaseStorage _firebaseStorage;

//   StorageRepository({required FirebaseStorage firebasestorage})
//       : _firebaseStorage = firebasestorage;

//   FutureEither<String> storeFile({
//     required String path,
//     required String id,
//     required File? file,
//     required Uint8List? webFile,
//   }) async {
//     try {
//       final ref = _firebaseStorage.ref().child(path).child(id);
// UploadTask uploadTask;
//     if(kIsWeb) {
// uploadTask = ref.putData(webFile!);
//     } else {
// uploadTask = ref.putFile(file!);

//     }

//       final snapshot = await uploadTask;

//       return right(await snapshot.ref.getDownloadURL());
//     } catch (e) {
//       return left(Failure(e.toString()));
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redd_clone/core/failure.dart';
import 'package:redd_clone/core/providers/firebase_providers.dart';
import 'package:redd_clone/core/type_defs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    supabase: ref.watch(supabaseProvider),
  ),
);

class StorageRepository {
  final SupabaseClient _supabase;

  StorageRepository({
    required SupabaseClient supabase,
  }) : _supabase = supabase;

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
    required Uint8List? webFile,
  }) async {
    try {
      final filePath = '$path/$id';

      if (kIsWeb) {
        await _supabase.storage.from('images').uploadBinary(
              filePath,
              webFile!,
              fileOptions: const FileOptions(
                upsert: true,
              ),
            );
      } else {
        await _supabase.storage.from('images').upload(
              filePath,
              file!,
              fileOptions: const FileOptions(
                upsert: true,
              ),
            );
      }

      final imageUrl = _supabase.storage.from('images').getPublicUrl(filePath);

      return right(imageUrl);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
