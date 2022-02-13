import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/image_page.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.map<Widget>(
            initial: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (loadedState) {
              return CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final file = loadedState.images[index];
                        if (index == loadedState.images.length - 1) {
                          context.read<HomeBloc>().add(const ImageFetched());
                        }
                        return GestureDetector(
                          onTap: file != null
                              ? () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) {
                                        return ImagePage(file);
                                      },
                                    ),
                                  )
                              : null,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            alignment: Alignment.center,
                            child: file != null ? Image.file(file) : const Icon(Icons.error),
                          ),
                        );
                      },
                      childCount: loadedState.images.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: loadedState.canLoadMore ? const CircularProgressIndicator() : const Text('End of story :('),
                    ),
                  ),
                ],
              );
            },
          );
        },
      )),
    );
  }
}
