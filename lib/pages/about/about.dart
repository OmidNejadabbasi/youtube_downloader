import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("YouTube Downloader App",
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 16.0),
                  Text("Brief Description:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  Text(
                      "This app allows users to download videos from YouTube for offline viewing. It provides a convenient way to save videos for later or for use without an internet connection.",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16.0),
                  Text("Team Information:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  Text("Developed by John Doe",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16.0),
                  Text("Features:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  Text("- Easy and fast downloads",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text("- Supports multiple resolutions and formats",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text("- Background download capability",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16.0),
                  Text("Contact Information:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  Text("Email: john.doe@example.com",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16.0),
                  Text("Legal Information:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  Text(
                      "This app is bound by the terms of service and privacy policy available at example.com/terms and example.com/privacy",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16.0),
                  Text("Version Information:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  Text("Version 1.0.0",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 16.0),
                  Text("Credits and Acknowledgements:",
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 4.0),
                  const Text("This app uses the Flutterframeworkandthe")
                ])));
  }
}
