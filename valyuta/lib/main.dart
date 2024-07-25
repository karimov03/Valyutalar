import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:valyuta/view/pages/calculate_page.dart';
import 'package:valyuta/view/pages/chart_page.dart';
import 'package:valyuta/view/pages/list_page.dart';
import 'view/pages/home_page.dart';
import 'view_model/provider/bottom_navigation_bar_select_item';
import 'view_model/provider/data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavigationItem()),
        ],
        child: MyApp(),
      ),
    );
  });

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color.fromARGB(255, 11, 12, 21),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      dataProvider.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<BottomNavigationItem>().selectedIndex;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: const CustomBottomNavigation(),
        backgroundColor: Color.fromARGB(255, 11, 12, 21),
        body: selectBody(selectedIndex),
      ),
    );
  }

  Widget selectBody(int selectedIndex) {
    final dataProvider = Provider.of<DataProvider>(context);
    switch (selectedIndex) {
      case 0:
        return dataProvider.isLoading
            ? _buildLoadingLayout()
            : HomePage(dataProvider.data);
      case 1:
        return ChartPage();
      case 2:
        return dataProvider.isallLoading
            ? _buildLoadingLayout()
            : ListPage(dataProvider.alldata);
      case 3:
        return dataProvider.isallLoading
            ? _buildLoadingLayout()
            : CalculatePage(dataProvider.alldata);
      default:
        return dataProvider.isLoading
            ? _buildLoadingLayout()
            : HomePage(dataProvider.data);
    }
  }

  Widget _buildLoadingLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 16),
          Text(
            "Ma'lumotlar yuklanmoqda...",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 22, 24, 39),
        ),
        alignment: Alignment.bottomCenter,
        height: 70,
        child: Row(
          children: List.generate(4, (index) => buildNavItem(context, index)),
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, int index) {
    final selectedIndex = context.watch<BottomNavigationItem>().selectedIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<BottomNavigationItem>().updateIndex(index);
        },
        child: Stack(
          children: [
            Center(
              child: (selectedIndex == index)
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            getNameIndex(index),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 4,
                            width: 20,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color.fromARGB(255, 15, 215, 147)),
                          ),
                        ],
                      ),
                    )
                  : Icon(
                      getIconData(index),
                      color: const Color.fromARGB(255, 70, 97, 103),
                      size: 30,
                    ),
            )
          ],
        ),
      ),
    );
  }

  String getNameIndex(int index) {
    switch (index) {
      case 0:
        return "Bosh sahifa";
      case 1:
        return "Diagramma";
      case 2:
        return "Ro'yxat";
      case 3:
        return "Kalkulyator";
      default:
        return "Bosh sahifa";
    }
  }

  IconData getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.line_axis_rounded;
      case 2:
        return Icons.list_alt_rounded;
      case 3:
        return Icons.calculate_outlined;
      default:
        return Icons.home_outlined;
    }
  }
}
