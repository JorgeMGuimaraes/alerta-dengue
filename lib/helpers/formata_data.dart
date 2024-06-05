String? formataData(String value) {
  if (value.length != 10) {
    return null;
  }

  List<String> partes = value.split('/');
  if (partes.length != 3) {
    return null;
  }

  return '${partes[2]}-${partes[1]}-${partes[0]}';
}
