import 'package:faker/faker.dart';

class StoresController {
  String getRandomImage(){
    return faker.image.image(random: true);
  }
}