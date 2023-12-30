class Hardware {
  final String chipModel;
  final int chipCores;
  final int chipRevision;
  final String flashChipMode;
  final int flashChipSize;
  final int flashChipSpeed;
  final int macAddress;
  final int heapSize;
  final int freeHeapSize;
  final int psramSize;
  final int freePsramSize;
  final String sdkVersion;

  Hardware(
      {this.chipModel = "",
      this.chipCores = -1,
      this.chipRevision = -1,
      this.flashChipMode = "",
      this.flashChipSize = -1,
      this.flashChipSpeed = -1,
      this.macAddress = -1,
      this.heapSize = -1,
      this.freeHeapSize = -1,
      this.psramSize = -1,
      this.freePsramSize = -1,
      this.sdkVersion = ""});

  factory Hardware.fromJson(Map<String, dynamic> json) {
    return Hardware(
      chipModel: json['chipModel'],
      chipCores: json['chipCores'] as int,
      chipRevision: json['chipRevision'] as int,
      flashChipMode: json['flashChipMode'],
      flashChipSize: json['flashChipSize'] as int,
      flashChipSpeed: json['flashChipSpeed'] as int,
      macAddress: json['macAddress'] as int,
      heapSize: json['heapSize'] as int,
      freeHeapSize: json['freeHeapSize'] as int,
      psramSize: json['psramSize'] as int,
      freePsramSize: json['freePsramSize'] as int,
      sdkVersion: json['sdkVersion'],
    );
  }
}
