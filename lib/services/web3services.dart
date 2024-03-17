import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Web3Services extends GetxController {
  Web3Client? client;

  double? balance = 0;
  EthereumAddress? manager;
  String rpcUrl =
      "https://eth-sepolia.g.alchemy.com/v2/hoA0bBbfP3K24FIS1RnOCLOK7ZFPCyy5";

  @override
  void onInit() async {
    client = Web3Client(rpcUrl, Client());

    await initData();

    super.onInit();
  }

  Future initData() async {
    try {} catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<EtherAmount> getAccountBalance(EthereumAddress address) async {
    return await client!.getBalance(address);
  }

// Function to listen to the NFTAdded event

  Future<BigInt> getEstimatedGasLimit(Credentials credentials) async {
    return await client!.estimateGas(
      sender: credentials.address,
    );
  }

  Future<BigInt> estimateGasLocally(Transaction transaction) async {
    try {
      final BigInt? simulationResult = await client?.estimateGas(
        sender: transaction.from,
        to: EthereumAddress.fromHex("address"),
        value: transaction.value,
        data: transaction.data,
      );
      return simulationResult!;
    } catch (error) {
      // Handle simulation error
      print("Error estimating gas locally: $error");
      return BigInt.zero;
    }
  }
}
