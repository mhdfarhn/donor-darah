class AppValidator {
  static String? bloodType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih golongan darah anda';
    }
    return null;
  }

  static String? role(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih role anda';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan nama anda';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan alamat email anda';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan kata sandi anda';
    }
    if (value.length < 8) {
      return 'Kata sandi minimal 8 karakter';
    }
    return null;
  }

  static String? status(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih status anda';
    }
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan nomor handphone anda';
    }
    return null;
  }

  static String? gender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih jenis kelamin anda';
    }
    return null;
  }

  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih tanggal';
    }
    return null;
  }
}
