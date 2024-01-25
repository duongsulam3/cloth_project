class BannerClothing {
  final String idBanner;
  final String caption;
  final String img;

  BannerClothing ({
    required this.idBanner,
    required this.caption,
    required this.img,
});

  Map<String, dynamic> toJson() => {
    "idBanner": idBanner,
    "caption": caption,
    "img": img,
  };

  static BannerClothing fromJson(Map<String, dynamic> json) => BannerClothing(
    idBanner: json['idBanner'],
    caption: json['caption'],
    img: json['img'],
  );
}