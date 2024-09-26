//* Exception simples para guardar uma mensagem de error
class MessageException implements Exception {
  final String message;
  MessageException({required this.message});
}
