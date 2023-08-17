import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import '../../controller/github_controller.dart';

class StarredScreen extends StatelessWidget {
  const StarredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GithubController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Filter by name",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.searchStarred(value);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredStarred.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: ListTile(
                        title: Text(
                          controller.filteredStarred[index]['name'] ??
                              'No name',
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.filteredStarred[index][
                                      'description'] ?? // Use filteredStarred here
                                  'No description',
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: Colors.yellow),
                                const SizedBox(width: 4.0),
                                Text(controller.filteredStarred[index]
                                        ['stargazers_count']
                                    .toString()),
                                const SizedBox(width: 12.0),
                                const Icon(Icons.history, size: 16),
                                const SizedBox(width: 4.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
