import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studyportal/features/studymaterial/data/datasources/remote_data_source.dart';
import 'package:studyportal/features/studymaterial/data/repository/repository_impl.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/download_file.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_bookmarks.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_courses.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_files.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_pins.dart';
import 'package:studyportal/features/studymaterial/domain/usecases/fetch_branches.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/download_file/download_file_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_bookmarks/fetch_bookmarks_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_branches/fetch_branches_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_courses/fetch_courses_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_files/fetch_files_cubit.dart';
import 'package:studyportal/features/studymaterial/presentation/cubit/fetch_pins/fetch_pins_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/bottom_navbar/sp_bottom_navbar.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/explore_flow/explore_page/explore_page.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/home_flow/home_page/home_page.dart';
import 'package:studyportal/features/studymaterial/presentation/pages/profile_flow/profile_page/profile_page.dart';
import 'package:studyportal/core/theme/theme_data.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (_) => DownloadFileCubit(
            downloadfile:
                DownloadFile(RepositoryImpl(RemoteDataSourceImpl())))),
    BlocProvider(
        create: (_) => FetchFilesCubit(
            fetchFiles: FetchFiles(RepositoryImpl(RemoteDataSourceImpl())))),
    BlocProvider(
        create: (_) => FetchCoursesCubit(
            fetchCourses:
                FetchCourses(RepositoryImpl(RemoteDataSourceImpl())))),
    BlocProvider(
        create: (_) => FetchBranchesCubit(
            fetchBranches:
                FetchBranches(RepositoryImpl(RemoteDataSourceImpl())))),
    BlocProvider(
        create: (_) => FetchPinsCubit(
            fetchPins: FetchPins(RepositoryImpl(RemoteDataSourceImpl())))),
    BlocProvider(
        create: (_) => FetchBookmarksCubit(
            fetchBookmarks:
                FetchBookmarks(RepositoryImpl(RemoteDataSourceImpl())))),
  ], child: const StudyPortal()));
}

class StudyPortal extends StatefulWidget {
  const StudyPortal({super.key});

  @override
  State<StudyPortal> createState() => _StudyPortalState();
}

class _StudyPortalState extends State<StudyPortal> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const ProfilePage(),
  ];
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  void _onTap(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      enableScaleWH: () => false,
      enableScaleText: () => false,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: GlobalThemeData.lightThemeData,
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: Scaffold(
        body: buildNavigator(),
        bottomNavigationBar:
            SPBottomNavBar(currentIndex: _currentIndex, onTap: _onTap),
      ),
    );
  }

  Navigator buildNavigator() {
    return Navigator(
      key: navigatorKeys[_currentIndex],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<Widget>(
            builder: (BuildContext _) => _pages.elementAt(_currentIndex));
      },
    );
  }
}
