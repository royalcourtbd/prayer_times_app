# Colors for output
$RED = "`e[0;31m"
$GREEN = "`e[0;32m"
$YELLOW = "`e[1;33m"
$NC = "`e[0m" # No Color
$MAGENTA = "`e[0;35m" # Added for spinner
$CHECKMARK = "`e[32m✓`e[0m" # Added for success checkmark
$CROSS = "`e[31m𐄂`e[0m" # Added for failure cross

# Function: show_loading
# Description: Displays a loading spinner with a custom message while a process is running
# Parameters:
#   $1: Description message to display
#   $2: Process ID to monitor
function Show-Loading {
    param (
        [string]$description,
        [int]$process_id
    )

    $spinner_index = 0
    $braille_spinner_list = '⡿⣟⣯⣷⣾⣽⣻⢿'

    Write-Host -NoNewline $description

    # Continue spinning while the process is running
    while (Get-Process -Id $process_id -ErrorAction SilentlyContinue) {
        Write-Host -NoNewline "`b$MAGENTA$($braille_spinner_list[$spinner_index])$NC"
        $spinner_index = ($spinner_index + 1) % $braille_spinner_list.Length
        Start-Sleep -Milliseconds 25
    }

    # Display success or failure icon based on the process exit status
    $process = Get-Process -Id $process_id -ErrorAction SilentlyContinue
    if ($process.ExitCode -eq 0) {
        Write-Host -NoNewline "`b$CHECKMARK "
    } else {
        Write-Host -NoNewline "`b$CROSS "
    }
}

# Main script logic
switch ($args[0]) {
    "apk" {
        Write-Host "$YELLOW Building APK (Full Process)...$NC`n"

        $process = Start-Process -FilePath "flutter" -ArgumentList "clean" -NoNewWindow -PassThru
        Show-Loading "Cleaning project...                                   " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "pub get" -NoNewWindow -PassThru
        Show-Loading "Getting dependencies...                              " $process.Id

        $process = Start-Process -FilePath "dart" -ArgumentList "run build_runner build --delete-conflicting-outputs" -NoNewWindow -PassThru
        Show-Loading "Generating build files...                            " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "build apk --release --obfuscate --target-platform android-arm64 --split-debug-info=./" -NoNewWindow -PassThru
        Show-Loading "Building APK...                                      " $process.Id

        Write-Host "`n$GREEN✓ APK built successfully!$NC"

        # Open the APK directory
        Start-Process "explorer.exe" "build\app\outputs\flutter-apk"
    }

    "aab" {
        Write-Host "$YELLOW Building AAB...$NC`n"

        $process = Start-Process -FilePath "flutter" -ArgumentList "clean" -NoNewWindow -PassThru
        Show-Loading "Cleaning project...                                   " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "pub get" -NoNewWindow -PassThru
        Show-Loading "Getting dependencies...                              " $process.Id

        $process = Start-Process -FilePath "dart" -ArgumentList "run build_runner build --delete-conflicting-outputs" -NoNewWindow -PassThru
        Show-Loading "Generating build files...                            " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "build appbundle --release --obfuscate --split-debug-info=./" -NoNewWindow -PassThru
        Show-Loading "Building AAB...                                      " $process.Id

        Write-Host "`n$GREEN✓ AAB built successfully!$NC"

        # Open the directory containing the AAB
        Start-Process "explorer.exe" "build\app\outputs\bundle\release"
    }

    "lang" {
        # Run flutter gen-l10n to generate localization files
        $process = Start-Process -FilePath "flutter" -ArgumentList "gen-l10n" -NoNewWindow -PassThru
        Show-Loading "Generating localizations                              " $process.Id

        Write-Host "`n$CHECKMARK  Localizations generated successfully."
    }

    "db" {
        Write-Host "$YELLOW Executing build_runner...$NC  `n"
        # Run build_runner to generate Dart code
        $process = Start-Process -FilePath "dart" -ArgumentList "run build_runner build --delete-conflicting-outputs" -NoNewWindow -PassThru
        Show-Loading "Running build_runner     " $process.Id
    }

    "setup" {
        Write-Host "$YELLOW Performing full setup...$NC  `n"

        $process = Start-Process -FilePath "flutter" -ArgumentList "clean" -NoNewWindow -PassThru
        Show-Loading "Cleaning project...                                  " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "pub upgrade" -NoNewWindow -PassThru
        Show-Loading "Upgrading dependencies...                            " $process.Id

        $process = Start-Process -FilePath "dart" -ArgumentList "run build_runner build --delete-conflicting-outputs" -NoNewWindow -PassThru
        Show-Loading "Running build_runner...                              " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "gen-l10n" -NoNewWindow -PassThru
        Show-Loading "Generating localizations...                          " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "pub upgrade" -NoNewWindow -PassThru
        Show-Loading "Refreshing dependencies...                           " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "analyze" -NoNewWindow -PassThru
        Show-Loading "Analyzing code...                                    " $process.Id

        $process = Start-Process -FilePath "dart" -ArgumentList "format ." -NoNewWindow -PassThru
        Show-Loading "Formatting code...                                   " $process.Id

        Write-Host "`n $GREEN✓  Full setup completed successfully.  $NC"
    }

    "cache-repair" {
        Write-Host "$YELLOW Repairing pub cache...$NC`n"

        $process = Start-Process -FilePath "flutter" -ArgumentList "pub cache repair" -NoNewWindow -PassThru
        Show-Loading "Repairing pub cache...                               " $process.Id

        Write-Host "`n $GREEN✓  Pub cache repaired successfully.  $NC"
    }

    "cleanup" {
        Write-Host "$YELLOW Cleaning up project...$NC`n"

        $process = Start-Process -FilePath "flutter" -ArgumentList "clean" -NoNewWindow -PassThru
        Show-Loading "Cleaning project...                                   " $process.Id

        $process = Start-Process -FilePath "flutter" -ArgumentList "pub get" -NoNewWindow -PassThru
        Show-Loading "Getting dependencies...                              " $process.Id

        Write-Host "`n$GREEN✓ Project cleaned successfully!$NC"
    }

    default {
        Write-Host "$YELLOW Usage: $PSCommandPath [command]$NC"
        Write-Host "`nAvailable commands:"
        Write-Host "  apk          Build release APK (Full Process)"
        Write-Host "  aab          Build release AAB"
        Write-Host "  lang         Generate localization files"
        Write-Host "  db           Run build_runner"
        Write-Host "  setup        Perform full project setup"
        Write-Host "  cache-repair Repair pub cache"
        Write-Host "  cleanup      Clean project and get dependencies"
        exit 1
    }
}

