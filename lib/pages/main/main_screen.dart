import 'package:flutter/material.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog.dart';
import 'package:youtube_downloader/shared/my_flutter_app_icons.dart';

import '../../shared/styles.dart';
import '../../shared/widgets/icon_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3),
          ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NIconButton(
                icon: Icons.menu,
                onPressed: () {},
              ),
              const Expanded(
                child: Text(
                  'Youtube Downloader',
                  textAlign: TextAlign.center,
                  style: Styles.appTitleStyle,
                ),
              ),
              NIconButton(
                icon: Icons.search,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Styles.colorPrimary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const YoutubeLinkExtractorDialog();
              });
        },
      ),
    );
  }
}


