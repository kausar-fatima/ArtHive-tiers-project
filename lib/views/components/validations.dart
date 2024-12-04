class InputValidators {
  // Name Validation - Ensures the name doesn't contain numbers or special characters
  static String? validateName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    // Allowing letters, spaces, apostrophes, hyphens, and accented characters
    final RegExp nameRegex = RegExp(r"^[a-zA-Zà-öÀ-Ö\s\'\-]+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Name cannot contain numbers or special characters';
    }
    return null;
  }

  // Title Validation - Ensures the title is not empty
  static String? validateTitle(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    // Optional: Check for minimum length
    if (value.length < 3) {
      return 'Title should be at least 3 characters long';
    }
    return null;
  }

  // Artist Name Validation - Ensures the artist name is not empty
  static String? validateArtistName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Artist Name is required';
    }
    return null;
  }

  // Description Validation - Ensures the description is not empty
  static String? validateDesc(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    // Optional: Check for minimum length
    if (value.length < 10) {
      return 'Description should be at least 10 characters long';
    }
    return null;
  }

  // Art Style Validation - Ensures the art style is not empty
  static String? validateStyle(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Art Style is required';
    }
    return null;
  }

  // Email Validation - Ensures a valid email format
  static String? validateEmail(String? value) {
    value = value?.trim();
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

  // Password Validation - Ensures a valid password (at least 6 characters)
  static String? validatePassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    // Optional: Check for a number, uppercase, and special character
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  // Price Validation - Ensures the price is a valid number (optional decimals)
  static String? validatePrice(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final RegExp priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!priceRegex.hasMatch(value)) {
      return 'Please enter a valid price';
    }
    // Optional: Check for max price limit
    final price = double.tryParse(value);
    if (price != null && price > 10000) {
      return 'Price cannot exceed 10,000';
    }
    return null;
  }

  // Phone Number Validation - Ensures the phone number is valid
  static String? validatePhoneNumber(String? value) {
    value = value?.trim();
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
