import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import '../../controller/github_controller.dart';

class ReposScreen extends StatelessWidget {
  const ReposScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GithubController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
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
                controller.searchRepos(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.filteredRepos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    child: ListTile(
                      title: Text(
                        controller.filteredRepos[index]['name'] ?? 'No name',
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.filteredRepos[index]['description'] ??
                                'No description',
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              const Icon(Icons.code, size: 16),
                              const SizedBox(width: 4.0),
                              Text(controller.filteredRepos[index]
                                      ['language'] ??
                                  'not specified'),
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
    );
  }
}
