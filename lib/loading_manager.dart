class LoadingManager {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
  }
}

// Singleton pattern to ensure a single instance throughout the app
LoadingManager loadingManager = LoadingManager();
