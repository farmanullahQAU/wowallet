import 'package:get/get.dart';

class ConfirmSeedController extends GetxController {
  int currentIndex = 0;
  int nextIndex = 0;
  RxList<String> seeds = RxList();
  RxList<Map<String, dynamic>> shufflePhrase = RxList();
  RxList<String> selectedSeeds = RxList();

  initLists(List<String> phrase) {
    print(phrase);
    seeds = phrase.obs;
    final shuffle = phrase;
    shuffle.shuffle();
    shufflePhrase = shuffle
        .map((e) => {
              "value": e,
              'isSelected':
                  false, // Add the additional key 'isSelected' with the desired value
            })
        .toList()
        .obs;

    selectedSeeds = List.generate(phrase.length, (index) => "").toList().obs;
  }

  onTapValue(dynamic value) {
    final index = shufflePhrase.indexOf(value);

    if (value["isSelected"] == false) {
      selectedSeeds[currentIndex] = value["value"];
      currentIndex < (seeds.length - 1) ? (currentIndex += 1) : null;
    } else {
      try {
        final index = selectedSeeds.indexOf(value["value"]);

        selectedSeeds[index] = "";
      } catch (e) {}

      currentIndex = index;
    }
    shufflePhrase[index]["isSelected"] = !value["isSelected"];

    shufflePhrase.refresh();
  }

  bool compareStringLists() {
    // Check if the lengths are equal
    if (seeds.length != selectedSeeds.length) {
      return false;
    }

    // Compare each element in the same order
    for (int i = 0; i < seeds.length; i++) {
      if (seeds[i] != selectedSeeds[i]) {
        return false;
      }
    }

    // If all elements are equal, return true
    return true;
  }

  onTapChip(int index) {
    currentIndex = index;
    selectedSeeds.refresh();
  }
}
