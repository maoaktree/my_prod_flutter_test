import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubController extends GetxController {
  final repos = [].obs;
  final starred = [].obs;
  final userAvatarUrl = "".obs;
  final userName = "".obs;
  final userDescription = "".obs;

  RxList<dynamic> originalRepos = <dynamic>[].obs;
  RxList<dynamic> filteredRepos = <dynamic>[].obs;

  RxList<dynamic> originalStarred = <dynamic>[].obs;
  RxList<dynamic> filteredStarred = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
    fetchRepos();
  }

  Future<void> fetchUserDetails() async {
    final url = "https://api.github.com/users/maoaktree";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        userAvatarUrl.value = data['avatar_url'];
        userName.value = data['name'] ?? "Nome";
        userDescription.value = data['bio'] ?? "No description";
      } else {
        _showError("Erro ao buscar detalhes do usuário");
      }
    } catch (e) {
      _showError("Erro de conexão ou formato inválido");
    }
  }

  Future<void> fetchRepos() async {
    final url = "https://api.github.com/users/maoaktree/repos";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        repos.assignAll(data);
        originalRepos.value = data;
        filteredRepos.value = List.from(originalRepos);
      } else {
        _showError("Erro ao buscar repositórios");
      }
    } catch (e) {
      _showError("Erro de conexão ou formato inválido");
    }
  }

  Future<void> fetchStarred() async {
    final url = "https://api.github.com/users/maoaktree/starred";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        starred.assignAll(data);
        originalStarred.value = data;
        filteredStarred.value = List.from(originalStarred);
      } else {
        _showError("Erro ao buscar repositórios favoritos");
      }
    } catch (e) {
      _showError("Erro de conexão ou formato inválido");
    }
  }

  Future<void> searchReposFromAPI(String query) async {
    final url = "https://api.github.com/search/repositories?q=$query";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        repos.assignAll(data['items']);
      } else {
        _showError("Erro ao realizar a pesquisa");
      }
    } catch (e) {
      _showError("Erro de conexão ou formato inválido");
    }
  }

  void searchRepos(String query) {
    if (query.isEmpty) {
      filteredRepos.value = List.from(originalRepos);
    } else {
      filteredRepos.value = originalRepos.where((repo) {
        return repo['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void searchStarred(String query) {
    if (query.isEmpty) {
      filteredStarred.value = List.from(originalStarred);
    } else {
      filteredStarred.value = originalStarred.where((repo) {
        return repo['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void _showError(String message) {
    Get.snackbar(
      "Erro",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
