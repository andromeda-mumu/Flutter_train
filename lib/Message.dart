class Message{
  final String msg;
  final int timestamp;

  Message(this.msg,this.timestamp);
  Message.create(String msg):msg= msg,timestamp=DateTime.now().millisecondsSinceEpoch;
  Map<String,dynamic> toJson()=>{
    "msg":"$msg",
    "timestamp":timestamp
  };
  Message.fromJson(Map<String,dynamic> json):msg= json['msg'],timestamp=json['timestamp'];

  @override
  String toString() {
    // TODO: implement toString
    return 'message{msg:$msg ,timestamp:$timestamp}';
  }
}

