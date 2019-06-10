class Message{
  final String msg;
  final int timestamp;

  Message(this.msg,this.timestamp);

  @override
  String toString() {
    // TODO: implement toString
    return 'message{msg:$msg ,timestamp:$timestamp}';
  }
}

