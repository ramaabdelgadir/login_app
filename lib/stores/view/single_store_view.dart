import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_app/main/controller/stores_controller.dart';
<<<<<<< HEAD
import 'package:login_app/stores/controller/service/bloc/stores_bloc.dart';
import 'package:login_app/stores/controller/single_store_controller.dart';
import 'package:login_app/stores/model/store_model.dart';

class SingleStoreView extends StatefulWidget {
  SingleStoreView({super.key, required this.storeModel});
  final StoreModel storeModel;
=======

class SingleStoreView extends StatefulWidget {
  SingleStoreView({super.key});
  final StoresController _controller = StoresController();
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)

  @override
  State<SingleStoreView> createState() => _SingleStoreViewState();
}

class _SingleStoreViewState extends State<SingleStoreView> {
<<<<<<< HEAD
  late SingleStoreController _controller;
  @override
  void initState() {
    _controller = SingleStoreController(storeModel: widget.storeModel);
    print(_controller.NEW_IS_FAVO_VALUE);
=======
  bool isFavorite = false;
  int _currentIndex = 0;
  late List<String> _storeImages;

  @override
  void initState() {
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
    super.initState();
    // TODO: store images
    _storeImages = List.generate(5, (_) => widget._controller.getRandomImage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text(
<<<<<<< HEAD
          _controller.storeModel.name,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
=======
          "'Store Titile'",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset('assets/images/logo.png', height: 50),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
<<<<<<< HEAD
    
=======

            // Store ImageS
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 250,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
<<<<<<< HEAD
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.black)],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _controller.storeModel.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    
            const SizedBox(height: 15),
    
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black)],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Store Title
                      Text(
                        _controller.storeModel.name,
    
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: const Icon(Icons.location_on),
                        tooltip: 'View Location',
                        onPressed: () {},
                        color: AppColors.mainColor,
                        iconSize: 30,
                      ),
                      IconButton(
                        icon: BlocConsumer<StoresBloc, StoresState>(
                          bloc: _controller.storesBloc,
                          listener: (context, state) {
                            switch(state.runtimeType){
                            
                            }
                          },
                          builder: (context, state) {
                            switch(state.runtimeType){
                              case AddStoreToFavoSuccessState:
                            return Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            );
                            case RemoveFromFavoSuccessfulState:
                               return Icon(
                               Icons.favorite_border,
                                color: Colors.grey,
                            );
                            default:
                               return Icon(
                               Icons.favorite_border,
                                color: Colors.grey,
                            );
                            }
                          },
                        ),
                        onPressed: () {
                            _controller.addStoreToFavo();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RatingBarIndicator(
                      rating: _controller.storeModel.review,
                      itemBuilder:
                          (context, index) =>
                              const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 25.0,
                      direction: Axis.horizontal,
=======
                    child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: _storeImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _storeImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Dots for the images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _storeImages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentIndex == index ? 16 : 8,
                        decoration: BoxDecoration(
                          color:
                              _currentIndex == index
                                  ? AppColors.mainColor
                                  : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
                    ),
                  ),
                ],
              ),
            ),
<<<<<<< HEAD
    
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black)],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descrption',
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'overview of the store what it offers and any features.',
                    style: TextStyle(fontSize: 13, height: 1.2),
=======

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Store Title
                  const Text(
                    'Store Title', //TODO: store title
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 260),
                  IconButton(
                    icon: const Icon(Icons.location_on),
                    tooltip: 'View Location',
                    onPressed: () {
                      // TODO: location logic
                    },
                    color: AppColors.mainColor,
                    iconSize: 30,
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    tooltip: 'Add to Favorites',
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
                  ),
                ],
              ),
            ),
<<<<<<< HEAD
    
=======

            // Rating Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RatingBarIndicator(
                rating: 4.0, //TODO: store rating
                itemBuilder:
                    (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
            ),

            const SizedBox(height: 20),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                //TODO: store description
                'overview of the store what it offers and any features.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),

>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
