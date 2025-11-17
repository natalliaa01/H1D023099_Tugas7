
# Tugas 6 Pertemuan 8

## Data Diri
-   **Nama:** `Natalia Nidya Fidelia`
-   **NIM:** `H1D023099`
-   **Shift Baru:** `E`
-   **Shift Asal:** `B`

---

## Deskripsi Singkat
Project Flutter ini dibuat untuk memenuhi tugas yang berisi implementasi:

- Halaman **Login**
- **Local Storage** menggunakan `shared_preferences`
- **Navigasi dengan Routes**
- **Side Menu (Drawer)**
- Logout & redirect otomatis
- UI sederhana, modern, dan berbeda dari modul

Aplikasi dirancang agar **rapi, mudah dipahami, dan mudah dikembangkan**.

---

## Struktur Folder
```
lib/
│
├─ main.dart
├─ pages/
│   ├─ login_page.dart
│   ├─ home_page.dart
│   └─ about_page.dart
│
└─ widgets/
    └─ sidemenu.dart
```

---

## 📘 Penjelasan Setiap File

---

# main.dart — Entry Point & Route Manager

File ini adalah titik awal aplikasi.
Tugasnya:

- Mengatur **theme aplikasi**
- Menentukan **named routes**
- Mengecek apakah user sudah login melalui `SharedPreferences`
- Melakukan **auto redirect** ke HomePage jika username tersimpan

### Cek data login dari Local Storage
```dart
Future<String?> _getSavedUsername() async {
  final sp = await SharedPreferences.getInstance();
  return sp.getString('username');
}
```

### Auto Redirect
```dart
home: FutureBuilder<String?>(
  future: _getSavedUsername(),
  builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
      return HomePage(username: snapshot.data!);
    }
    return const LoginPage();
  },
),
```

Jika username ditemukan → langsung masuk HomePage  
Jika tidak → buka LoginPage

---

# login_page.dart — Halaman Login + Validasi + Local Storage

Halaman login menangani:

- Input username dan password
- Validasi form
- Simulasi autentikasi
- Menyimpan username ke `SharedPreferences`
- Navigasi ke HomePage

### Validasi form input
```dart
validator: (v) =>
    (v == null || v.trim().isEmpty) ? 'Username tidak boleh kosong' : null,
```

### Simulasi login & penyimpanan username
```dart
final sp = await SharedPreferences.getInstance();
await sp.setString('username', user);
```

### Navigasi setelah login
```dart
Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (_) => HomePage(username: user)),
);
```
`pushReplacement()` digunakan agar user tidak bisa kembali ke halaman login menggunakan tombol back.

---

# home_page.dart — Halaman Utama

Menampilkan username yang sudah login dan menyediakan Drawer (Side Menu).

### Ambil username yang tersimpan
```dart
_username = sp.getString('username') ?? 'Guest';
```

### Logout
```dart
await sp.remove('username');
Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
```

Hapus username dari local storage → kembali ke LoginPage.

---

# sidemenu.dart — Side Menu / Drawer

Drawer berisi navigasi:

- Home
- About
- Logout
- Header profil dengan inisial username

### Header profil modern
```dart
UserAccountsDrawerHeader(
  accountName: Text(username),
  accountEmail: Text('nim@example.edu'),
)
```

### Navigasi Drawer
```dart
Navigator.pushNamed(context, AboutPage.routeName);
```

### Logout dari Drawer
```dart
onTap: () {
  Navigator.pop(context);
  onLogout();
},
```

---

# about_page.dart — Halaman Tentang Aplikasi

Halaman statis berisi:

- Penjelasan tentang aplikasi
- Fitur yang digunakan
- Perbedaan kreatif dari modul

Simple & informatif.

---

# Fitur Kreatif (Berbeda dari Modul)

- Login menggunakan **UI Card modern**
- Auto redirect ke Home jika sudah login sebelumnya
- Drawer memakai **UserAccountsDrawerHeader**
- Simulasi loading saat login
- Struktur kode lebih modular dan rapi
- Username tampil di Home & Drawer
- Validasi form lengkap dan aman

---

# Cara Menjalankan Aplikasi

1. Buka folder project
2. Jalankan perintah:
```bash
flutter pub get
flutter run
```
3. Untuk login:
- Username bebas
- **Password: `flutter`**

---

# 📸 Screenshot
![Login](assets/screenshots/login.png)
![Home](assets/screenshots/home.png)
