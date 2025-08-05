import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../models/coffee.dart';
import '../screens/coffee_detail_screen.dart';
import '../providers/auth_provider.dart';

class CoffeeList extends StatelessWidget {
  final String selectedCategory;
  final String? searchQuery;

  CoffeeList({required this.selectedCategory, this.searchQuery});

  List<Coffee> getCoffeeList() {
    return [
      Coffee(
        id: '1',
        name: 'Espresso',
        description: 'Strong and pure coffee shot',
        price: 3.50,
        imageUrl:
            'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=200',
        category: 'Espresso',
        rating: 4.8,
        reviewCount: 124,
      ),
      Coffee(
        id: '2',
        name: 'Cappuccino',
        description: 'Perfect blend of espresso and steamed milk',
        price: 4.50,
        imageUrl:
            'https://images.unsplash.com/photo-1572442388796-11668a64e546?w=200',
        category: 'Cappuccino',
        rating: 4.6,
        reviewCount: 89,
      ),
      Coffee(
        id: '3',
        name: 'Latte',
        description: 'Smooth and creamy coffee',
        price: 4.00,
        imageUrl:
            'https://images.unsplash.com/photo-1541167760496-1628856a772a?w=200',
        category: 'Latte',
        rating: 4.7,
        reviewCount: 156,
      ),
      Coffee(
        id: '4',
        name: 'Americano',
        description: 'Classic black coffee',
        price: 3.00,
        imageUrl:
            'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=200',
        category: 'Americano',
        rating: 4.5,
        reviewCount: 67,
      ),
      Coffee(
        id: '5',
        name: 'Mocha',
        description: 'Chocolate and coffee delight',
        price: 5.00,
        imageUrl:
            'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?w=200',
        category: 'Mocha',
        rating: 4.9,
        reviewCount: 203,
      ),
      Coffee(
        id: '6',
        name: 'Flat White',
        description: 'Smooth espresso with velvety microfoam',
        price: 4.25,
        imageUrl:
            'https://images.unsplash.com/photo-1572442388796-11668a64e546?w=200',
        category: 'Latte',
        rating: 4.7,
        reviewCount: 98,
      ),
      Coffee(
        id: '7',
        name: 'Macchiato',
        description: 'Espresso with a dash of steamed milk',
        price: 3.75,
        imageUrl:
            'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=200',
        category: 'Espresso',
        rating: 4.4,
        reviewCount: 73,
      ),
    ];
  }

  List<Coffee> getFilteredList() {
    final coffeeList = getCoffeeList();

    // First filter by category
    List<Coffee> categoryFiltered = selectedCategory == 'All'
        ? coffeeList
        : coffeeList
              .where((coffee) => coffee.category == selectedCategory)
              .toList();

    // Then filter by search query - handle null case
    final query = searchQuery ?? '';
    if (query.isEmpty) {
      return categoryFiltered;
    }

    return categoryFiltered.where((coffee) {
      final queryLower = query.toLowerCase();
      return coffee.name.toLowerCase().contains(queryLower) ||
          coffee.description.toLowerCase().contains(queryLower) ||
          coffee.category.toLowerCase().contains(queryLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = getFilteredList();

    if (filteredList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: AppColors.textSecondary),
            SizedBox(height: 16),
            Text(
              'No coffees found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try adjusting your search or category filter',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final coffee = filteredList[index];
        return AnimatedCoffeeCard(coffee: coffee, index: index);
      },
    );
  }
}

class AnimatedCoffeeCard extends StatefulWidget {
  final Coffee coffee;
  final int index;

  AnimatedCoffeeCard({required this.coffee, required this.index});

  @override
  _AnimatedCoffeeCardState createState() => _AnimatedCoffeeCardState();
}

class _AnimatedCoffeeCardState extends State<AnimatedCoffeeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(widget.index * 0.1, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(widget.index * 0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: CoffeeCard(coffee: widget.coffee),
          ),
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;

  CoffeeCard({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        final isFavorite = auth.isFavorite(coffee.id);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CoffeeDetailScreen(coffee: coffee),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(coffee.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Favorite Button
                      if (auth.isAuthenticated)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {
                              auth.toggleFavorite(coffee.id);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : AppColors.textSecondary,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      // Rating Badge
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.white,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                coffee.rating.toString(),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coffee.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          coffee.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${coffee.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
