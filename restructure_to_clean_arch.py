"""
Flutter Clean Architecture Restructurer
========================================
بيحول مشروع Flutter العادي لـ Clean Architecture
الاستخدام: python restructure_to_clean_arch.py
"""

import os
import shutil
import re
from pathlib import Path

# ===== إعدادات =====
PROJECT_PATH = r"E:\flutter project\senfaya"  # غيّر ده لو المشروع في مكان تاني
LIB_PATH = os.path.join(PROJECT_PATH, "lib")
BACKUP_PATH = os.path.join(PROJECT_PATH, "lib_backup")

# ===== Clean Architecture Structure =====
CLEAN_ARCH_FOLDERS = [
    # Core
    "core/constants",
    "core/errors",
    "core/utils",
    "core/widgets",
    "core/theme",

    # Features - Auth
    "features/auth/data/datasources",
    "features/auth/data/models",
    "features/auth/data/repositories",
    "features/auth/domain/entities",
    "features/auth/domain/repositories",
    "features/auth/domain/usecases",
    "features/auth/presentation/screens",
    "features/auth/presentation/widgets",

    # Features - Home
    "features/home/data/datasources",
    "features/home/data/models",
    "features/home/data/repositories",
    "features/home/domain/entities",
    "features/home/domain/repositories",
    "features/home/domain/usecases",
    "features/home/presentation/screens",
    "features/home/presentation/widgets",

    # Features - Menu / Products
    "features/menu/data/datasources",
    "features/menu/data/models",
    "features/menu/data/repositories",
    "features/menu/domain/entities",
    "features/menu/domain/repositories",
    "features/menu/domain/usecases",
    "features/menu/presentation/screens",
    "features/menu/presentation/widgets",

    # Features - Orders
    "features/orders/data/datasources",
    "features/orders/data/models",
    "features/orders/data/repositories",
    "features/orders/domain/entities",
    "features/orders/domain/repositories",
    "features/orders/domain/usecases",
    "features/orders/presentation/screens",
    "features/orders/presentation/widgets",

    # Features - Profile
    "features/profile/data/datasources",
    "features/profile/data/models",
    "features/profile/data/repositories",
    "features/profile/domain/entities",
    "features/profile/domain/repositories",
    "features/profile/domain/usecases",
    "features/profile/presentation/screens",
    "features/profile/presentation/widgets",
]

# ===== خريطة تحويل الـ Screens =====
SCREEN_MAPPING = {
    # Auth Feature
    "loginScreen.dart":       "features/auth/presentation/screens/login_screen.dart",
    "signUpScreen.dart":      "features/auth/presentation/screens/signup_screen.dart",
    "forgetPwScreen.dart":    "features/auth/presentation/screens/forgot_password_screen.dart",
    "newPwScreen.dart":       "features/auth/presentation/screens/new_password_screen.dart",
    "sentOTPScreen.dart":     "features/auth/presentation/screens/otp_screen.dart",
    "introScreen.dart":       "features/auth/presentation/screens/intro_screen.dart",
    "spashScreen.dart":       "features/auth/presentation/screens/splash_screen.dart",
    "landingScreen.dart":     "features/auth/presentation/screens/landing_screen.dart",

    # Home Feature
    "homeScreen.dart":        "features/home/presentation/screens/home_screen.dart",

    # Menu Feature
    "menuScreen.dart":        "features/menu/presentation/screens/menu_screen.dart",
    "dessertScreen.dart":     "features/menu/presentation/screens/dessert_screen.dart",
    "individualItem.dart":    "features/menu/presentation/screens/item_details_screen.dart",
    "offerScreen.dart":       "features/menu/presentation/screens/offers_screen.dart",

    # Orders Feature
    "checkoutScreen.dart":    "features/orders/presentation/screens/checkout_screen.dart",
    "paymentScreen.dart":     "features/orders/presentation/screens/payment_screen.dart",
    "myOrderScreen.dart":     "features/orders/presentation/screens/my_orders_screen.dart",
    "changeAddressScreen.dart": "features/orders/presentation/screens/change_address_screen.dart",

    # Profile Feature
    "profileScreen.dart":     "features/profile/presentation/screens/profile_screen.dart",
    "aboutScreen.dart":       "features/profile/presentation/screens/about_screen.dart",
    "inboxScreen.dart":       "features/profile/presentation/screens/inbox_screen.dart",
    "notificationScreen.dart": "features/profile/presentation/screens/notifications_screen.dart",
    "moreScreen.dart":        "features/profile/presentation/screens/more_screen.dart",
}

WIDGET_MAPPING = {
    "customNavBar.dart":   "core/widgets/custom_nav_bar.dart",
    "customTextInput.dart": "core/widgets/custom_text_input.dart",
    "searchBar.dart":      "core/widgets/custom_search_bar.dart",
}

CONST_MAPPING = {
    "colors.dart": "core/constants/app_colors.dart",
}

UTILS_MAPPING = {
    "helper.dart": "core/utils/helper.dart",
}


