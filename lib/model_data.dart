import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String name;
  final String namedata;

  const Data({
    required this.name,
    required this.namedata,
  });
  Data copyWith({
    String? name,
    String? namedata,
  }) {
    return Data(
      name: name ?? this.name,
      namedata: namedata ?? this.namedata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'namedata': namedata,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] ?? '',
      namedata: map['namedata'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        name,
        namedata,
      ];
}
