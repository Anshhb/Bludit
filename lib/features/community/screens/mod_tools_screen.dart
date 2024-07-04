// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redd_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends ConsumerWidget {
  final String name;
  const ModToolsScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

    void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }
    void navigateToAddMods(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$name');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final themeMode = ref.watch(themeNotifierProvider.notifier).mode;
    final iconColor = themeMode == ThemeMode.light ? Colors.blue[400] : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod Tools'),
      ),
      body: Column(
        children: [
          ListTile(
            leading:  Icon(Icons.add_moderator, color: iconColor),
            title: const Text('Add Moderators'),
            onTap: () => navigateToAddMods(context),
          ),
          ListTile(
            leading: Icon(Icons.edit, color: iconColor),
            title: const Text('Edit Community'),
            onTap: () => navigateToModTools(context),
          ),
        ],
      ),
    );
  }
}