def create_folder_structure():
    """إنشاء الـ folders"""
    print("\n📁 بنعمل folder structure...")
    for folder in CLEAN_ARCH_FOLDERS:
        full_path = os.path.join(LIB_PATH, folder)
        os.makedirs(full_path, exist_ok=True)
        # نعمل .gitkeep عشان الـ folders متتمسحش من git
        gitkeep = os.path.join(full_path, ".gitkeep")
        if not os.listdir(full_path):
            open(gitkeep, 'w').close()
    print("   ✅ تم إنشاء الـ folders!")


def backup_lib():
    """Backup للـ lib القديمة"""
    if os.path.exists(BACKUP_PATH):
        shutil.rmtree(BACKUP_PATH)
    shutil.copytree(LIB_PATH, BACKUP_PATH)
    print(f"   ✅ Backup اتعمل في: lib_backup/")


def move_file(src_name, src_folder, dest_relative):
    """نقل ملف مع الحفاظ على المحتوى"""
    src = os.path.join(LIB_PATH, src_folder, src_name)
    dest = os.path.join(LIB_PATH, dest_relative)

    if not os.path.exists(src):
        print(f"   ⚠️  مش لاقي: {src_folder}/{src_name}")
        return False

    os.makedirs(os.path.dirname(dest), exist_ok=True)
    shutil.copy2(src, dest)
    print(f"   ✅ {src_folder}/{src_name}  →  {dest_relative}")
    return True


def move_all_files():
    """نقل كل الملفات"""
    print("\n🚀 بننقل الـ screens...")
    for src_name, dest in SCREEN_MAPPING.items():
        move_file(src_name, "screens", dest)

    print("\n🎨 بننقل الـ widgets...")
    for src_name, dest in WIDGET_MAPPING.items():
        move_file(src_name, "widgets", dest)

    print("\n🎨 بننقل الـ constants...")
    for src_name, dest in CONST_MAPPING.items():
        move_file(src_name, "const", dest)

    print("\n🔧 بننقل الـ utils...")
    for src_name, dest in UTILS_MAPPING.items():
        move_file(src_name, "utils", dest)


def create_barrel_files():
    """نعمل export files لكل feature"""
    print("\n📦 بنعمل barrel files...")
    features = ["auth", "home", "menu", "orders", "profile"]
    for feature in features:
        barrel_path = os.path.join(LIB_PATH, f"features/{feature}/{feature}.dart")
        screens_path = os.path.join(LIB_PATH, f"features/{feature}/presentation/screens")
        exports = []
        if os.path.exists(screens_path):
            for f in os.listdir(screens_path):
                if f.endswith(".dart") and not f.startswith("."):
                    exports.append(f"export 'presentation/screens/{f}';")
        with open(barrel_path, 'w', encoding='utf-8') as file:
            file.write(f"// {feature.capitalize()} Feature Exports\n")
            file.write("\n".join(exports) + "\n")
        print(f"   ✅ features/{feature}/{feature}.dart")


def create_app_exports():
    """ملف app.dart يجمع كل الـ exports"""
    app_dart = os.path.join(LIB_PATH, "app.dart")
    content = """// App Exports - Clean Architecture
// تم التوليد أوتوماتيك بواسطة restructure script

// Core
export 'core/constants/app_colors.dart';
export 'core/utils/helper.dart';
export 'core/widgets/custom_nav_bar.dart';
export 'core/widgets/custom_text_input.dart';
export 'core/widgets/custom_search_bar.dart';

// Features
export 'features/auth/auth.dart';
export 'features/home/home.dart';
export 'features/menu/menu.dart';
export 'features/orders/orders.dart';
export 'features/profile/profile.dart';
"""
    with open(app_dart, 'w', encoding='utf-8') as f:
        f.write(content)
    print("   ✅ lib/app.dart")


def print_final_structure():
    """طباعة الـ structure النهائية"""
    print("\n" + "="*50)
    print("📂 Clean Architecture Structure:")
    print("="*50)
    structure = """
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   ├── utils/
│   │   └── helper.dart
│   └── widgets/
│       ├── custom_nav_bar.dart
│       ├── custom_text_input.dart
│       └── custom_search_bar.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/screens/
│   │       ├── login_screen.dart
│   │       ├── signup_screen.dart
│   │       └── ... (باقي شاشات الـ auth)
│   ├── home/
│   ├── menu/
│   ├── orders/
│   └── profile/
"""
    print(structure)


def main():
    print("="*50)
    print("🏗️  Flutter Clean Architecture Restructurer")
    print("    مشروع: senfaya")
    print("="*50)

    # تأكيد قبل البدء
    print(f"\n⚠️  هيتم تعديل: {LIB_PATH}")
    confirm = input("\nتكمل؟ (اكتب yes للمتابعة): ").strip().lower()
    if confirm != "yes":
        print("❌ اتلغى")
        return

    print("\n💾 بنعمل backup أولاً...")
    backup_lib()

    create_folder_structure()
    move_all_files()
    create_barrel_files()
    create_app_exports()
    print_final_structure()

    print("\n✅ خلص! المشروع اتحول لـ Clean Architecture")
    print("💡 نصيحة: افتح VS Code وشوف الـ lib folder دلوقتي")
    print("📁 لو في مشكلة، الـ backup موجود في: lib_backup/")


if __name__ == "__main__":
    main()
