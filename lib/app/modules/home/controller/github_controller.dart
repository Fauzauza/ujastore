// lib/controller/github_controller.dart

import 'package:get/get.dart';
import '../service/github_service.dart';
import '../models/github_model.dart'; // Mengimpor model GitHub

class GitHubController extends GetxController {
  var repoInfo = Welcome(
    id: 0,
    nodeId: '',
    name: '',
    fullName: '',
    private: false,
    owner: Owner(
      login: '',
      id: 0,
      nodeId: '',
      avatarUrl: '',
    ),
    htmlUrl: '',
    description: '',
    fork: false,
    url: '',
    stargazersCount: 0,
    forksCount: 0,
    language: '',
  ).obs;

  var isLoading = false.obs; // Status loading
  final GitHubService gitHubService = GitHubService();

  void fetchRepoInfo(String s) async {
    // Tidak ada parameter lagi
    isLoading.value = true; // Set status loading menjadi true
    try {
      var response = await gitHubService.fetchRepoInfo(); // Hapus repoName
      repoInfo.value = Welcome.fromJson(response);
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch repository info: $error');
    } finally {
      isLoading.value = false; // Set status loading menjadi false
    }
  }
}
