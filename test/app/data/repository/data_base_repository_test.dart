import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/data/repositories/database_repository_impl.dart';
import 'package:flash_cards/domain/data_source/remote/database_remote_source.dart';
import 'package:flash_cards/domain/repositories/database_repository.dart';
import 'package:flash_cards/domain/utils/exception.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late DatabaseRemoteSource mockedDatabaseRemoteSource;
  late DatabaseRepository repository;

  setUpAll(() {
    mockedDatabaseRemoteSource = MockDatabaseRemoteSource();
    repository = DatabaseRepositoryImpl(mockedDatabaseRemoteSource);
  });

  test('UpdateUserProfile updates user profile', () async {
    when(mockedDatabaseRemoteSource.updateUserProfile(mockedUserProfileDto)).thenAnswer((_) async => const Success());
    final result = await repository.updateUserProfile(mockedUserProfileEntity);
    Success? success;
    result.fold(
      (l) => null,
      (r) => success = r,
    );
    expect(success, const Success());
    verify(mockedDatabaseRemoteSource.updateUserProfile(mockedUserProfileDto));
    verifyNoMoreInteractions(mockedDatabaseRemoteSource);
  });

  test("UpdateUserProfile updates user profile failure", () async {
    when(mockedDatabaseRemoteSource.updateUserProfile(mockedUserProfileDto)).thenThrow(ApiException(Errors.unknownError));
    final result = await repository.updateUserProfile(mockedUserProfileEntity);
    Errors? failure;
    result.fold(
      (l) => failure = l.error,
      (r) => null,
    );
    expect(failure, Errors.unknownError);
    verify(mockedDatabaseRemoteSource.updateUserProfile(mockedUserProfileDto));
    verifyNoMoreInteractions(mockedDatabaseRemoteSource);
  });
}
