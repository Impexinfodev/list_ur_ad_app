import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/modules/home/provider/home_provider.dart';
import 'package:list_ur_add/widgets/ad_widget/job_post_widget.dart';
import 'package:provider/provider.dart';

class LikesView extends StatefulWidget {
  const LikesView({super.key});

  @override
  State<LikesView> createState() => _LikesViewState();
}

class _LikesViewState extends State<LikesView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLikedJobs();
  }

  Future<void> _fetchLikedJobs() async {
    try {
      await Provider.of<HomeProvider>(context, listen: false).fetchLikes();
    } catch (e) {
      debugPrint("Error fetching likes: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        final likedJobs = provider.adsList.where((ad) => ad.isLiked == true).toList();
        return Scaffold(
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : likedJobs.isEmpty
              ? const Center(child: Text("No liked jobs yet"))
              : ListView.builder(
                  itemCount: likedJobs.length,
                  itemBuilder: (context, index) {
                    final job = likedJobs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: JobPostWidget(
                        profileName: job.ownerName,
                        profileImage: job.ownerAvatar,
                        location: job.city,
                        ctc: job.price.toString(),
                        description: job.description,
                        likes: job.likesCount ?? 0,
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
