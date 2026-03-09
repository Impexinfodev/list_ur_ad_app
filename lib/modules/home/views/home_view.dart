import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:list_ur_add/modules/home/provider/home_provider.dart';
import 'package:list_ur_add/widgets/ad_widget/job_post_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchAds();
      Provider.of<HomeProvider>(context, listen: false).fetchLikes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: () {
                return provider.fetchAds();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.adsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final ad = provider.adsList[index];
                        return JobPostWidget(
                          profileName: ad.ownerName,
                          profileImage: ad.ownerAvatar ?? "",
                          isVerified: true,
                          jobTitle: ad.title.toString(),
                          location: ad.city,
                          ctc: "₹${ad.price}",
                          experience: '3+ years',
                          description: parseHtml(ad.description ?? ""),
                          email: 'hr@company.com',
                          comments: 5,
                          calls: 2,
                          analysis: '15k',
                          isBookmarked: false,
                          isShared: true,
                          isTranslated: true,
                          likes: ad.likesCount ?? 0,
                          isLiked: ad.isLiked ?? false,
                          onLikeTap: () {
                            provider.toggleLike(ad.id.toString(), index);
                          },
                          onBookmarkTap: () {
                            provider.toggleBookmark(ad.id.toString());
                          },
                          onShareTap: () async {
                            final url = await provider.toggleShare(ad.id.toString());
                            return url;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String parseHtml(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }
}
