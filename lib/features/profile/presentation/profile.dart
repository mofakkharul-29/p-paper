import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/features/auth/presentation/provider/auth_notifier_provider.dart';
import 'package:p_papper/features/news/domain/article_model.dart';
import 'package:p_papper/features/news/presentation/provider/bookmarks_stream_notfier_provider.dart';
import 'package:p_papper/features/news/presentation/provider/open_article_provider.dart';
import 'package:p_papper/features/profile/widget/logout_dialog.dart';
import 'package:p_papper/features/profile/widget/menu_tile.dart';
import 'package:p_papper/features/profile/widget/state_item.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider);

    List<ArticleModel> bookmarksList = [];
    final bookmarks = ref.watch(
      bookmarksStreamNotifierProvider,
    );

    bookmarks.whenData((value) {
      bookmarksList = value;
    });

    final openArticlesList = ref.watch(
      openedArticlesProvider(user.value!.uid),
    );

    return SafeArea(
      child: user.when(
        data: (user) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(
              255,
              192,
              192,
              192,
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 220,
                  pinned: true,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    title: CustomText(
                      text: 'Hi ${user!.name ?? 'Guest'} !',
                      color: Colors.white70,
                    ),
                    centerTitle: true,
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF1F1C2C),
                            Color(0xFF928DAB),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                (user.photoUrl != null &&
                                    user
                                        .photoUrl!
                                        .isNotEmpty)
                                ? NetworkImage(
                                    user.photoUrl!,
                                  )
                                : null,
                            child:
                                (user.photoUrl == null ||
                                    user.photoUrl!.isEmpty)
                                ? const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomText(
                            text: user.name ?? 'Unknown',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: user.email,
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceEvenly,
                            children: [
                              StatItem(
                                title: 'Bookmarks',
                                value: bookmarksList.length
                                    .toString(),
                              ),
                              openArticlesList.when(
                                data: (openedArticles) =>
                                    StatItem(
                                      title: 'Read',
                                      value: openedArticles
                                          .length
                                          .toString(),
                                    ),
                                loading: () =>
                                    const StatItem(
                                      title: 'Read',
                                      value: '...',
                                    ),
                                error: (_, _) =>
                                    const StatItem(
                                      title: 'Read',
                                      value: '0',
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          MenuTile(
                            icon: Icons.bookmark,
                            title: 'My Bookmarks',
                            onTap: () {
                              context.go('/bookmarks');
                            },
                          ),
                          MenuTile(
                            icon: Icons.person,
                            title: 'Edit Profile',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          MenuTile(
                            icon: Icons.settings,
                            title: 'Settings',
                            onTap: () {},
                          ),
                          MenuTile(
                            icon: Icons.dark_mode,
                            title: 'Dark Mode',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            showLogoutDialog(context, ref),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Scaffold(
            body: Center(
              child: CustomText(text: error.toString()),
            ),
          );
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
