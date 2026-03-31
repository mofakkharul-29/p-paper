import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p_papper/core/constant/theme.dart';
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
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    List<ArticleModel> bookmarksList = [];
    final bookmarks = ref.watch(
      bookmarksStreamNotifierProvider,
    );

    bookmarks.whenData((value) {
      bookmarksList = value;
    });

    return SafeArea(
      child: user.when(
        data: (user) {
          if (user == null) return const SizedBox.shrink();

          final openArticlesList = ref.watch(
            openedArticlesProvider(user.uid),
          );
          return Scaffold(
            backgroundColor: Theme.of(
              context,
            ).scaffoldBackgroundColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 220,
                  pinned: true,
                  backgroundColor: Theme.of(
                    context,
                  ).scaffoldBackgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    title: CustomText(
                      text: 'Hi ${user.name ?? 'Guest'} !',
                      color: isDark
                          ? Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color
                          : Colors.white60,
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
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            backgroundColor: isDark
                                ? Colors.white54
                                : Colors.transparent,
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
                                ? Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.black87,
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
                            // color: Colors.black87,
                            color: isDark
                                ? Colors.black87
                                : Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text: user.email,
                            fontSize: 14,
                            color: Colors.black87,
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
                          Consumer(
                            builder: (context, ref, _) {
                              final themeMode = ref.watch(
                                themeNotifierProvider,
                              );
                              final isDark =
                                  themeMode ==
                                  ThemeMode.dark;

                              return AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 300,
                                ),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        16,
                                      ),
                                ),
                                child: SwitchListTile(
                                  activeTrackColor:
                                      Colors.black54,
                                  activeThumbColor:
                                      Colors.black87,

                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                  secondary: const Icon(
                                    Icons.dark_mode,
                                  ),
                                  title: const Text(
                                    'Dark Mode',
                                  ),
                                  value: isDark,
                                  onChanged: (value) {
                                    ref
                                        .read(
                                          themeNotifierProvider
                                              .notifier,
                                        )
                                        .toggleTheme(value);
                                  },
                                ),
                              );
                            },
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
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            showLogoutDialog(context, ref),
                        icon: const Icon(
                          Icons.logout_rounded,
                          size: 18,
                        ),
                        label: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.blueAccent
                              : Colors.black,
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
