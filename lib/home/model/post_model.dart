class PostsResponse {
  final List<Post> posts;

  PostsResponse({required this.posts});

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      posts: List<Post>.from(
        (json['posts'] as List).map((post) => Post.fromJson(post)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'posts': posts.map((post) => post.toJson()).toList()};
  }
}

class Post {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final Reactions reactions;
  final int views;
  final int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: List<String>.from((json['tags'] as List?) ?? []),
      reactions: Reactions.fromJson(json['reactions'] ?? {}),
      views: json['views'] ?? 0,
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': reactions.toJson(),
      'views': views,
      'userId': userId,
    };
  }
}

class Reactions {
  final int likes;
  final int dislikes;

  Reactions({required this.likes, required this.dislikes});

  factory Reactions.fromJson(Map<String, dynamic> json) {
    return Reactions(
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'likes': likes, 'dislikes': dislikes};
  }
}
