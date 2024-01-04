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
  late MockAuthenticationRepo mockAuthenticationRepo;
  late UpdateUserProfileUseCase updateUserProfileUseCase;

  setUp(() {
    mockAuthenticationRepo = MockAuthenticationRepo();
    updateUserProfileUseCase = UpdateUserProfileUseCase(mockAuthenticationRepo);
  });

  test('UserProfileUseCas updates information about user success', () async {
    when(mockAuthenticationRepo.updateUserProfile(mockedUserProfileEntity)).thenAnswer((_) async => const Right(Success()));
    Success? success;
    final result = await updateUserProfileUseCase(mockedUserProfileEntity);
    result.fold((l) => null, (r) => success = r);
    expect(success, const Success());
    verify(mockAuthenticationRepo.updateUserProfile(mockedUserProfileEntity));
    verifyNoMoreInteractions(mockAuthenticationRepo);
  });

  test('UserProfileUseCase updates information about user failure', () async {
    when(mockAuthenticationRepo.updateUserProfile(mockedUserProfileEntity))
        .thenAnswer((_) async => const Left(Failure(error: Errors.unknownError)));
    final result = await updateUserProfileUseCase(mockedUserProfileEntity);
    Errors? error;
    result.fold((l) => error = l.error, (r) => null);
    expect(error, Errors.unknownError);
    verify(mockAuthenticationRepo.updateUserProfile(mockedUserProfileEntity));
    verifyNoMoreInteractions(mockAuthenticationRepo);
  });
}
