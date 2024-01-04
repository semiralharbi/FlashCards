import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flash_cards/data/data_source/remote/authentication_remote_source_impl.dart';
import 'package:flash_cards/data/dto/user/user_profile_dto.dart';
import 'package:flash_cards/domain/data_source/remote/authentication_remote_source.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocked_data.dart';
import '../../../../mocks.dart';

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseAuth mockFirebaseAuth;
  late FakeUser fakeUser;
  late AuthenticationRemoteSource authenticationRemoteSource;

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    fakeUser = FakeUser(mockedDisplayName: 'userName', mockedUid: 'userId');
    mockFirebaseAuth = MockFirebaseAuth(currentUser: fakeUser);
    authenticationRemoteSource = AuthenticationRemoteSourceImpl(fakeFirebaseFirestore, mockFirebaseAuth);
  });

  test(
    "UpdateUserProfile updates user profile success",
    () async {
      final dto = UserProfileDto(
        name: mockedUserProfileDto.name,
        userId: fakeUser.uid,
        userFolders: mockedUserProfileDto.userFolders,
        initialLanguage: mockedUserProfileDto.initialLanguage,
      );
      final collection = fakeFirebaseFirestore.collection('users');
      final result = await authenticationRemoteSource.updateUserProfile(dto);
      final userDoc = await collection.doc(dto.userId).get();

      expect(userDoc.data(), dto.toJson());
      expect(result, const Success());
    },
  );
}
