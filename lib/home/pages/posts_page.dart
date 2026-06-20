import 'package:flutter/material.dart';
import 'package:dio_train/home/model/post_model.dart';
import 'package:dio_train/home/repository/post_repository.dart';
import 'package:dio_train/home/widgets/post_card.dart';
import 'package:dio_train/home/widgets/search_input.dart';
import 'package:dio_train/home/widgets/state_views.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostRepository _repository = PostRepository();
  late Future<PostsResponse> _postsFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postsFuture = _repository.searchPosts('love');
  }

  void _searchPosts(String query) {
    setState(() {
      _postsFuture = query.isEmpty 
          ? _repository.getAllPosts() 
          : _repository.searchPosts(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _searchPosts('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          SearchInput(
            controller: _searchController,
            onChanged: _searchPosts,
            onClear: _clearSearch,
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Expanded(
            child: FutureBuilder<PostsResponse>(
              future: _postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                if (snapshot.hasError) {
                  return ErrorView(
                    error: snapshot.error.toString(),
                    onRetry: () => _searchPosts(_searchController.text),
                  );
                }
                
                if (!snapshot.hasData || snapshot.data!.posts.isEmpty) {
                  return const EmptyView();
                }
                
                final posts = snapshot.data!.posts;
                return ListView.separated(
                  itemCount: posts.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
