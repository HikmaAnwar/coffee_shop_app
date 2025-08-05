import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/category_list.dart';
import '../widgets/coffee_list.dart';
// Make sure that coffee_list.dart exports a CoffeeList widget.
import '../widgets/search_bar.dart' as custom_widgets;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find your perfect coffee',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Discover the best coffee for your taste',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20),
                    custom_widgets.SearchBar(
                      onSearchChanged: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CategoryList(
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CoffeeList(
                      selectedCategory: selectedCategory,
                      searchQuery: searchQuery,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
