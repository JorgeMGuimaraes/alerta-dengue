import 'package:intl/intl.dart';

/// Guarda informacoes da request a serem repassadas a proxima screen.
class DadosRequest {
  //"https://info.dengue.mat.br/api/alertcity?
  //geocode=3304557&disease=dengue&format=json&ew_start=1&ew_end=50&ey_start=2017&ey_end=2017";

  String dataInicio, //yyyy-mm-dd
      dataFim, //yyyy-mm-dd
      geocode,
      disease,
      ewStart = '', //ew_start
      ewEnd = '', //ew_end
      eyStart = '', //ey_start
      eyEnd = ''; //ey_end

  DadosRequest({
    required this.disease,
    required this.geocode,
    required this.dataInicio,
    required this.dataFim,
  }) {
    dataInicio = formataData(dataInicio);
    dataFim = formataData(dataFim);
    ewStart = getSemana(dataInicio);
    ewEnd = getSemana(dataFim);
    eyStart = getAno(dataInicio);
    eyEnd = getAno(dataFim);
  }

  String formataData(String valor) {
    List<String> partes = valor.split('/');
    return '${partes[2]}-${partes[1]}-${partes[0]}';
  }

  String getSemana(String data) {
    DateTime dateTime = DateTime.parse(data);
    int diaDoAno = int.parse(DateFormat('D').format(dateTime));
    return ((diaDoAno - dateTime.weekday + 10) / 7).floor().toString();
  }

  String getAno(String data) {
    DateTime dateTime = DateTime.parse(data);
    return dateTime.year.toString();
  }
}
