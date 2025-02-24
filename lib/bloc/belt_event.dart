part of 'belt_bloc.dart';

abstract class BeltEvent extends Equatable {
  const BeltEvent();
}

class FetchBelt extends BeltEvent {
  @override
  List<Object> get props => [];
}

class BeltBySubsector extends BeltEvent {
  final List<int> subsector;
  BeltBySubsector(this.subsector);
  @override
  List<Object> get props => [subsector];
}

class BeltByKecamatan extends BeltEvent {
  final int kecamatanId;
  BeltByKecamatan(this.kecamatanId);
  @override
  List<Object> get props => [kecamatanId];
}

class BeltByKelurahan extends BeltEvent {
  final int kelurahanId;

  BeltByKelurahan(this.kelurahanId);
  @override
  List<Object> get props => [kelurahanId];
}

class BeltPackages extends BeltEvent {
  final List<int> belt;

  BeltPackages(this.belt);
  @override
  List<Object> get props => [belt];
}

class TourPackages extends BeltEvent {
  final int package;

  TourPackages(this.package);
  @override
  List<Object> get props => [package];
}

class Filter3 extends BeltEvent {
  final List<int> subsectorID;
  final int kecamatanID;
  final int kelurahanID;

  Filter3(this.subsectorID, this.kecamatanID, this.kelurahanID);
  @override
  List<Object> get props => [subsectorID, kecamatanID, kelurahanID];
}
