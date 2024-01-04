import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/use_case/update_user_profile_use_case.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockDatabaseRepository mockDatabaseRepository;
  late UpdateUserProfileUseCase updateUserProfileUseCase;

  setUp(() {
    mockDatabaseRepository = MockDatabaseRepository();
    updateUserProfileUseCase = UpdateUserProfileUseCase(mockDatabaseRepository);
  });

  test('UserProfileUseCas updates information about user success', () async {
    when(mockDatabaseRepository.updateUserProfile(mockedUserProfileEntity)).thenAnswer((_) async => const Right(Success()));
    Success? success;
    final result = await updateUserProfileUseCase.call(mockedUserProfileEntity);
    result.fold((l) => null, (r) => success = r);
    expect(success, const Success());
    verify(mockDatabaseRepository.updateUserProfile(mockedUserProfileEntity));
    verifyNoMoreInteractions(mockDatabaseRepository);
  });

  test('UserProfileUseCase updates information about user failure', () async {
    when(mockDatabaseRepository.updateUserProfile(mockedUserProfileEntity))
        .thenAnswer((_) async => const Left(Failure(error: Errors.unknownError)));
    final result = await updateUserProfileUseCase.call(mockedUserProfileEntity);
    Errors? error;
    result.fold((l) => error = l.error, (r) => null);
    expect(error, Errors.unknownError);
    verify(mockDatabaseRepository.updateUserProfile(mockedUserProfileEntity));
    verifyNoMoreInteractions(mockDatabaseRepository);
  });
}
