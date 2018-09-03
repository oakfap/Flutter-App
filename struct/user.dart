import 'package:flutter/material.dart';

class User {
  final String id;
  final String stationid;
  final String email;
  final String password;
  final int money;
  User({
    @required this.id,
    @required this.stationid,
    @required this.email,
    @required this.password,
    @required this.money
  });
}
