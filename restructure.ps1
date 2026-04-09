# Flutter Clean Architecture Restructurer
# Usage: .\restructure.ps1

$ProjectPath = "E:\flutter project\senfaya"
$LibPath = "$ProjectPath\lib"
$BackupPath = "$ProjectPath\lib_backup"

Write-Host "================================================"
Write-Host "  Flutter Clean Architecture Restructurer"
Write-Host "  Project: senfaya"
Write-Host "================================================"

$confirm = Read-Host "This will reorganize your lib folder. Continue? (type yes)"
if ($confirm -ne "yes") { Write-Host "Cancelled."; exit }

# Backup
Write-Host "Creating backup..."
if (Test-Path $BackupPath) { Remove-Item $BackupPath -Recurse -Force }
Copy-Item $LibPath $BackupPath -Recurse
Write-Host "  Backup created at lib_backup/"

# Create Folders
Write-Host "Creating folder structure..."

$folders = @(
    "core\constants", "core\errors", "core\utils", "core\widgets", "core\theme",
    "features\auth\data\datasources", "features\auth\data\models", "features\auth\data\repositories",
    "features\auth\domain\entities", "features\auth\domain\repositories", "features\auth\domain\usecases",
    "features\auth\presentation\screens", "features\auth\presentation\widgets",
    "features\home\data\datasources", "features\home\data\models", "features\home\data\repositories",
    "features\home\domain\entities", "features\home\domain\repositories", "features\home\domain\usecases",
    "features\home\presentation\screens", "features\home\presentation\widgets",
    "features\menu\data\datasources", "features\menu\data\models", "features\menu\data\repositories",
    "features\menu\domain\entities", "features\menu\domain\repositories", "features\menu\domain\usecases",
    "features\menu\presentation\screens", "features\menu\presentation\widgets",
    "features\orders\data\datasources", "features\orders\data\models", "features\orders\data\repositories",
    "features\orders\domain\entities", "features\orders\domain\repositories", "features\orders\domain\usecases",
    "features\orders\presentation\screens", "features\orders\presentation\widgets",
    "features\profile\data\datasources", "features\profile\data\models", "features\profile\data\repositories",
    "features\profile\domain\entities", "features\profile\domain\repositories", "features\profile\domain\usecases",
    "features\profile\presentation\screens", "features\profile\presentation\widgets"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path "$LibPath\$folder" -Force | Out-Null
}
Write-Host "  Folders created!"

function Move-FlutterFile($srcFolder, $srcName, $destRelative) {
    $src = "$LibPath\$srcFolder\$srcName"
    $dest = "$LibPath\$destRelative"
    if (Test-Path $src) {
        $destDir = Split-Path $dest -Parent
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        Copy-Item $src $dest -Force
        Write-Host "  OK: $srcFolder\$srcName -> $destRelative"
    } else {
        Write-Host "  SKIP: $srcFolder\$srcName (not found)"
    }
}

Write-Host "Moving auth screens..."
Move-FlutterFile "screens" "loginScreen.dart"          "features\auth\presentation\screens\login_screen.dart"
Move-FlutterFile "screens" "signUpScreen.dart"         "features\auth\presentation\screens\signup_screen.dart"
Move-FlutterFile "screens" "forgetPwScreen.dart"       "features\auth\presentation\screens\forgot_password_screen.dart"
Move-FlutterFile "screens" "newPwScreen.dart"          "features\auth\presentation\screens\new_password_screen.dart"
Move-FlutterFile "screens" "sentOTPScreen.dart"        "features\auth\presentation\screens\otp_screen.dart"
Move-FlutterFile "screens" "introScreen.dart"          "features\auth\presentation\screens\intro_screen.dart"
Move-FlutterFile "screens" "spashScreen.dart"          "features\auth\presentation\screens\splash_screen.dart"
Move-FlutterFile "screens" "landingScreen.dart"        "features\auth\presentation\screens\landing_screen.dart"

Write-Host "Moving home screens..."
Move-FlutterFile "screens" "homeScreen.dart"           "features\home\presentation\screens\home_screen.dart"

