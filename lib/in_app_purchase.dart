import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<void> init() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      // Handle the case where in-app purchases are not available
    }
  }

  Future<void> purchaseSnakeDesign(String productId) async {
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails({productId});
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the case where the product is not found
      return;
    }

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: response.productDetails.first);
    await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }
}
