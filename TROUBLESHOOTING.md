# 🔧 Troubleshooting Guide

## 🚨 **No News Data Displayed?**

### **Problem**: The app shows loading but no news articles appear

### **Root Cause**

The app is configured to use mock data by default, or there's an API key issue.

### **Solutions**

#### **Option 1: Use Mock Data (Recommended for Development)**

The app is already configured to use mock data. You should see 5 sample articles:

- Flutter 3.24 Release
- Dart 3.4 Features  
- AI in Mobile Development
- Clean Architecture Best Practices
- State Management with Bloc

**Check Console**: Look for these debug messages:

```bash
🔧 ServiceLocator: Using Mock Repository for development
🔄 ArticlesBloc: Loading top headlines...
✅ ArticlesBloc: Successfully loaded 5 articles
```

#### **Option 2: Use Real News API**

1. **Get API Key**:
   - Visit [News API](https://newsapi.org/)
   - Sign up for free account
   - Copy your API key

2. **Update Configuration**:

   ```dart
   // In lib/core/config/app_config.dart
   static const bool useMockData = false; // Change to false
   static const String apiKey = 'YOUR_ACTUAL_API_KEY'; // Paste your key
   ```

3. **Restart the app** to reload dependencies

### **Debug Steps**

1. **Check Console Logs**:
   - Look for error messages
   - Verify which repository is being used

2. **Check Network Tab**:
   - If using real API, check for failed requests
   - Verify API key is being sent

3. **Check State**:
   - App should show: Initial → Loading → Loaded
   - If stuck on Loading, there's a data issue
   - If shows Error, check the error message

### **Common Issues**

- **API Key Invalid**: "Unauthorized" or "Forbidden" errors
- **Network Issues**: "Connection timeout" or "No internet" errors  
- **Rate Limiting**: "Too many requests" errors (free tier has limits)

### **Quick Fix for Testing**

```dart
// In lib/core/config/app_config.dart
static const bool useMockData = true; // Keep this true for now
```

This will show mock data immediately without any API calls.

---

## 🆘 **Still Having Issues?**

1. **Check the console** for error messages
2. **Verify the configuration** in `app_config.dart`
3. **Restart the app** completely
4. **Check Flutter doctor** for any setup issues

The mock data should work immediately and show 5 sample articles! 🚀
