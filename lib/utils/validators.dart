String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Masukkan kata nama anda.';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Masukkan alamat email anda.';
  }
  return null;
}

String? roleValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Pilih role anda.';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Masukkan kata sandi anda.';
  }
  if (value.length < 8) {
    return 'Kata sandi minimal 8 karakter.';
  }
  return null;
}
