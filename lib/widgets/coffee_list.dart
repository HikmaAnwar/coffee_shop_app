import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/coffee.dart';

class CoffeeList extends StatelessWidget {
  final String selectedCategory;

  CoffeeList({required this.selectedCategory});

  // Mock data - you can replace this with real API data later
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
      ),
      Coffee(
        id: '2',
        name: 'Cappuccino',
        description: 'Perfect blend of espresso and steamed milk',
        price: 4.50,
        imageUrl:
            'https://images.unsplash.com/photo-1572442388796-11668a64e546?w=200',
        category: 'Cappuccino',
      ),
      Coffee(
        id: '3',
        name: 'Latte',
        description: 'Smooth and creamy coffee',
        price: 4.00,
        imageUrl:
            'https://images.unsplash.com/photo-1541167760496-1628856a772a?w=200',
        category: 'Latte',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final coffeeList = getCoffeeList();
    final filteredList = selectedCategory == 'All'
        ? coffeeList
        : coffeeList
              .where((coffee) => coffee.category == selectedCategory)
              .toList();

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
        return CoffeeCard(coffee: coffee);
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;

  CoffeeCard({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(coffee.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
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
    );
  }
}
