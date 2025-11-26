// ignore_for_file: deprecated_member_use

import 'package:brewly/Presentation/Screens/favourites/logic/cubit/favourites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericListScreen<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String Function(T) getImage;
  final String Function(T) getName;
  final String Function(T) getDescription;
  final void Function(BuildContext, T) onItemTap;
  final String itemType;

  const GenericListScreen({
    super.key,
    required this.title,
    required this.items,
    required this.getImage,
    required this.getName,
    required this.getDescription,
    required this.onItemTap,
    required this.itemType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        surfaceTintColor: Colors.brown[50],
        title: Text(
          title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CoffeeItemCard<T>(
              item: item,
              getImage: getImage,
              getName: getName,
              getDescription: getDescription,
              onTap: () => onItemTap(context, item),
              itemType: itemType,
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms);
          },
        ),
      ),
    );
  }
}

class CoffeeItemCard<T> extends StatefulWidget {
  final T item;
  final String Function(T) getImage;
  final String Function(T) getName;
  final String Function(T) getDescription;
  final VoidCallback onTap;
  final String itemType;

  const CoffeeItemCard({
    super.key,
    required this.item,
    required this.getImage,
    required this.getName,
    required this.getDescription,
    required this.onTap,
    required this.itemType,
  });

  @override
  State<CoffeeItemCard<T>> createState() => _CoffeeItemCardState<T>();
}

class _CoffeeItemCardState<T> extends State<CoffeeItemCard<T>> {
  bool isFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final favoritesCubit = context.read<FavoritesCubit>();
    final status = await favoritesCubit.isFavorite(
      widget.getName(widget.item),
      widget.itemType,
    );
    if (mounted) {
      setState(() {
        isFavorite = status;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final favoritesCubit = context.read<FavoritesCubit>();
      await favoritesCubit.toggleFavorite(
        name: widget.getName(widget.item),
        type: widget.itemType,
        image: widget.getImage(widget.item),
        description: widget.getDescription(widget.item),
      );
      await _checkFavoriteStatus();
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    widget.getImage(widget.item),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.grey[600],
                              ),
                            )
                          : Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey[600],
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.getName(widget.item),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.getDescription(widget.item),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
