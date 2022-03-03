import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:k6_app/models/area_model.dart';
import 'package:k6_app/screens/Manager/edit_area_manager.dart';
import 'package:k6_app/utility/my_constant.dart';
import 'package:k6_app/utility/my_style.dart';

class Detailarea extends StatefulWidget {
  final AreaModel areaModel;
  Detailarea({required this.areaModel});
  @override
  _DetailareaState createState() => _DetailareaState();
}

class _DetailareaState extends State<Detailarea> {
  AreaModel? areaModel;
  String? namearea, image, detail, scale, rentalfee;
  @override
  void initState() {
    super.initState();
    areaModel = widget.areaModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ข้อมูลแผง ${areaModel!.namearea}'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      MyStyle().showTitle('รูปแผง : '),
                    ],
                  ),
                  MyStyle().mySizebox(),
                  showImage(),
                  Row(
                    children: <Widget>[
                      MyStyle().showTitle('ชื่อแผง : '),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        areaModel!.namearea.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      MyStyle().showTitle('ขนาดแผง : '),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        areaModel!.scale.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      MyStyle().showTitle('รายละเอียดแผง : '),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        areaModel!.detail.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      MyStyle().showTitle('ราคาเช่าแผง : '),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        areaModel!.rentalfee.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MyStyle().showTitle('ตำแหน่งแผง : '),
                    ],
                  ),
                  MyStyle().mySizebox(),
                  showMap(),
                  MyStyle().mySizebox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (value) => Editarea(areaModel: areaModel!),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => {}),
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget showMap() {
    double lat = double.parse('${areaModel?.lat ?? '0'}');
    double lng = double.parse('${areaModel?.lng ?? '0'}');
    //print('lat = $lat, lng = $long');

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 19);

    return Container(
      height: 250,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('shopID'),
          position: LatLng(
            double.parse('${areaModel?.lat ?? '0'}'),
            double.parse('${areaModel?.lng ?? '0'}'),
          ),
          infoWindow: InfoWindow(
              title: 'ตำแหน่งแผง', snippet: 'ชื่อแผง : ${areaModel?.namearea}'))
    ].toSet();
  }

  Widget showImage() {
    print(areaModel?.image);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(
          '${MyConstant().domain}/images/areasshop/${areaModel?.image}',
          fit: BoxFit.contain,
        ));
  }
}
