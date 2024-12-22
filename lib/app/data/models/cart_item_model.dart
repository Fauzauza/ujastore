class CartItem {
  final String itemId;
  final String gameName;
  final String itemName;
  final String price;
  final String? userId;
  final String? serverId;

  CartItem({
    required this.itemId,
    required this.gameName,
    required this.itemName,
    required this.price,
    this.userId,
    this.serverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'gameName': gameName,
      'itemName': itemName,
      'price': price,
      'userId': userId,
      'serverId': serverId,
    };
  }

  static CartItem fromMap(String id, Map<String, dynamic> map) {
    return CartItem(
      itemId: id,
      gameName: map['gameName'],
      itemName: map['itemName'],
      price: map['price'],
      userId: map['userId'],
      serverId: map['serverId'],
    );
  }
}
