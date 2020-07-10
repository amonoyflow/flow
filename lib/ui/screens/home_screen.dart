import 'package:flow/blocs/navigation_bloc/_navigation.dart';
import 'package:flow/ui/widgets/home/beverages_selection.dart';
import 'package:flow/ui/widgets/home/search_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget with NavigationState {
  final Function onMenuTap;

  HomeScreen({
    Key key,
    this.onMenuTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 0),
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.menu, size: 30),
                    onPressed: widget.onMenuTap,
                  ),
                ],
              ),
            ],
          ),
          SearchField(
            labelText: 'Search for Beverages...',
            icon: Icons.search,
            keyboardType: TextInputType.text,
            controller: searchController,
            validator: (_) {
              return null;
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: <Widget>[
                BeveragesSelection(
                  asset: "assets/beer.svg",
                  label: "Beer",
                ),
                BeveragesSelection(
                  asset: "assets/wine.svg",
                  label: "Wine",
                ),
                BeveragesSelection(
                  asset: "assets/vodka.svg",
                  label: "Vodka",
                ),
                BeveragesSelection(
                  asset: "assets/whisky.svg",
                  label: "Whisky",
                ),
                BeveragesSelection(
                  asset: "assets/tequila.svg",
                  label: "Tequila",
                ),
                BeveragesSelection(
                  asset: "assets/softdrinks.svg",
                  label: "Softdrinks",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void onSearchChanged() {}
