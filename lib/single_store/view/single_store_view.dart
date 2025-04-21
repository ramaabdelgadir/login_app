import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login_app/external/model/store_model.dart';
import 'package:login_app/external/widget/custom_loading.dart';
import 'package:login_app/single_store/service/single_store_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SingleStoreView extends StatelessWidget {
  final StoreModel storeModel;
  SingleStoreView({required this.storeModel});
  final SingleStoreBloc singleStoreBloc = SingleStoreBloc();
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
          storeModel.name,
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
                          storeModel.image,
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
                        storeModel.name,

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
                        icon: BlocBuilder<SingleStoreBloc, SingleStoreState>(
                          bloc: singleStoreBloc,
                          builder: (context, state) {
                            if(!storeModel.favo){
                              switch(state.runtimeType){
                                case SingleStoreAddingLoadingState:
                                  
                                  return Icon(
                                         Icons.favorite,
                                    color:
                                        AppColors.mainColor,
                                    size: 30,
                                  );
                                case SingleStoreAddingSuccessState:
                                  return Icon(
                                         Icons.favorite,
                                    color:
                                        Colors.red,
                                    size: 30,
                                  );
                                case SingleStoreAddingFailedState:{
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(message:"an Error Occure"),
                                  );
                                   return Placeholder();
                                  }

                                default:
                                  return Icon(
                                         Icons.favorite_border,
                                    color:
                                        Colors.grey,
                                    size: 30,
                                  );
                              }
                            }else{
                              switch(state.runtimeType){
                                
                                case SingleStoreRemovingFromLoadingState:
                                  return Icon(
                                         Icons.favorite,
                                    color:
                                        AppColors.mainColor,
                                    size: 30,
                                  );
                                case SingleStoreRemovingFromSuccessState:
                                  return Icon(
                                         Icons.favorite_border,
                                    color:
                                        Colors.grey,
                                    size: 30,
                                  );
                                case SingleStoreRemovingFromFailedState:{
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(message:"an Error Occure"),
                                  );
                                   return Placeholder();
                                  }

                                default:
                                  return Icon(
                                         Icons.favorite,
                                    color:
                                        Colors.red,
                                    size: 30,
                                  );
                              }

                            }
                          },
                        ),
                        tooltip: 'Add to Favorites',
                        onPressed: () {
                          if (!storeModel.favo){
                            singleStoreBloc.add((AddStoreToFavoEvent(storeModel: storeModel)));
                          }else{
                            singleStoreBloc.add(RemoveStoreFromFavoEvent(storeid: storeModel.id));
                          }
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RatingBarIndicator(
                      rating: storeModel.review,
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
