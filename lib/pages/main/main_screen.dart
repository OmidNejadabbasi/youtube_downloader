import 'package:flutter/material.dart';
import 'package:youtube_downloader/dependency_container.dart';
import 'package:youtube_downloader/pages/main/link_extractor_dialog/link_extractor_dialog.dart';
import 'package:youtube_downloader/pages/main/main_screen_bloc.dart';

import '../../shared/styles.dart';
import '../../shared/widgets/icon_button.dart';
import 'main_screen_states.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenBloc _bloc;

  @override
  void initState() {

    super.initState();
    _bloc = sl<MainScreenBloc>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3),
          ]),
          child: Column(
            children: [
              Row(
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
              StreamBuilder(
                stream: _bloc.mainScreenState,
                builder: (context, snapshot) {
                  if (snapshot.data is MainScreenState) {
                    return _buildMainList(context, snapshot.data! as MainScreenState);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
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

  Widget _buildMainList(BuildContext context, MainScreenState state) {
    return Container();
  }
}
