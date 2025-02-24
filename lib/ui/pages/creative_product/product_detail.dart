part of '../pages.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Widget myPopMenu() {
    return PopupMenuButton(
        child: Icon(Icons.share),
        onSelected: (value) {},
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(
                          FontAwesome.facebook,
                          color: Colors.blue,
                        ),
                      ),
                      Text('Facebook')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(FontAwesome.twitter,
                              color: Colors.lightBlue)),
                      Text('Twitter')
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(FontAwesome.whatsapp, color: Colors.green),
                      ),
                      Text('WhatsApp')
                    ],
                  )),
            ]);
  }

  bool isBisnis = false;
  int bisnisId = 0;
  List marketplace = [];
  YoutubePlayerController _controller;

  void getMarketplace() async {
    var result = await ProductServices.getMarketPlace(widget.product.produkId);
    for (final i in result.value) {
      var productMap = {
        'id': i.urlNm,
        'imageUrl': i.img,
        'name': i.name,
      };
      marketplace.add(productMap);
    }
  }

  void cekBisnis() async {
    var result = await ProductServices.getBisnis(widget.product.produkId);
    if (result.value != null) {
      setState(() {
        isBisnis = true;
        bisnisId = result.value.bisnisId;
      });
      // print(bisnisId);
    }
  }

  @override
  void initState() {
    this.cekBisnis();
    this.getMarketplace();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          (widget.product.produkImg != null)
              ? 'jL4_38V10tI'
              : widget.product.produkUrl),
      flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: true,
          loop: false,
          enableCaption: false),
    );
    super.initState();
  }

  Widget marketPlaceButton() {
    return PopupMenuButton(
        // color: Colors.transparent,
        child: Text("Beli Produk",
            style: normalFontStyle.copyWith(
                color: mainColorRed, fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        onSelected: (value) async {
          await launch(value);
        },
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          for (var i in marketplace) {
            list.add(
              PopupMenuItem(
                  value: i['id'],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Image.network(i['imageUrl'], height: 40),
                      ),
                      Text(i['name'].toString(), style: normalFontStyle),
                    ],
                  )),
            );
          }

          return list;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 60,
                ),
                (widget.product.produkImg == null)
                    ? Container(
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, 8, defaultMargin, defaultMargin),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            bottomActions: <Widget>[
                              const SizedBox(width: 14.0),
                              CurrentPosition(),
                              const SizedBox(width: 8.0),
                              ProgressBar(isExpanded: true),
                              RemainingDuration(),
                            ],
                            aspectRatio: 4 / 3,
                            progressIndicatorColor: Colors.white,
                            onReady: () {
                              print('Player is ready.');
                            },
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, 8, defaultMargin, defaultMargin),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/skeleton_image.gif'),
                              fit: BoxFit.cover,
                            )),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.product.produkImg,
                              progressIndicatorBuilder: (context, url,
                                      downloadProgress) =>
                                  SpinKitRipple(color: mainColorRed, size: 50),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              100,
                          child: Text(
                            widget.product.produkNm,
                            style: blackfontStyle1.copyWith(
                                color: "333333".toColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color(0xFFFFFFFF),
                                  offset: Offset(0.0, -1.0),
                                  blurRadius: 4.0,
                                ),
                                BoxShadow(
                                  color: Color(0xFFDFDFDF),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Color(0xFFFEFEFE),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(6.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                width: 80,
                                child: Center(
                                  child: Text(
                                    widget.product.subsector,
                                    style: normalFontStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: "D51E5A".toColor()),
                                  ),
                                ),
                              ),
                            )),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                LineBorder(),
                SizedBox(height: 20),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: defaultMargin),
                //   child: Text(
                //     "Contoh Artikel",
                //     style: blackfontStyle1.copyWith(
                //         color: "333333".toColor(),
                //         fontWeight: FontWeight.w500,
                //         fontSize: 17),
                //   ),
                // ),
                Container(
                    margin: EdgeInsets.all(defaultMargin),
                    child: Text(
                      widget.product.produkDesc,
                      style:
                          normalFontStyle.copyWith(color: "333333".toColor()),
                      textAlign: TextAlign.left,
                    )),
              ],
            ),
            Positioned(
              child: CustomHeader(
                backButton: () {
                  Get.back();
                },
                title: "Produk",
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(254, 254, 254, 0.4),
                      offset: Offset(0, -4),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (isBisnis)
                          ? InkWell(
                              onTap: () {
                                context
                                    .bloc<BisnisBloc>()
                                    .add(FetchBisnis(bisnisId));
                                Get.to(WorkshopDetail(marketplace));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                height: 40,
                                width: (MediaQuery.of(context).size.width) - 70,
                                decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(17, 18, 19, 0.3),
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  gradient: RadialGradient(colors: [
                                    "FEFEFE".toColor(),
                                    "F8F8F8".toColor(),
                                  ]),
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(5.0)),
                                ),
                                child: Center(
                                    child: Text(
                                  "Lihat Profil Usaha",
                                  style: normalFontStyle.copyWith(
                                      color: mainColorRed,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        height: 40,
                        width: (MediaQuery.of(context).size.width) - 70,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromRGBO(17, 18, 19, 0.3),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 2.0,
                            ),
                          ],
                          gradient: RadialGradient(colors: [
                            "FEFEFE".toColor(),
                            "F8F8F8".toColor(),
                          ]),
                          borderRadius:
                              BorderRadius.all(const Radius.circular(5.0)),
                        ),
                        child: Center(
                          child: FlatButton(
                            color: Colors.transparent,
                            onPressed: null,
                            child: Container(
                              width: double.infinity,
                              child: marketPlaceButton(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
