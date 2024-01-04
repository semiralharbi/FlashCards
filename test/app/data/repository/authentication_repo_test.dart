import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/data/repositories/authentication_repo_impl.dart';
import 'package:flash_cards/domain/data_source/remote/authentication_remote_source.dart';
import 'package:flash_cards/domain/repositories/authentication_repo.dart';
import 'package:flash_cards/domain/utils/exception.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late AuthenticationRemoteSource mockedAuthenticationRemoteSource;
  late AuthenticationRepo repository;

  setUpAll(() {
    mockedAuthenticationRemoteSource = MockAuthenticationRemoteSource();
    repository = AuthenticationRepoImpl(mockedAuthenticationRemoteSource);
  });

  test('UpdateUserProfile updates user profile', () async {
    when(mockedAuthenticationRemoteSource.userFolders(mockedUserProfileDto)).thenAnswer((_) async => const Success());
    final result = await repository.updateUserProfile(mockedUserProfileEntity);
    Success? success;
    result.fold(
      (l) => null,
      (r) => success = r,
    );
    expect(success, const Success());
    verify(mockedAuthenticationRemoteSource.userFolders(mockedUserProfileDto));
    verifyNoMoreInteractions(mockedAuthenticationRemoteSource);
  });

  test("UpdateUserProfile updates user profile failure", () async {
    when(mockedAuthenticationRemoteSource.userFolders(mockedUserProfileDto)).thenThrow(ApiException(Errors.unknownError));
    final result = await repository.updateUserProfile(mockedUserProfileEntity);
    Errors? failure;
    result.fold(
      (l) => failure = l.error,
      (r) => null,
    );
    expect(failure, Errors.unknownError);
    verify(mockedAuthenticationRemoteSource.userFolders(mockedUserProfileDto));
    verifyNoMoreInteractions(mockedAuthenticationRemoteSource);
  });
}
