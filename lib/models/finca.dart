/// Datos de la finca de un productor (campesino).
/// Representa la información que conecta al productor del campo con la ciudad.
/// Por ahora se guarda en memoria; más adelante irá al backend.
class Finca {
  String productor;   // nombre del campesino
  String nombreFinca; // ej: "Finca La Esperanza"
  String ubicacion;   // vereda / municipio, ej: "Vereda El Salitre, Fómeque"
  String contacto;    // teléfono / WhatsApp
  String queCultivo;  // ej: "Frutas de clima frío, cosecha propia"

  Finca({
    this.productor = '',
    this.nombreFinca = '',
    this.ubicacion = '',
    this.contacto = '',
    this.queCultivo = '',
  });

  /// Copia la finca cambiando solo los campos indicados (útil al editar).
  Finca copyWith({
    String? productor,
    String? nombreFinca,
    String? ubicacion,
    String? contacto,
    String? queCultivo,
  }) {
    return Finca(
      productor: productor ?? this.productor,
      nombreFinca: nombreFinca ?? this.nombreFinca,
      ubicacion: ubicacion ?? this.ubicacion,
      contacto: contacto ?? this.contacto,
      queCultivo: queCultivo ?? this.queCultivo,
    );
  }
}
