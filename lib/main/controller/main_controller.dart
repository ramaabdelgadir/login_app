import 'package:login_app/main/controller/main_profile_controller.dart';
import 'package:login_app/main/controller/stores_controller.dart';

class MainController {

  String m = "";
  int current_page_index = 1;
  List<String> appbarText =[
    "Favorite",
    "Stores",
    "Profile"
  ];
  MainController(){}
  onPageChange(int current_page_index, MainProfileController mainProfileController, StoresController storesController){
    this.current_page_index = current_page_index;
    if (current_page_index == 1){
      storesController.getStoresData();
    }
    else if (current_page_index==2){
      mainProfileController.getData();
    }
  }
}
