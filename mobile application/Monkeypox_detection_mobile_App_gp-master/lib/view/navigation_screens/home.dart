import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:monkeybox_final/Cubit/auth_cubit/login_cubit/login_cubit.dart';
import 'package:monkeybox_final/Cubit/auth_cubit/register_cubit/register_cubit.dart';
import 'package:monkeybox_final/Cubit/get_user_cubit/get_user_cubit.dart';
import 'package:monkeybox_final/Cubit/histiry_cubit/history_cubit.dart';

import 'package:monkeybox_final/Cubit/theme_cubit/theme_cubit.dart';
import 'package:monkeybox_final/controller/dio/endpoints.dart';
import 'package:monkeybox_final/utilities/app_colors.dart';
import 'package:monkeybox_final/utilities/app_assets.dart';
import 'package:monkeybox_final/view/auth/Login&SignUp.dart';
import 'package:sizer/sizer.dart';

import '../../Cubit/logout_cubit/logout_cubit.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isExpanded = false;
  RegisterCubit registerCubit = RegisterCubit();

  @override
  Widget build(BuildContext context) {
    final logoutCubit = BlocProvider.of<LogoutCubit>(context);
    final historyCubit = BlocProvider.of<HistoryCubit>(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: InkWell(
        onTap: () {},
        child: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  clr.lightBlue,
                  clr.primaryColor,
                ]),
              ),
              child: BlocConsumer<GetUserCubit, GetUserState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Text(
                    EndPoint.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: context.watch<ThemeCubit>().state.isDark == true
                  ? Text(
                      "Dark Mode",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    )
                  : Text("Light Mode",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold)),
              leading: SizedBox(
                width: 15.w,
                child: FlutterSwitch(
                  value: context.watch<ThemeCubit>().state.isDark,
                  onToggle: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  activeIcon: Icon(
                    Icons.lightbulb,
                    color: Colors.black,
                  ),
                  inactiveIcon: Icon(
                    Icons.lightbulb_outline,
                    color: Colors.black,
                  ),
                  activeColor: clr.primaryColor,
                  inactiveColor: Colors.grey,
                  height: 3.5.h,
                  width: 13.w,
                  // toggleSize: 40.0,
                  // borderRadius: 500,
                  padding: 2,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            BlocConsumer<HistoryCubit, HistoryState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ExpansionTile(
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      _isExpanded = isExpanded;
                    });
                    if (_isExpanded) {
                      historyCubit.getHistory(EndPoint
                          .userToken); // call the callback function when expanded
                    }
                  },
                  // collapsedTextColor: Colors.black,
                  // onExpansionChanged:historyCubit.getHistory(EndPoint.userToken),
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.white.withOpacity(0.2),
                                  builder: (context) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          historyCubit
                                              .historyClassification[index],
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      SizedBox(height: 4.h),
                                      Container(
                                        height: 60.h,
                                        child: Image.network(
                                          historyCubit.historyImages[index],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    child: state is HistoryLoadingState
                                        ? Center(
                                            child:
                                                (CircularProgressIndicator(color: clr.primaryColor,)))
                                        : Image.network(historyCubit.historyImages[index],
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(color: clr.primaryColor,),
                                                );
                                              }
                                            },

                                          ),
                                    height: 10.h,
                                    width: 15.w,
                                    // color: Colors.black
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    historyCubit.historyClassification[index],
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(
                              thickness: 1,
                              // indent: 10,
                              // endIndent: 10,
                            )
                          ],
                        ),
                      ),
                      itemCount: historyCubit.historyImages.length,
                    ),
                    // Text(historyCubit.nn),
                  ],
                  title: Text(
                    'Patient history',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: context.watch<ThemeCubit>().state.isDark == false
                            ? _isExpanded == true
                                ? Colors.black
                                : Colors.black
                            : _isExpanded == true
                                ? Colors.white
                                : Colors.white),
                  ),
                  leading: context.watch<ThemeCubit>().state.isDark == false
                      ? _isExpanded == true
                          ? SizedBox(
                              width: 15.w,
                              child: Icon(
                                Icons.history,
                                color: _isExpanded == true
                                    ? Colors.black
                                    : Colors.black,
                              ))
                          : SizedBox(
                              width: 15.w,
                              child: Icon(
                                Icons.history,
                                color: _isExpanded == true
                                    ? Colors.grey
                                    : Colors.grey,
                              ))
                      : SizedBox(
                          width: 15.w,
                          child: Icon(
                            Icons.history,
                            color: _isExpanded == true
                                ? Colors.white
                                : Colors.white,
                          )),
                  trailing: context.watch<ThemeCubit>().state.isDark == false
                      ? _isExpanded == true
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              size: 25.sp,
                              color: _isExpanded == true
                                  ? Colors.black
                                  : Colors.black,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              size: 25.sp,
                              color: _isExpanded == true
                                  ? Colors.grey
                                  : Colors.grey,
                            )
                      : _isExpanded == true
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              size: 25.sp,
                              color: _isExpanded == true
                                  ? Colors.white
                                  : Colors.white,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              size: 25.sp,
                              color: _isExpanded == true
                                  ? Colors.white
                                  : Colors.white,
                            ),
                );
              },
            ),
            Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            BlocConsumer<LogoutCubit, LogoutState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 20.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(fontSize: 12.4.sp),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MaterialButton(
                                      color: clr.primaryColor,
                                      onPressed: () {
                                        logoutCubit.logOut(EndPoint.userToken);

                                        print(
                                            "Toooooken: " + EndPoint.userToken);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AuthPage(),
                                            ));
                                      },
                                      child: Text(
                                        "Logout",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  title: Text(
                    'Logout',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  leading: SizedBox(width: 15.w, child: Icon(Icons.logout)),
                );
              },
            ),
          ],
        )),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: context.watch<ThemeCubit>().state.isDark == true
                ? Colors.white
                : clr.primaryColor,
          ),
        ),
        title: Text(
          'Monkeypox Disease',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: clr.primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 2.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Image.asset(
                  appImages.homeImage,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                    'Monkeypox is a rare'
                    ' disease caused by infection'
                    ' with the Monkeypox virus. Monkeypox virus'
                    ' is part of the same family of viruses as variola virus, the virus that causes'
                    ' smallpox. Monkeypox symptoms are similar to smallpox symptoms, but milder, '
                    'and Monkeypox is rarely fatal. Monkeypox is not related to chickenpox.',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(
                  height: 1.h,
                ),
                Divider(
                  thickness: 2,
                ),
                Text(
                  'Symptoms',
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: clr.primaryColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(appImages.FevwrImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Fever',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          Image.asset(appImages.ExhaustionImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Exhaustion',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          Image.asset(appImages.rashImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'rash',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          Image.asset(appImages.HeadacheImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Headache',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Preventions',
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: clr.primaryColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(appImages.washHandsImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Wash Hands',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          Image.asset(appImages.vaccinesImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Get Vaccinated',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          Image.asset(appImages.noTouchImage),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Avoid using\n infected objects',
                            style: TextStyle(
                                color: clr.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
