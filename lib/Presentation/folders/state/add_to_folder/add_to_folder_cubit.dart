import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Core/errors/exceptions.dart';
import '../../../../Core/injection/app_inj.dart';
import '../../../../Core/services/folders_system_s.dart';
import '../../../../Features/auth/domain/entites/teacher_data.dart';
import '../../../../Features/auth/domain/use_cases/get_teacher_data.dart';
import '../../../../Features/auth/domain/use_cases/update_user_data_uc.dart';
import '../../../../Features/banks/domain/entities/bank.dart';
import '../../../../Features/banks/domain/usecases/get_banks_by_ids_uc.dart';
import '../../../../Features/tests/domain/entities/test/test.dart';
import '../../../../Features/tests/domain/usecases/get_tests_by_ids_uc.dart';

part 'add_to_folder_state.dart';

class AddToFolderCubit extends Cubit<AddToFolderState> {
  AddToFolderCubit() : super(const AddToFolderState());

  ///
  late TeacherData teacherData;

  ///
  late bool isTest;

  ///
  late FoldersSystemService foldersSystemService;

  ///
  List<String> allDirectories = [];

  ///
  init({required int item, required String teacher, required bool isTest, TeacherData? customTeacherData}) async {
    ///
    final teacherDataCompleter = Completer<TeacherData>();

    ///
    this.isTest = isTest;

    ///
    emit(state.copyWith(
      teacher: "...",
      isLoading: true,
      folders: [],
      tests: [],
      banks: [],
      error: null,
    ));

    if (customTeacherData == null) {
      ///
      final teacherDataResponse = await locator<GetTeacherDataUC>().call(email: teacher);

      ///
      teacherDataResponse.fold(
        (l) {
          emit(state.copyWith(error: l));
        },
        (r) async {
          teacherDataCompleter.complete(r);
        },
      );
    } else {
      teacherDataCompleter.complete(customTeacherData);
    }

    ///
    teacherData = await teacherDataCompleter.future;

    ///
    foldersSystemService = FoldersSystemService(
      directories: isTest ? teacherData.testsFolders : teacherData.banksFolders,
      onUpdate: (data) async {
        if (isTest) {
          final newTeacherData = teacherData.copyWith(
            testsFolders: data,
          );
          await locator<UpdateTeacherDataUC>().call(
            teacherData: newTeacherData,
          );
        } else {
          final newTeacherData = teacherData.copyWith(
            banksFolders: data,
          );
          await locator<UpdateTeacherDataUC>().call(
            teacherData: newTeacherData,
          );
        }
      },
    );

    ///
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  ///
  addToDirectory(int id) async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.addItemDirectory(item: id);
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  List<String> listAllDirectories() {
    // return foldersSystemService.listAllDirectories();
    return foldersSystemService.listAllDirectories();
  }

  removeFromDirectory(int id) async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.removeItemDirectory(item: id);
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  ///
  exploreDirectory(String directory) async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.path = directory;
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  exploreFolder(String folder) async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.pushPathForward(directory: folder);
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  ///
  createDirectory(String directory) async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.createDirectory(directory: directory);
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  ///
  removeDirectory(String directory) async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.removeDirectory(directory: directory);
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  ///
  void backDirectory() async {
    //
    emit(state.copyWith(isLoading: true));
    //
    foldersSystemService.popPathBack();
    //
    emit(state.copyWith(
      isLoading: false,
      canPop: foldersSystemService.canPop,
      teacher: teacherData.name,
      folders: foldersSystemService.getSubdirectories(),
      tests: isTest ? await getTests(foldersSystemService.getDirectoryItems()) : [],
      banks: !isTest ? await getBanks(foldersSystemService.getDirectoryItems()) : const [],
    ));
  }

  ///
  ///
  Future<List<Bank>> getBanks(List<int> ids) async {
    List<Bank> banks = [];
    //
    var res = await locator<GetBanksByIdsUC>().call(ids: ids, update: true);
    //
    res.fold(
      (l) {},
      (r) {
        banks = r;
      },
    );
    //
    return banks;
  }

  //
  Future<List<Test>> getTests(List<int> ids) async {
    //
    List<Test> tests = [];
    //
    var res = await locator<GetTestsByIdsUC>().call(ids: ids, update: true);
    //
    res.fold(
      (l) {},
      (r) {
        tests = r;
      },
    );
    //
    return tests;
  }
}
