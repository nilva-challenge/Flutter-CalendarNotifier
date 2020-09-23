import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class Credentials {
//   final _credentials = new ServiceAccountCredentials.fromJson(r'''
// {
//   "private_key_id": "9d82276720e5b604e276adf58a87b49b38585b9d",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrOLvPgEm4Mynf\nFmSOVUhlFz7twIVMhYE+51l7skh7P6f5wr82gaSm6yUh3CWqQ4r3E6roqJNkU2xs\nMhREI5W22xhGthJJljYL9CEmqRA6S6fsadYAPEN7IjIhYC+N+59vdiXQn/MwZguG\nCgk/3AX0g85Twe/iQ4Nt7T4MnWJUNvhYrdDoVZbW3fB5ubx7jE4yU8Y0kJmFFiFI\n9dySeoIXiaDVpT00wlVCCKr5mYGBYvIWc0obRq61+MEmNzcXWnLYh3QbGEreVfYw\nR4opFmRtagFVgaJ7PpYmVzku9BPx9N7oaMzoaOnuY1gYrb9ghD90RUQst07Z416x\nIexBHMW9AgMBAAECggEABYTRzJ65j0noUViaduxuSlS4lwBxjcNCSS5NTtJXd2Jh\noGzjyR/eapWhy1+Q//FUvxg7FhChzQGBglNp53TGmg+h4QFPuIRExunuIub6fL8c\nmkPHL+Ec0P6wWgj6UtluiDDNvrpD9k9vt7jrKZ4rO682D1cj1KmoEbsH2O91S97o\nnBRFLJpcosR4Wht0otOX2PYF8DAxYY9ckq/LoeQzKCZ/xKRQRJM+lWDVMc1fSV0q\nj1Ci3giCl3z0SL+uLEgUR6b1UmL2S2qf5c9Vzegy3iGQvwqvg008dZpZVnZNoMJ6\nM7/TeojnmIKFhZ/7Belj5gJcZiF4waTYQ0pFs1220QKBgQDh9Ehxukk9L+EAw1qB\nTZPpLY9tF7ks7zCtbplfJxEFwVNrX01+ALANjgjbYPlHotKxh2LFwrXiJ6jebOEf\nbeTKJxtnbo1JKAVtQOm0Xx+x0nwqK2oOJX0yVuauW9l9+a0bavlvki+lQheCob/e\nc+o+D/ph7aIMYFAguq0dXxkGsQKBgQDB/UunOaKBZT0OoeAVHQ3LNIXPJbc6GMO9\nzHmdWh6db3Kpeb5U8lVN/pNb6/Pz9SmTLGfKU0zRdKUDqJp7rr57bB7Q4aQ9Yeg9\nObbPHaPvaB6qGWXZKd4bLB3Zvwr539bWPhjYuGfd/Ps1aEYMOCKEqTJBJKhibuyX\neaTh76eKzQKBgCYOXL064Ob7T2wveujYRhc54zQ+kKOuzYYIYLCUBdvwSbqF3Kli\nOESwLXG1jYaxN8dKxCoGt1eV0m1T7T675ZLer1DmX8l4giF6k2Ibu1zZ1KvNkBk9\n2y5FUKkBM0pyaON7SvOtrXSqAwevcn9nCobVbhhcS7TF6/j3N/0AbVihAoGBAIcz\nbkLCXIwqbv9/upl8glyZ4piZBLatA9+IX0pXwPag8h1ECG9T5jhRsYpjTMc+mxdD\n36KXo/ZngYqnO+PvyjpjBKc4XCubzSy+yLZZRiRZQOX0hZNxJqdxe+yCxbeZVjZD\nWTXScDG7W6nBXvCtPwGOmsPkNKdGAAcidNQzH2YRAoGAN3hI+g/zs4olYOf6OAkc\nUtM+ASnw6RcniFymTGt/uDhhmz9kQnoZRp+oB/RMYmfNp6NQDUhOtU4qUPzTQVRS\nYq0O8NujoXmLFy2CcoXaqaqpL8RrcuFAcZ5Q2wvtaq/eU1H6Sa6KPwQacacNT9lu\nE6wynBwG9lAgeG5eY+xuwig=\n-----END PRIVATE KEY-----\n",
//   "client_email": "id-flutter-calendarnotifier@flutter-calendarnotifier.iam.gserviceaccount.com",
//     "client_id": "108354503707013026488",
//   "type": "service_account"
// }
// ''');

//   static const _SCOPES = const [CalendarApi.CalendarScope];

//   void getCalendarEvents() async {
//     clientViaServiceAccount(_credentials, _SCOPES).then((client) {
//       var calendar = new CalendarApi(client);
//       // var calEvents = calendar.events.list("primary");
//       var calEvents = calendar.events.list(
//           "id-flutter-calendarnotifier@flutter-calendarnotifier.iam.gserviceaccount.com");
//       calEvents.then((Events events) {
//         print('EVENTS: ' + events.items.length.toString());
//         print('EVENTS TimeZone: ' + events.timeZone);
//         print('EVENTS: ' + events.accessRole);
//         events.items.forEach((Event event) {
//           print(event.summary);
//         });
//       });
//     });
//   }

// get Service Account Credentials
  final accountCredentials = new ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "flutter-calendarnotifier",
    "private_key_id": "9d82276720e5b604e276adf58a87b49b38585b9d",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrOLvPgEm4Mynf\nFmSOVUhlFz7twIVMhYE+51l7skh7P6f5wr82gaSm6yUh3CWqQ4r3E6roqJNkU2xs\nMhREI5W22xhGthJJljYL9CEmqRA6S6fsadYAPEN7IjIhYC+N+59vdiXQn/MwZguG\nCgk/3AX0g85Twe/iQ4Nt7T4MnWJUNvhYrdDoVZbW3fB5ubx7jE4yU8Y0kJmFFiFI\n9dySeoIXiaDVpT00wlVCCKr5mYGBYvIWc0obRq61+MEmNzcXWnLYh3QbGEreVfYw\nR4opFmRtagFVgaJ7PpYmVzku9BPx9N7oaMzoaOnuY1gYrb9ghD90RUQst07Z416x\nIexBHMW9AgMBAAECggEABYTRzJ65j0noUViaduxuSlS4lwBxjcNCSS5NTtJXd2Jh\noGzjyR/eapWhy1+Q//FUvxg7FhChzQGBglNp53TGmg+h4QFPuIRExunuIub6fL8c\nmkPHL+Ec0P6wWgj6UtluiDDNvrpD9k9vt7jrKZ4rO682D1cj1KmoEbsH2O91S97o\nnBRFLJpcosR4Wht0otOX2PYF8DAxYY9ckq/LoeQzKCZ/xKRQRJM+lWDVMc1fSV0q\nj1Ci3giCl3z0SL+uLEgUR6b1UmL2S2qf5c9Vzegy3iGQvwqvg008dZpZVnZNoMJ6\nM7/TeojnmIKFhZ/7Belj5gJcZiF4waTYQ0pFs1220QKBgQDh9Ehxukk9L+EAw1qB\nTZPpLY9tF7ks7zCtbplfJxEFwVNrX01+ALANjgjbYPlHotKxh2LFwrXiJ6jebOEf\nbeTKJxtnbo1JKAVtQOm0Xx+x0nwqK2oOJX0yVuauW9l9+a0bavlvki+lQheCob/e\nc+o+D/ph7aIMYFAguq0dXxkGsQKBgQDB/UunOaKBZT0OoeAVHQ3LNIXPJbc6GMO9\nzHmdWh6db3Kpeb5U8lVN/pNb6/Pz9SmTLGfKU0zRdKUDqJp7rr57bB7Q4aQ9Yeg9\nObbPHaPvaB6qGWXZKd4bLB3Zvwr539bWPhjYuGfd/Ps1aEYMOCKEqTJBJKhibuyX\neaTh76eKzQKBgCYOXL064Ob7T2wveujYRhc54zQ+kKOuzYYIYLCUBdvwSbqF3Kli\nOESwLXG1jYaxN8dKxCoGt1eV0m1T7T675ZLer1DmX8l4giF6k2Ibu1zZ1KvNkBk9\n2y5FUKkBM0pyaON7SvOtrXSqAwevcn9nCobVbhhcS7TF6/j3N/0AbVihAoGBAIcz\nbkLCXIwqbv9/upl8glyZ4piZBLatA9+IX0pXwPag8h1ECG9T5jhRsYpjTMc+mxdD\n36KXo/ZngYqnO+PvyjpjBKc4XCubzSy+yLZZRiRZQOX0hZNxJqdxe+yCxbeZVjZD\nWTXScDG7W6nBXvCtPwGOmsPkNKdGAAcidNQzH2YRAoGAN3hI+g/zs4olYOf6OAkc\nUtM+ASnw6RcniFymTGt/uDhhmz9kQnoZRp+oB/RMYmfNp6NQDUhOtU4qUPzTQVRS\nYq0O8NujoXmLFy2CcoXaqaqpL8RrcuFAcZ5Q2wvtaq/eU1H6Sa6KPwQacacNT9lu\nE6wynBwG9lAgeG5eY+xuwig=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "id-flutter-calendarnotifier@flutter-calendarnotifier.iam.gserviceaccount.com",
    "client_id": "108354503707013026488",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/id-flutter-calendarnotifier%40flutter-calendarnotifier.iam.gserviceaccount.com"
  });

// defines the scopes for the calendar api
  var _scopes = [CalendarApi.CalendarScope];

  void getCalendarEvents() {
    clientViaServiceAccount(accountCredentials, _scopes).then((client) {
      var calendar = new CalendarApi(client);
      var calEvents = calendar.events.list(
          "id-flutter-calendarnotifier@flutter-calendarnotifier.iam.gserviceaccount.com");
      calEvents.then((Events events) {
        print('EVENTS: ' + events.items.length.toString());
        events.items.forEach((Event event) {
          print('EVENTS: ' + events.items.length.toString());
          print(event.summary);
        });
      });
    });
  }
}
