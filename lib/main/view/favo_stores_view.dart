import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/external/widget/custom_store_card.dart';
import 'package:login_app/stores/model/store_model.dart';
import 'package:login_app/stores/view/single_store_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavoStoresView extends StatelessWidget {
  const FavoStoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              color: Colors.white,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverGrid.builder(
                    itemCount: 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () async{
                          final response = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SingleStoreView(storeModel: StoreModel(id: 1, name: "name", review: 3, image: StoreModel.getRandomImage(), store_location_latitude: 5, store_location_longitude: 2,favo:false),),
                            ),
                          );
                          // if (response["add-to-favo"]){
                          //   SingleStoreController.addStoreToFavo(response['storeid']);
                          //   BlocListener<StoresBloc, StoresState>(
                          //     bloc: SingleStoreController.storesBloc,
                          //     listener: (context, state) {
                          //       switch(state.runtimeType){
                          //         case AddStoreToFavoSuccessState:{
                          //          state = state as AddStoreToFavoSuccessState;
                          //          showTopSnackBar(
                          //           Overlay.of(context),
                          //           CustomSnackBar.success(message: state.message),
                          //         );
                          //         }
                          //         case AddStoreToFavoFailedState:{
                          //          state = state as AddStoreToFavoSuccessState;
                          //          showTopSnackBar(
                          //           Overlay.of(context),
                          //           CustomSnackBar.error(message: state.message),
                          //         );
                          //         }
                          //         default:{}
                          //         }
                          //     }
                              
                          //   );
                          // }else{}
                        },
                        child: CustomStoreCard(storeModel:StoreModel(id: 1, name: "name", review: 3, image: StoreModel.getRandomImage(), store_location_latitude: 5, store_location_longitude: 2,favo:false)),
                      );
                    },
                  ),
                ],
              ),
            );
  }
}