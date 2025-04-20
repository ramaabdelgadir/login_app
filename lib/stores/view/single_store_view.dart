import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_app/main/controller/stores_controller.dart';
import 'package:login_app/stores/controller/service/bloc/stores_bloc.dart';
import 'package:login_app/stores/controller/single_store_controller.dart';
import 'package:login_app/stores/model/store_model.dart';

class SingleStoreView extends StatefulWidget {
  SingleStoreView({super.key, required this.storeModel});
  final StoreModel storeModel;

  @override
  State<SingleStoreView> createState() => _SingleStoreViewState();
}

class _SingleStoreViewState extends State<SingleStoreView> {
  late SingleStoreController _controller;
  @override
  void initState() {
    _controller = SingleStoreController(storeModel: widget.storeModel);
    print(_controller.NEW_IS_FAVO_VALUE);
    super.initState();
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
          _controller.storeModel.name,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
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
    
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 250,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
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
                    ),
                  ),
                ],
              ),
            ),
    
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
                  ),
                ],
              ),
            ),
    
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
