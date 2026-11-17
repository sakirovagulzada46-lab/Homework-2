import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Контакты',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContactsScreen(),
    );
  }
}

// Простая модель данных для контакта
class Contact {
  final String name;
  final String phone;
  final Color avatarColor;

  Contact({
    required this.name,
    required this.phone,
    required this.avatarColor,
  });
}

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  // Список имен и фамилий для генерации рандомных данных
  static const List<String> _firstNames = [
    'Алексей', 'Мария', 'Иван', 'Ольга', 'Дмитрий', 
    'Анна', 'Сергей', 'Елена', 'Андрей', 'Ирина', 
    'Максим', 'Кристина', 'Артем', 'Виктория'
  ];

  static const List<String> _lastNames = [
    'Иванов', 'Смирнова', 'Кузнецов', 'Попова', 'Васильев', 
    'Петрова', 'Соколов', 'Михайлова', 'Федоров', 'Морозова', 
    'Волков', 'Лебедева', 'Семенов', 'Павлова'
  ];

  // Метод для генерации 14 рандомных пользователей
  List<Contact> _generateContacts() {
    final Random random = Random();
    List<Contact> contacts = [];

    for (int i = 0; i < 14; i++) {
      String name = '${_firstNames[random.nextInt(_firstNames.length)]} ${_lastNames[random.nextInt(_lastNames.length)]}';
      
      // Генерируем случайный номер телефона
      String phone = '+996 (55${random.nextInt(9)}) ${random.nextInt(900) + 100}-${random.nextInt(90) + 10}-${random.nextInt(90) + 10}';
      
      // Случайный цвет для аватарки
      Color color = Color.fromARGB(
        255,
        random.nextInt(150) + 50,
        random.nextInt(150) + 50,
        random.nextInt(150) + 50,
      );

      contacts.add(Contact(name: name, phone: phone, avatarColor: color));
    }

    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    // Получаем наш список из 14 рандомных контактов
    final List<Contact> contactsList = _generateContacts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Контакты'),
      ),
      // Используем ListView для прокручиваемого списка
      body: ListView.builder(
        itemCount: contactsList.length,
        itemBuilder: (context, index) {
          final contact = contactsList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: contact.avatarColor,
              child: Text(
                contact.name[0], // Первая буква имени в качестве аватарки
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              contact.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(contact.phone),
            trailing: const Icon(Icons.phone, color: Colors.green),
            onTap: () {
              // Простое действие при нажатии на контакт (можно оставить пустым или вывести в консоль)
              debugPrint('Нажали на контакт: ${contact.name}');
            },
          );
        },
      ),
    );
  }
}