import 'package:dio_train/home/model/post_model.dart';
import 'package:dio_train/home/service/dio_service.dart';
import 'package:dio_train/home/service/network_service.dart';
// import 'package:dio_train/home/service/http_service.dart';
import 'dart:convert';

class PostRepository {
  final NetworkService service;

  PostRepository({NetworkService? service})
    : service = service ?? DioService();

  // Get posts with search query
  Future<PostsResponse> searchPosts(String query) async {
    try {
      final response = await service.get(
        '/posts/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return PostsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      print('SearchPosts Error: $e');
      rethrow;
    }
  }

  // Get all posts
  Future<PostsResponse> getAllPosts() async {
    try {
      final response = await service.get('/posts');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return PostsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      print('GetAllPosts Error: $e');
      rethrow;
    }
  }

  // Get single post
  Future<Post> getPost(int id) async {
    try {
      final response = await service.get('/posts/$id');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      print('GetPost Error: $e');
      rethrow;
    }
  }

  // Add new post
  Future<Post> addPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      final response = await service.post(
        '/posts/add',
        data: {'title': title, 'body': body, 'userId': userId},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to add post: ${response.statusCode}');
      }
    } catch (e) {
      print('AddPost Error: $e');
      rethrow;
    }
  }

  // Update post
  Future<Post> updatePost({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      final response = await service.put(
        '/posts/$id',
        data: {'title': title, 'body': body},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return Post.fromJson(jsonData);
      } else {
        throw Exception('Failed to update post: ${response.statusCode}');
      }
    } catch (e) {
      print('UpdatePost Error: $e');
      rethrow;
    }
  }

  // Delete post
  Future<void> deletePost(int id) async {
    try {
      final response = await service.delete('/posts/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      print('DeletePost Error: $e');
      rethrow;
    }
  }
}
