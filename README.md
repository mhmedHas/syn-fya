# 🚛 Synfya - Transport Management System

<p align="center">
  <img src="assets/images/logo.png" alt="Synfya Logo" width="200">
</p>

<p align="center">
  <b>نظام متكامل لإدارة النقل والشحن - تطبيق للسائقين ومنصة ويب للشركات</b>
  <br>
  Complete Transport Management System - Driver Mobile App + Company Web Platform
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.16+-blue.svg">
  <img src="https://img.shields.io/badge/Dart-3.2+-blue.svg">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen.svg">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-green.svg">
  <img src="https://img.shields.io/badge/State%20Management-BLoC-orange.svg">
  <img src="https://img.shields.io/badge/API-Google%20Maps-blue.svg">
</p>

---

## 📱 عن المشروع

**Synfya** هو نظام متكامل لإدارة عمليات النقل والشحن يتكون من:

- 📱 **تطبيق موبايل للسائقين** (Flutter) - استلام الطلبات، عرض المسارات، إتمام التسليم
- 💻 **منصة ويب للشركات** - إدارة الطلبات، تتبع الشحنات، تقارير الأداء

تم تطويره باستخدام **Clean Architecture** و **BLoC** لضمان أعلى جودة وقابلية للتوسع.

---

## 🏗️ الهيكل المعماري
lib/
├── 📁 core/ # المكونات المشتركة
│ ├── 📁 constants/ # الثوابت (API, Routes, Assets)
│ ├── 📁 errors/ # إدارة الأخطاء
│ ├── 📁 theme/ # الثيم والتصميم
│ ├── 📁 utils/ # دوال مساعدة
│ └── 📁 widgets/ # ويدجت عامة
│
└── 📁 features/ # الميزات الرئيسية
├── 📁 auth/ # المصادقة وتسجيل الدخول
│ ├── 📁 data/ # Models, Repositories, DataSources
│ ├── 📁 domain/ # Entities, UseCases
│ └── 📁 presentation/ # Screens, Widgets, BLoC
│
├── 📁 orders/ # إدارة الطلبات
│ ├── 📁 data/
│ ├── 📁 domain/
│ └── 📁 presentation/
│
├── 📁 tracking/ # تتبع الشحنات والمسارات
│ ├── 📁 data/
│ ├── 📁 domain/
│ └── 📁 presentation/
│
└── 📁 profile/ # الملف الشخصي والإعدادات
├── 📁 data/
├── 📁 domain/
└── 📁 presentation/
---

## ✨ الميزات الرئيسية

### 👨‍✈️ تطبيق السائقين (Mobile App)

- ✅ **تسجيل الدخول الآمن** - باستخدام JWT tokens
- ✅ **لوحة تحكم السائق** - عرض الطلبات المتاحة والحالية
- ✅ **قبول/رفض الطلبات** - نظام قبول فوري
- ✅ **توجيهات خرائط** - Integration مع Google Maps API
- ✅ **تحديث الحالة** - استلام، في الطريق، تم التوصيل
- ✅ **إثبات التسليم** - رفع صور وتوقيع العميل
- ✅ **سجل الطلبات** - تاريخ جميع الطلبات السابقة
- ✅ **إشعارات فورية** - Firebase Cloud Messaging
- ✅ **تتبع الإيرادات** - عرض الأرباح والمكافآت

### 💼 منصة الشركات (Web Platform)

- ✅ **لوحة تحكم إدارية** - إدارة السائقين والطلبات
- ✅ **إنشاء طلبات الشحن** - إدخال بيانات المرسل والمستلم
- ✅ **تتبع الشحنات** - Live tracking على الخريطة
- ✅ **توزيع الطلبات** - نظام ذكي لتوزيع الطلبات على السائقين
- ✅ **تقارير الأداء** - إحصائيات ومخططات بيانية
- ✅ **إدارة الأسعار** - تحديد أسعار الشحن حسب المسافة
- ✅ **تقييم السائقين** - نظام تقييم بناءً على الأداء

---

## 🛠️ التقنيات المستخدمة

| التقنية | الغرض |
|---------|-------|
| **Flutter 3.16+** | تطوير التطبيق المتعدد المنصات |
| **Dart 3.2+** | لغة البرمجة |
| **BLoC / Cubit** | إدارة الحالة |
| **Clean Architecture** | فصل المسؤوليات وهيكلة المشروع |
| **GetIt + Injectable** | حقن التبعيات (DI) |
| **Dio + Retrofit** | استدعاءات API |
| **Google Maps API** | الخرائط والمسارات |
| **Firebase** | المصادقة، الإشعارات، التخزين |
| **Hive** | التخزين المحلي (Offline-first) |
| **GoRouter** | إدارة التنقل |
| **Flutter Bloc** | إدارة الحالة المتقدمة |

---

## 📸 لقطات الشاشة

### تطبيق السائقين
<p align="center">
  <img src="assets/screenshots/driver_login.jpg" width="200" alt="Login Screen">
  <img src="assets/screenshots/driver_dashboard.jpg" width="200" alt="Dashboard">
  <img src="assets/screenshots/driver_map.jpg" width="200" alt="Map Tracking">
  <img src="assets/screenshots/driver_orders.jpg" width="200" alt="Orders List">
</p>

### منصة الويب
<p align="center">
  <img src="assets/screenshots/web_dashboard.jpg" width="400" alt="Web Dashboard">
  <img src="assets/screenshots/web_orders.jpg" width="400" alt="Orders Management">
</p>

> *سيتم إضافة الصور قريبًا*

---

## 🚀 كيفية التشغيل

### المتطلبات الأساسية
```bash
Flutter SDK: 3.16.0 أو أحدث
Dart SDK: 3.2.0 أو أحدث
Android Studio / VS Code
Git