<#
আউটপুট লুকানো এবং দেখার জন্য কমান্ড কীভাবে পরিবর্তন করবেন

1. আউটপুট লুকানোর জন্য:
   - Start-Process এর সাথে -RedirectStandardOutput "NUL" -RedirectStandardError "NUL" যোগ করতে হবে।
   - এটি করলে কমান্ডের আউটপুট টার্মিনালে দেখাবে না, শুধু লোডিং স্পিনার দেখাবে।
   - উদাহরণ:
     $process = Start-Process -FilePath "flutter" -ArgumentList "clean" -NoNewWindow -PassThru -RedirectStandardOutput "NUL" -RedirectStandardError "NUL"
     Show-Loading "Cleaning project...                                   " $process.Id

2. আউটপুট দেখার জন্য:
   - -RedirectStandardOutput "NUL" -RedirectStandardError "NUL" সরিয়ে ফেলতে হবে।
   - এটি করলে কমান্ডের পুরো আউটপুট টার্মিনালে দেখাবে, যেমন কী হচ্ছে, কোন ফাইল তৈরি হচ্ছে ইত্যাদি।
   - উদাহরণ:
     $process = Start-Process -FilePath "flutter" -ArgumentList "clean" -NoNewWindow -PassThru
     Show-Loading "Cleaning project...                                   " $process.Id

কীভাবে চালাবেন:
- ফাইলটি সেভ করুন (যেমন, build.ps1), তারপর:
  PowerShell খুলুন এবং নিচের কমান্ড চালান:
  .\build.ps1 setup
#>