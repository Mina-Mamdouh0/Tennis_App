import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'evenet_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'event_calendar.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            startTime INTEGER,
            endTime INTEGER,
            subject TEXT,
            color INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertEvent(EventModel event) async {
    final db = await database;
    await db.insert('events', event.toMap());
  }

  Future<List<EventModel>> getAllEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (i) {
      return EventModel(
        startTime: DateTime.fromMillisecondsSinceEpoch(maps[i]['startTime']),
        endTime: DateTime.fromMillisecondsSinceEpoch(maps[i]['endTime']),
        subject: maps[i]['subject'],
        color: Color(maps[i]['color']),
      );
    });
  }
}
