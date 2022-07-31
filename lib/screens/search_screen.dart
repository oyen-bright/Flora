import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flora/cubits/cubits.dart';
import 'package:flora/data/data.dart';
import 'package:flora/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenPaddingTop = MediaQuery.of(context).padding.top;
    final double screenPaddingBottom = MediaQuery.of(context).padding.bottom;
    print("Bottom AppBar:SEARCH");
    return Scaffold(
        extendBodyBehindAppBar: true,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.grey[850],
        //   child: const Icon(Icons.cast),
        //   onPressed: () => print('Cast'),
        // ),
        appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 50.0),
            child: BlocBuilder<AppBarCubit, double>(
              builder: (context, scrollOffset) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      18, screenPaddingTop + 10, 18, screenPaddingBottom),
                  child: Container(
                    width: screenSize.width,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.25)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.withOpacity(0.7),
                          )),
                    ),
                  ),
                );
              },
            )),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 13, right: 13),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: []))));
  }
}
