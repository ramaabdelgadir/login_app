import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/external/widget/custom_loading.dart';
import 'package:login_app/external/widget/custom_store_card.dart';
import 'package:login_app/main/services/favo_store_service/favo_store_bloc.dart';
import 'package:login_app/external/model/store_model.dart';
import 'package:login_app/single_store/view/single_store_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavoStoresView extends StatelessWidget {
  FavoStoresView({super.key});

  final FavoStoreBloc favoStoreBloc = FavoStoreBloc();

  @override
  Widget build(BuildContext context) {
  favoStoreBloc.add(GetAllStoresFromFavoEvent());
    return BlocBuilder<FavoStoreBloc, FavoStoreState>(
      bloc: favoStoreBloc,
      builder: (context, state) {
        switch(state.runtimeType){
          case GetAllStoresFromFavoSuccessState:{
            state = state as GetAllStoresFromFavoSuccessState;
            final storesList = state.storesList;
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
                    onTap: () async {
                       await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => SingleStoreView(
                                storeModel: storesList[i]
                              ),
                        ),
                      );
                      favoStoreBloc.add(GetAllStoresFromFavoEvent());
                 
                    },
                    child: CustomStoreCard(
                      storeModel: storesList[i]
                    ),
                  );
                },
              ),
            ],
          ),
        );
            }
        case GetAllStoresFromFavoLoadingState:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            CustomLoading()
          ],);

        case GetAllStoresFromFavoFailedState:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("There is an Error Occur")
              ],)
            ],
          );
          case GetAllStoresFromFavoZeroStoreState:
            return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("You Don't Have Any Favo. Stores")
              ],)
            ],
          );
          default:
           return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            CustomLoading()
          ],);
        }
         
      },
    );
  }
}