Write-Host "Moving menu screens..."
Move-FlutterFile "screens" "menuScreen.dart"           "features\menu\presentation\screens\menu_screen.dart"
Move-FlutterFile "screens" "dessertScreen.dart"        "features\menu\presentation\screens\dessert_screen.dart"
Move-FlutterFile "screens" "individualItem.dart"       "features\menu\presentation\screens\item_details_screen.dart"
Move-FlutterFile "screens" "offerScreen.dart"          "features\menu\presentation\screens\offers_screen.dart"

Write-Host "Moving orders screens..."
Move-FlutterFile "screens" "checkoutScreen.dart"       "features\orders\presentation\screens\checkout_screen.dart"
Move-FlutterFile "screens" "paymentScreen.dart"        "features\orders\presentation\screens\payment_screen.dart"
Move-FlutterFile "screens" "myOrderScreen.dart"        "features\orders\presentation\screens\my_orders_screen.dart"
Move-FlutterFile "screens" "changeAddressScreen.dart"  "features\orders\presentation\screens\change_address_screen.dart"

Write-Host "Moving profile screens..."
Move-FlutterFile "screens" "profileScreen.dart"        "features\profile\presentation\screens\profile_screen.dart"
Move-FlutterFile "screens" "aboutScreen.dart"          "features\profile\presentation\screens\about_screen.dart"
Move-FlutterFile "screens" "inboxScreen.dart"          "features\profile\presentation\screens\inbox_screen.dart"
Move-FlutterFile "screens" "notificationScreen.dart"   "features\profile\presentation\screens\notifications_screen.dart"
Move-FlutterFile "screens" "moreScreen.dart"           "features\profile\presentation\screens\more_screen.dart"

Write-Host "Moving widgets..."
Move-FlutterFile "widgets" "customNavBar.dart"         "core\widgets\custom_nav_bar.dart"
Move-FlutterFile "widgets" "customTextInput.dart"      "core\widgets\custom_text_input.dart"
Move-FlutterFile "widgets" "searchBar.dart"            "core\widgets\custom_search_bar.dart"

Write-Host "Moving constants..."
Move-FlutterFile "const" "colors.dart"                 "core\constants\app_colors.dart"

Write-Host "Moving utils..."
Move-FlutterFile "utils" "helper.dart"                 "core\utils\helper.dart"

Write-Host "Creating barrel files..."
$features = @("auth", "home", "menu", "orders", "profile")
foreach ($feature in $features) {
    $barrelPath = "$LibPath\features\$feature\$feature.dart"
    $screensPath = "$LibPath\features\$feature\presentation\screens"
    $exports = "// $feature Feature Exports`r`n"
    if (Test-Path $screensPath) {
        Get-ChildItem $screensPath -Filter "*.dart" | ForEach-Object {
            $exports += "export 'presentation/screens/$($_.Name)';`r`n"
        }
    }
    [System.IO.File]::WriteAllText($barrelPath, $exports, [System.Text.Encoding]::UTF8)
    Write-Host "  Created: features\$feature\$feature.dart"
}

$appDart = "// App Exports - Clean Architecture`r`n`r`n"
$appDart += "export 'core/constants/app_colors.dart';`r`n"
$appDart += "export 'core/utils/helper.dart';`r`n"
$appDart += "export 'core/widgets/custom_nav_bar.dart';`r`n"
$appDart += "export 'core/widgets/custom_text_input.dart';`r`n"
$appDart += "export 'core/widgets/custom_search_bar.dart';`r`n`r`n"
$appDart += "export 'features/auth/auth.dart';`r`n"
$appDart += "export 'features/home/home.dart';`r`n"
$appDart += "export 'features/menu/menu.dart';`r`n"
$appDart += "export 'features/orders/orders.dart';`r`n"
$appDart += "export 'features/profile/profile.dart';`r`n"
[System.IO.File]::WriteAllText("$LibPath\app.dart", $appDart, [System.Text.Encoding]::UTF8)
Write-Host "  Created: lib\app.dart"

Write-Host ""
Write-Host "================================================"
Write-Host "DONE! Project restructured to Clean Architecture"
Write-Host ""
Write-Host "lib/"
Write-Host "|- main.dart"
Write-Host "|- app.dart"
Write-Host "|- core/  (constants, utils, widgets)"
Write-Host "|- features/"
Write-Host "   |- auth/  home/  menu/  orders/  profile/"
Write-Host ""
Write-Host "Backup saved at: lib_backup/"
Write-Host "Open VS Code and check your lib folder!"
Write-Host "================================================"
