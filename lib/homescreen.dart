import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/tabs/list_tab.dart';
import 'package:todo/tabs/settings_tab.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_language.dart';
import 'package:todo/bottoms/add_bottom.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homescreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> taps = [
    ListTab(),
    Settings()
  ];
  late ThemeProvider themeProvider;
  int currentIndexTab=0;

  @override
  Widget build(BuildContext context) {
    themeProvider=Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.background
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: buildAppBar(),
        floatingActionButton: buildFloatingActionButton(),
        bottomNavigationBar: buildBottomNavigationBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: taps[currentIndexTab],
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.getLocalizations.toDoList),
      ],
    ),
  );

  Widget buildBottomNavigationBar(context) =>Theme(
      data: Theme.of(context).copyWith(canvasColor: Theme.of(context).primaryColor),
        child: BottomAppBar(
          color: AppColors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            child: BottomNavigationBar(
                currentIndex: currentIndexTab,
                onTap: (newTabIndex){
            currentIndexTab = newTabIndex;
            setState(() {});
                }, items: const[
                BottomNavigationBarItem(icon: Icon(Icons.list_outlined,),label: "List"),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting")
              ],),
          ),
        ),
      );

  FloatingActionButton buildFloatingActionButton() => FloatingActionButton(
    onPressed: (){
      showModalBottomSheet(context: context, isScrollControlled: true,builder: (context){
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddBottom(),
        );
      });
    },child: Icon(Icons.add,color: AppColors.white,),
  );
  }

