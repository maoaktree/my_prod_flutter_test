import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_prod_flutter_test/themes/app_colors.dart';

import '../../controller/github_controller.dart';
import '../../themes/app_text_styles.dart';
import '../../widgets/number_circle.dart';
import 'repos_screen.dart';
import 'starred_screen.dart';

final GithubController controller = Get.put(GithubController());

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    controller.fetchRepos();
    controller.fetchStarred();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(208),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
            child: SizedBox(
              child: Image.asset(
                'assets/img/github-mark-white.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Github ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                TextSpan(
                  text: 'Profiles',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              color: AppColors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Obx(() => CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                    controller.userAvatarUrl.value.isNotEmpty
                                        ? controller.userAvatarUrl.value
                                        : 'url_do_seu_placeholder'),
                              ))),
                      const SizedBox(width: 10),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  controller.userName.value,
                                  style: AppTextStyles.textStyle1.copyWith(
                                      fontSize:
                                          AppTextStyles.textStyle1.fontSize! *
                                              2.0),
                                )),
                            Obx(() => Text(
                                  controller.userDescription.value,
                                  style: AppTextStyles.textStyle2.copyWith(
                                      fontSize:
                                          AppTextStyles.textStyle2.fontSize! *
                                              1.8),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  TabBar(
                    controller: _tabController,
                    indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 4.0, color: AppColors.rustyOrange)),
                    labelColor: AppColors.navyBlue,
                    unselectedLabelColor: AppColors.navyBlue,
                    labelStyle: AppTextStyles.textStyle1,
                    unselectedLabelStyle: AppTextStyles.textStyle2,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Repos', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 5),
                            Obx(() => numberCircle(controller.repos.length)),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Starred',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 5),
                            Obx(() => numberCircle(controller.starred.length)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ReposScreen(),
          StarredScreen(),
        ],
      ),
    );
  }
}
