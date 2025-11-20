import 'package:brewly/domain/entities/coffeebean_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CoffeeDetailsScreen extends StatelessWidget {
  final CoffeeBean selectedCoffee;
  final List<CoffeeBean> allCoffees;

  const CoffeeDetailsScreen({
    required this.allCoffees,
    required this.selectedCoffee,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        surfaceTintColor: Colors.brown[50],
        title: Text(
          selectedCoffee.name,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 300,
              width: double.infinity,

              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(selectedCoffee.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Flavor Notes',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  ...selectedCoffee.flavorNotes.map((note) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(note, style: TextStyle(color: Colors.white)),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brewing Suggestions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedCoffee.brewingSteps.first,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ...selectedCoffee.brewingSteps
                                .skip(1)
                                .map(
                                  (step) => Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('• '),
                                        Expanded(
                                          child: Text(
                                            step,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            SizedBox(height: 10),
                            Text(
                              'Suggested Drinks',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey.shade300,
                                margin: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                            ...selectedCoffee.suggestedDrinks.map(
                              (drink) => Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        drink,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'You Might Also Like',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (_, _) => SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final mightLikeCoffee = allCoffees[index];
                        if (selectedCoffee.name == mightLikeCoffee.name) {
                          return SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CoffeeDetailsScreen(
                                  selectedCoffee: mightLikeCoffee,
                                  allCoffees: allCoffees,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                  child: Image.asset(
                                    mightLikeCoffee.image,
                                    height: 110,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  mightLikeCoffee.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ).animate().flip(delay: 1200.ms, duration: 1000.ms),
                ],
              ),
            ),
          ],
        ).animate().flip(delay: 500.ms, duration: 900.ms),
      ),
    );
  }
}
