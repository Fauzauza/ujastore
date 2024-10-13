// lib/models/github_model.dart

class Welcome {
  int id;
  String nodeId;
  String name;
  String fullName;
  bool private;
  Owner owner;
  String htmlUrl;
  String description;
  bool fork;
  String url;
  int stargazersCount;
  int forksCount;
  String language;

  Welcome({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.htmlUrl,
    required this.description,
    required this.fork,
    required this.url,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      id: json['id'],
      nodeId: json['node_id'],
      name: json['name'],
      fullName: json['full_name'],
      private: json['private'],
      owner: Owner.fromJson(json['owner']),
      htmlUrl: json['html_url'],
      description: json['description'] ?? '',
      fork: json['fork'],
      url: json['url'],
      stargazersCount: json['stargazers_count'],
      forksCount: json['forks_count'],
      language: json['language'] ?? 'N/A',
    );
  }
}

class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;

  Owner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
    );
  }
}
