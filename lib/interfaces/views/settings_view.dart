import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:screen_pal/interfaces/router/app_navigator.dart';
import 'package:screen_pal/interfaces/utils/native_back_button_interceptors.dart';
import 'package:screen_pal/interfaces/widgets/apps/theme_mode_dropdown_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(
      NativeBackButtonInterceptors.toMovies(context),
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(
      NativeBackButtonInterceptors.toMovies(context),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      const ListTile(
        leading: Icon(Icons.color_lens_outlined),
        title: Text('App Theme'),
        trailing: ThemeModeDropdownButton(),
      ),
      ListTile(
        leading: const Icon(Icons.info_outlined),
        title: const Text('About App'),
        onTap: () => AppNavigator.aboutApp(context),
      ),
      ListTile(
        leading: const Icon(Icons.info_outlined),
        title: const Text('About TMDB'),
        onTap: () => AppNavigator.aboutTmdb(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(onPressed: BackButtonInterceptor.popRoute),
        title: const Text('Settings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
