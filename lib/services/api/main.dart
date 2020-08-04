library api;

//TODO: сюда весь апи из ../api.dart (по примеру ./user.dart)

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter/cupertino.dart';
import '../api/../dio.dart';
import 'package:http/http.dart' as http;

part 'user.dart';
part 'search.dart';
part 'authentication.dart';
part 'subscription.dart';

enum EntityType { Movie, Video, Sport, Playlist }
