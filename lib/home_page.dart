import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    PageController controller = PageController(viewportFraction: 0.85);
    return Scaffold(
      appBar: customAppbarWidget(tr: tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageTitleWidget(
              text: tr.announcement,
            ),
            AnnouncementPageBuilder(controller: controller),
            HomePageTitleWidget(
              text: tr.suggestion,
            ),
            const SuggestionListBuilder(),
          ],
        ),
      ),
    );
  }
}

class HomePageTitleWidget extends StatelessWidget {
  final String text;
  const HomePageTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}

class SuggestionListBuilder extends StatelessWidget {
  const SuggestionListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: PageConstants.movieList.length,
      itemBuilder: (context, index) => Container(
        height: 100,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2)
            ]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 100,
              width: 60,
              child: Image.asset(
                PageConstants.movieList[index],
                fit: BoxFit.contain,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Movie Title ${index + 1}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  "Movie description ${index + 1}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AnnouncementPageBuilder extends StatelessWidget {
  const AnnouncementPageBuilder({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
          controller: controller,
          itemCount: PageConstants.posterList.length,
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    PageConstants.posterList[index],
                    fit: BoxFit.fill,
                  ),
                ),
              )),
    );
  }
}

class PageConstants {
  static List<String> posterList = [
    "assets/images/poster1.jpg",
    "assets/images/poster2.jpg",
    "assets/images/poster3 .jpg",
    "assets/images/poster4.jpg"
  ];
  static List<String> movieList = [
    "assets/images/movie1.jpg",
    "assets/images/movie2.jpg",
    "assets/images/movie3.jpg",
    "assets/images/movie4.jpg"
  ];
}

class customAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const customAppbarWidget({
    super.key,
    required this.tr,
  });

  final AppLocalizations tr;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        tr.title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFamily: "Roboto",
            color: Theme.of(context).colorScheme.onPrimary),
      ),
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
