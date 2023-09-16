class MenClothing {
  final String idCloth;
  final String name;
  final List img;
  final String description;
  final int price;
  final int oldPrice;
  final int sold;
  final String category;
  final String currency;
  final String sale;

  MenClothing({
    required this.idCloth,
    required this.name,
    required this.img,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.category,
    required this.sold,
    required this.currency,
    required this.sale,
  });

  Map<String, dynamic> toJson() => {
        "idCloth": idCloth,
        "name": name,
        "img": img,
        "description": description,
        "price": price,
        "oldPrice": oldPrice,
        "category": category,
        "currency": currency,
        "sold": sold,
        "sale": sale,
      };

  static MenClothing fromJson(Map<String, dynamic> json) => MenClothing(
        idCloth: json['idCloth'],
        name: json['name'],
        img: json['img'],
        description: json['description'],
        price: json['price'],
        oldPrice: json['oldPrice'],
        category: json['category'],
        currency: json['currency'],
        sold: json['sold'],
        sale: json['sale'],
      );
}
