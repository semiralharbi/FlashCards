import 'package:flash_cards/domain/entities/create_user_entity.dart';
import 'package:flash_cards/domain/entities/database/folder_entity.dart';
import 'package:flash_cards/domain/entities/database/words_entity.dart';
import 'package:flash_cards/domain/entities/login_entity.dart';

const WordsEntity mockedWordEntityV1 = WordsEntity(
  enWord: 'enWordV1',
  translatedWord: 'translatedWordV1',
  nrRepeated: 0,
);

const WordsEntity mockedWordEntityV2 = WordsEntity(
  enWord: 'enWordV2',
  translatedWord: 'translatedWordV2',
  nrRepeated: 4,
);

const FolderEntity mockedFolderEntityV1 = FolderEntity(
  folderName: 'folderNameV1',
  words: [mockedWordEntityV1, mockedWordEntityV2],
);

const FolderEntity mockedFolderEntityV2 = FolderEntity(
  folderName: 'folderNameV2folderNameV2',
  words: [mockedWordEntityV1, mockedWordEntityV2],
);

const List<FolderEntity> mockedFoldersList = [mockedFolderEntityV1, mockedFolderEntityV2];

const LoginEntity mockedLoginEntity = LoginEntity(email: mockedEmail, password: mockedPassword);
const CreateUserEntity mockedCreateUserEntity = CreateUserEntity(email: mockedEmail, password: mockedPassword);

const String mockedEmail = 'email@email.com';
const String mockedPassword = 'Password1';
const String mockedPasswordV2 = 'Password2';
const String mockedUsername = 'example';
