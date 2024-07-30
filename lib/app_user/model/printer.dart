import 'package:hive/hive.dart';

part 'printer.g.dart';

@HiveType(typeId: 1)
class Printer {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? typePrinter;
  @HiveField(2)
  String? ipPrinter;
  @HiveField(3)
  bool? print;
  @HiveField(4)
  bool? autoPrint;

  Printer(
      {this.name,
      this.typePrinter,
      this.ipPrinter,
      this.print,
      this.autoPrint});
}
