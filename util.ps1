function Show-Loading {
    param (
        [string]$description,
        [int]$processId
    )
    $spinnerIndex = 0
    $brailleSpinnerList = '⡿⣟⣯⣷⣾⣽⣻⢿'
    Write-Host -NoNewline $description
    while (Get-Process -Id $processId -ErrorAction SilentlyContinue) {
        Write-Host -NoNewline "`b$([char]27)[35m$($brailleSpinnerList[$spinnerIndex])$([char]27)[0m"
        $spinnerIndex = ($spinnerIndex + 1) % $brailleSpinnerList.Length
        Start-Sleep -Milliseconds 25
    }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`b$([char]27)[32m✓$([char]27)[0m "
    }
    else {
        Write-Host "`b$([char]27)[31m𐄂$([char]27)[0m "
    }
}

switch ($args[0]) {
    "build" {
        Write-Host "Building APK...`n"
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "clean" -PassThru | ForEach-Object {
            Show-Loading "Cleaning project...                                    " $_.Id
        }
       
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "get" -PassThru | ForEach-Object {
            Show-Loading "Getting dependencies...                                " $_.Id
        }

        start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "run", "build_runner", "build", "--delete-conflicting-outputs" -PassThru | ForEach-Object {
            Show-Loading "Generating build files...                                    " $_.Id
        }

       
    
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "build", "apk", "--release", "--obfuscate", "--target-platform", "android-arm64", "--split-debug-info=./" -PassThru | ForEach-Object {
            Show-Loading "Building APK...                                        " $_.Id
        }
        Start-Process -FilePath "explorer.exe" -ArgumentList "build\app\outputs\flutter-apk\"
    }

    
    "build-aab" {
        Write-Host "Building AAB...`n"
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "clean" -PassThru | ForEach-Object {
            Show-Loading "Cleaning project...                                      " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "get" -PassThru | ForEach-Object {
            Show-Loading "Getting dependencies...                                  " $_.Id
        }
        start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "run", "build_runner", "build", "--delete-conflicting-outputs" -PassThru | ForEach-Object {
            Show-Loading "Generating build files...                                    " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "build", "appbundle", "--release" -PassThru | ForEach-Object {
            Show-Loading "Building AAB...                                          " $_.Id
        }
        Start-Process -FilePath "explorer.exe" -ArgumentList "build\app\outputs\bundle\release\"
    }
    "cleanup" {
        Write-Host "Cleaning up project...     `n"
        Start-Process -NoNewWindow -FilePath "dart" -ArgumentList "fix", "--apply" -PassThru | ForEach-Object {
            Show-Loading "Fixing code                                           " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "dart" -ArgumentList "format", "--fix", "." -PassThru | ForEach-Object {
            Show-Loading "Following dart guidelines                             " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "run", "import_path_converter:main" -PassThru | ForEach-Object {
            Show-Loading "Converting import paths from relative to absolute     " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "upgrade", "--major-versions" -PassThru | ForEach-Object {
            Show-Loading "Upgrading the dependencies                            " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "upgrade" -PassThru | ForEach-Object {
            Show-Loading "Upgrading the dependencies                            " $_.Id
        }
        Write-Host "`n$([char]27)[32m✓  All cleaning tasks finished.  $([char]27)[0m"
    }
    "setup" {
        Write-Host "Setting up project...  `n"
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "get" -PassThru | ForEach-Object {
            Show-Loading "Getting dependencies     " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "run", "build_runner", "build", "--delete-conflicting-outputs" -PassThru | ForEach-Object {
            Show-Loading "Generating build files     " $_.Id
        }
        Start-Process -NoNewWindow -FilePath "flutter" -ArgumentList "pub", "run", "flutter_native_splash:create" -PassThru | ForEach-Object {
            Show-Loading "Generating splash screen     " $_.Id
        }
    }
    "unused" {
        Write-Host "Analyzing project for unused code...`n"
        flutter analyze
        Write-Host "`nShowing suggested fixes...`n"
        dart fix --dry-run
    }
    default {
        Write-Host "Invalid argument: $($args[0])"
        Write-Host "Usage: .\script.ps1 [build|cleanup|setup|unused]"
        exit 1
    }


    <# 
    এই স্ক্রিপ্টটি ব্যবহার করার জন্য:

    এটিকে একটি ফাইলে সেভ করুন, যেমন util.ps1।
    PowerShell খুলুন।
    স্ক্রিপ্টটি যেখানে সেভ করেছেন সেই ডিরেক্টরিতে নেভিগেট করুন।
    স্ক্রিপ্টটি চালানোর জন্য নিম্নলিখিত কমান্ড ব্যবহার করুন:
    .\util.ps1 [build|cleanup|setup|unused]

    যেমন: .\util.ps1 build

    
    #>
}