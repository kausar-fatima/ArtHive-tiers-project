class InputValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }

    return null;
  }

  static String? validateArtistName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Artist Name is required';
    }

    return null;
  }

  static String? validateDesc(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }

    return null;
  }

  static String? validateStyle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Art Style is required';
    }

    return null;
  }

  // Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Price Validation
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final RegExp priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!priceRegex.hasMatch(value)) {
      return 'Please enter a valid price';
    }
    return null;
  }

  // Phone Number Validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
