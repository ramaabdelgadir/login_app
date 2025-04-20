import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/external/app_data.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/external/widget/custom_loading.dart';
import 'package:login_app/external/widget/custom_store_card.dart';
import 'package:login_app/stores/controller/service/bloc/stores_bloc.dart';
import 'package:login_app/main/controller/stores_controller.dart';
import 'package:login_app/stores/controller/single_store_controller.dart';
import 'package:login_app/stores/model/store_model.dart';
import 'package:login_app/stores/view/single_store_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StoresView extends StatefulWidget {
  StoresView({super.key, required this.controller});
  final StoresController controller ;

  @override
  State<StoresView> createState() => _StoresViewState();
}

class _StoresViewState extends State<StoresView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresBloc, StoresState>(
      bloc: widget.controller.storesBloc,
      builder: (context, state) {
        switch(state.runtimeType){
          case StoresGetDataLoadingState:
            return Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomLoading(),
              ],
            );
          case StoresGetDataSuccessState:
           state = state as StoresGetDataSuccessState;
           final List storesList = state.storesList; 

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              color: Colors.white,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverGrid.builder(
                    itemCount: storesList.length,
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
                              builder: (context) => SingleStoreView(storeModel: storesList[i],),
                            ),
                          );
                          if (response["status"] ){
                            final SingleStoreController singleStoreController = SingleStoreController(storeModel: response["store-model"] );
                            if(response['value']){
                            singleStoreController.addStoreToFavo();
                            BlocListener<StoresBloc, StoresState>(
                              bloc: singleStoreController.storesBloc,
                              listener: (context, state) {
                                switch(state.runtimeType){
                                  case AddStoreToFavoSuccessState:{
                                   state = state as AddStoreToFavoSuccessState;
                                   showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(message: state.message),
                                  );
                                  }
                                  case AddStoreToFavoFailedState:{
                                   state = state as AddStoreToFavoSuccessState;
                                   showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(message: state.message),
                                  );
                                  }
                                  default:{}
                                  }
                              }
                              
                            );
                            }
                            else{
                            singleStoreController.removeStoreFromFavo();
                            BlocListener<StoresBloc, StoresState>(
                              bloc: singleStoreController.storesBloc,
                              listener: (context, state) {
                                switch(state.runtimeType){
                                  case RemoveFromFavoSuccessfulState:{
                                   state = state as AddStoreToFavoSuccessState;
                                   showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(message: state.message),
                                  );
                                  }
                                  case RemoveFromFavoFailedState:{
                                   state = state as AddStoreToFavoSuccessState;
                                   showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(message: state.message),
                                  );
                                  }
                                  default:{}
                                  }
                              }
                              
                            );
                              //  showTopSnackBar(
                              //       Overlay.of(context),
                              //       CustomSnackBar.info(message: "Remved '${response['storename']}' From Favo"),
                              //     );
                            }
                          }else{}
                        },
                        child: CustomStoreCard(storeModel:storesList[i]),
                      );
                    },
                  ),
                ],
              ),
            );
          default:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("an Error Occure"),
            ],
          )],);

        }
      },
    );
  }
}

