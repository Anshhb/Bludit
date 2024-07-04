import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redd_clone/core/constants/constants.dart';
import 'package:redd_clone/features/auth/controller/auth_controller.dart';
import 'package:redd_clone/features/home/delegates/search_community_delegate.dart';
import 'package:redd_clone/features/home/drawers/community_list_drawer.dart';
import 'package:redd_clone/features/home/drawers/profile_drawer.dart';
import 'package:redd_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.light
                ? Colors.lightBlue[50]
                : null,
        title: const Text('Home'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => displayDrawer(context),
              icon: const Icon(Icons.menu));
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Routemaster.of(context).push('/add-post');
            },
            icon: Icon(
              Icons.add,
              color: ref.watch(themeNotifierProvider.notifier).mode ==
                      ThemeMode.light
                  ? Colors.blue[400]
                  : null,
            ),
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            );
          }),
        ],
      ),
      body: Constants.tabWidgets[_page],
      drawer: const CommunityListDrawer(),
      endDrawer: isGuest ? null : const ProfileDrawer(),
      bottomNavigationBar: isGuest || kIsWeb
          ? null
          : CupertinoTabBar(
              activeColor: currentTheme.iconTheme.color,
              backgroundColor: ref.watch(themeNotifierProvider.notifier).mode ==
                      ThemeMode.light
                  ? Colors.lightBlue[50]
                  : currentTheme.dialogBackgroundColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: ref.watch(themeNotifierProvider.notifier).mode ==
                            ThemeMode.light
                        ? Colors.blue[400]
                        : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                    color: ref.watch(themeNotifierProvider.notifier).mode ==
                            ThemeMode.light
                        ? Colors.blue[400]
                        : null,
                  ),
                  label: '',
                ),
              ],
              onTap: onPageChanged,
              currentIndex: _page,
            ),
    );
  }
}
