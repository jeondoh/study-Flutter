class ShoppingItemModel {
  // 이름
  final String name;
  // 개수
  final int quantity;
  // 구매여부
  final bool hasBought;
  // 맵기 여부
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });
}
