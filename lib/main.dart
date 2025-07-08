import 'package:firebase_core/firebase_core.dart';
import 'package:moatmat_uploader/Core/services/folders_s.dart';
import 'package:moatmat_uploader/Presentation/auth/state/auth_c/auth_cubit_cubit.dart';
import 'package:moatmat_uploader/Presentation/banks/state/add_bank/add_bank_cubit.dart';
import 'package:moatmat_uploader/Presentation/banks/state/my_banks/my_banks_cubit.dart';
import 'package:moatmat_uploader/Presentation/banks/state/search_bank/search_bank_cubit.dart';
import 'package:moatmat_uploader/Presentation/notifications/state/notifications_bloc/notifications_bloc.dart';
import 'package:moatmat_uploader/Presentation/questions/state/cubit/create_question_cubit.dart';
import 'package:moatmat_uploader/Presentation/students/state/my_students/my_students_cubit.dart';
import 'package:moatmat_uploader/Presentation/tests/state/search_test/search_test_cubit.dart';
import 'package:moatmat_uploader/firebase_options.dart';
import 'Core/injection/app_inj.dart';
import 'package:flutter/material.dart';
import 'Core/services/supabase_s.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Presentation/banks/state/bank_information/bank_information_cubit.dart';
import 'Presentation/banks_results/state/cubit/bank_results_cubit.dart';
import 'Presentation/folders/state/add_to_folder/add_to_folder_cubit.dart';
import 'Presentation/folders/state/pick_teacher_item/pick_teacher_item_cubit.dart';
import 'Presentation/groups/state/groups/students_groups_cubit.dart';
import 'Presentation/notifications2/state/cubit/notifications_cubit.dart';
import 'Presentation/picker/state/cubit/questions_picker_cubit.dart';
import 'Presentation/reports/state/reports/reports_cubit.dart';
import 'Presentation/tests_results/state/cubit/test_results_cubit.dart';
import 'Presentation/students/state/student/student_cubit.dart';
import 'Presentation/tests/state/add_test/add_test_cubit.dart';
import 'Presentation/tests/state/my_tests/my_tests_cubit.dart';
import 'Presentation/tests/state/test_information/test_information_cubit.dart';
import 'app_root.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  // int supabase
  await SupabaseServices.init();
  //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init get it
  await initGetIt();
  //
  FoldersService.testing();
  //
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddTestCubit()),
        BlocProvider(create: (context) => MyTestsCubit()),
        BlocProvider(create: (context) => AddBankCubit()),
        BlocProvider(create: (context) => MyBanksCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ReportsCubit()..init()),
        BlocProvider(create: (context) => CreateQuestionCubit()),
        BlocProvider(create: (context) => TestInformationCubit()),
        BlocProvider(create: (context) => BankInformationCubit()),
        BlocProvider(create: (context) => TestResultsCubit()),
        BlocProvider(create: (context) => MyStudentsCubit()),
        BlocProvider(create: (context) => StudentCubit()),
        BlocProvider(create: (context) => StudentsGroupsCubit()),
        BlocProvider(create: (context) => NotificationsCubit()),
        BlocProvider(create: (context) => BankResultsCubit()),
        BlocProvider(create: (context) => SearchBankCubit()),
        BlocProvider(create: (context) => SearchTestCubit()),
        BlocProvider(create: (context) => QuestionsPickerCubit()),
        BlocProvider(create: (context) => AddToFolderCubit()),
        BlocProvider(create: (context) => PickTeacherItemCubit()),
        BlocProvider(create: (context) => locator<NotificationsBloc>()),
      ],
      child: const AppRoot(),
    ),
  );
}
