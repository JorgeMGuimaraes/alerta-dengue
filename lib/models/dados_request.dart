/// Guarda informacoes da request a serem repassadas a proxima screen.
class DadosRequest {
    String disease;
    String geocode;
    String? epidateStart; //yyyy-mm-dd
    String? epidateEnd; //yyyy-mm-dd

    DadosRequest({
        required this.disease,
        required this.geocode,
        this.epidateStart,
        this.epidateEnd,
    });
}