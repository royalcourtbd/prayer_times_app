#!/usr/bin/env python3
import os
import sys
import time
import signal
import platform
import subprocess
import glob

# Colors for output
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'  # No Color
MAGENTA = '\033[0;35m'  # Added for spinner
CHECKMARK = '\033[32m✓\033[0m'  # Added for success checkmark
CROSS = '\033[31m𐄂\033[0m'  # Added for failure cross

def show_loading(description, process):
    """
    Displays a loading spinner with a custom message while a process is running
    Parameters:
        description: Description message to display
        process: Process object to monitor
    """
    spinner_index = 0
    braille_spinner_list = '⡿⣟⣯⣷⣾⣽⣻⢿'
    
    print(description, end='', flush=True)
    
    # Continue spinning while the process is running
    while process.poll() is None:
        print(f"\b{MAGENTA}{braille_spinner_list[spinner_index]}{NC}", end='', flush=True)
        spinner_index = (spinner_index + 1) % len(braille_spinner_list)
        time.sleep(0.025)
    
    # Display success or failure icon based on the process exit status
    if process.returncode == 0:
        print(f"\b{CHECKMARK} ", flush=True)
        return True
    else:
        print(f"\b{CROSS} ", flush=True)
        stdout, stderr = process.communicate()
        if stderr:
            print(f"\n{RED}Error Output:\n{stderr.decode()}{NC}")
        return False

def display_apk_size():
    """Function to display APK size"""
    apk_files = glob.glob("build/app/outputs/flutter-apk/*.apk")
    if apk_files:
        for apk_path in apk_files:
            size_bytes = os.path.getsize(apk_path)
            size_mb = round(size_bytes / 1048576, 2)
            print(f"{BLUE}APK: {os.path.basename(apk_path)} | Size: {size_mb} MB{NC}")
    else:
        print(f"{RED}APK file not found in build/app/outputs/flutter-apk/{NC}")

def run_flutter_command(cmd_list, description):
    process = subprocess.Popen(
        cmd_list,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    return show_loading(description, process)

def open_directory(directory_path):
    """Opens a directory based on the operating system"""
    try:
        if platform.system() == "Darwin":  # macOS
            subprocess.run(["open", directory_path])
        elif platform.system() == "Linux":
            subprocess.run(["xdg-open", directory_path])
        elif platform.system() == "Windows":
            subprocess.run(["start", directory_path], shell=True)
        else:
            print(f"Cannot open directory automatically. Please check: {directory_path}")
    except Exception as e:
        print(f"Error opening directory: {e}")
        print(f"Please check: {directory_path}")

def build_apk():
    """Build APK (Full Process)"""
    print(f"{YELLOW}Building APK (Full Process)...{NC}\n")
    
    # Clean the project
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    
    # Get dependencies
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")
    
    # Generate build files
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Generating build files...                            ")
    
    # Build APK
    run_flutter_command(["flutter", "build", "apk", "--release", "--obfuscate", "--target-platform", "android-arm64", "--split-debug-info=./"], "Building APK...                                      ")
    
    print(f"\n{GREEN}✓ APK built successfully!{NC}")
    
    # Display APK size
    display_apk_size()
    
    # Open the APK directory
    open_directory("build/app/outputs/flutter-apk/")

def build_aab():
    """Build AAB"""
    print(f"{YELLOW}Building AAB...{NC}\n")
    
    # Clean the project
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    
    # Get dependencies
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")
    
    # Generate build files
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Generating build files...                            ")
    
    # Build AAB
    run_flutter_command(["flutter", "build", "appbundle", "--release", "--obfuscate", "--split-debug-info=./"], "Building AAB...                                      ")
    
    print(f"\n{GREEN}✓ AAB built successfully!{NC}")
    
    # Open the AAB directory
    open_directory("build/app/outputs/bundle/release/")

def generate_lang():
    """Generate localization files"""
    # Run flutter gen-l10n to generate localization files
    run_flutter_command(["flutter", "gen-l10n"], "Generating localizations                              ")
    print(f"\n{CHECKMARK}  Localizations generated successfully.")

def run_build_runner():
    """Run build_runner to generate Dart code"""
    print(f"{YELLOW}Executing build_runner...{NC}  \n")
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Running build_runner     ")

def full_setup():
    """Perform full project setup"""
    print(f"{YELLOW}Performing full setup...{NC}  \n")
    
    # Clean the project
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                  ")
    
    # Upgrade dependencies
    run_flutter_command(["flutter", "pub", "upgrade"], "Upgrading dependencies...                            ")
    
    # Run build_runner
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Running build_runner...                              ")
    
    # Generate localizations
    run_flutter_command(["flutter", "gen-l10n"], "Generating localizations...                          ")
    
    # Refresh dependencies
    run_flutter_command(["flutter", "pub", "upgrade"], "Refreshing dependencies...                           ")
    
    # Analyze code
    run_flutter_command(["flutter", "analyze"], "Analyzing code...                                    ")
    
    # Format code
    run_flutter_command(["dart", "format", "."], "Formatting code...                                   ")
    
    print(f"\n {GREEN}✓  Full setup completed successfully.  {NC}")

def repair_cache():
    """Repair pub cache"""
    print(f"{YELLOW}Repairing pub cache...{NC}\n")
    run_flutter_command(["flutter", "pub", "cache", "repair"], "Repairing pub cache...                               ")
    print(f"\n {GREEN}✓  Pub cache repaired successfully.  {NC}")

def cleanup_project():
    """Clean up project"""
    print(f"{YELLOW}Cleaning up project...{NC}\n")
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")
    print(f"\n{GREEN}✓ Project cleaned successfully!{NC}")

def release_run():
    """Build & Install Release APK"""
    print(f"{YELLOW}Building & Installing Release APK...{NC}\n")
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")
    run_flutter_command(["flutter", "gen-l10n"], "Generating localizations...                          ")
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Generating build files...                            ")
    run_flutter_command(["flutter", "build", "apk", "--release", "--obfuscate", "--target-platform", "android-arm64", "--split-debug-info=./"], "Building APK...                                      ")
    display_apk_size()
    install_result = install_apk()
    if install_result:
        print(f"\n{GREEN}✓ APK built and installed successfully!{NC}")
    else:
        print(f"\n{RED}✗ APK built but install failed!{NC}")

def install_apk():
    apk_files = glob.glob("build/app/outputs/flutter-apk/*.apk")
    if not apk_files:
        print(f"{RED}No APK found to install!{NC}")
        return False
    # Try to install arm64-v8a APK first
    for apk_path in apk_files:
        if "arm64-v8a" in apk_path:
            print(f"{YELLOW}Installing {apk_path}...{NC}")
            return run_flutter_command(["adb", "install", "-r", apk_path], "Installing on device...                              ")
    # If not found, install the first apk
    print(f"{YELLOW}Installing {apk_files[0]}...{NC}")
    return run_flutter_command(["adb", "install", "-r", apk_files[0]], "Installing on device...                              ")

def update_pods():
    """Update iOS pods"""
    print(f"{YELLOW}Updating iOS pods...{NC}\n")
    
    # Navigate to iOS directory
    current_dir = os.getcwd()
    os.chdir("ios")
    
    # Delete Podfile.lock
    try:
        os.remove("Podfile.lock")
        # Use a dummy process for the loading animation
        run_flutter_command(["sleep", "0.1"], "Removing Podfile.lock                                 ")
    except FileNotFoundError:
        pass
    
    # Update pod repo
    run_flutter_command(["pod", "repo", "update"], "Updating pod repository                               ")
    
    # Install pods
    run_flutter_command(["pod", "install"], "Installing pods                                       ")
    
    # Return to root directory
    os.chdir(current_dir)
    
    print(f"\n{GREEN}✓ iOS pods updated successfully!{NC}")

def create_page(page_name):
    """Create page structure"""
    print(f"{YELLOW}Creating page...{NC}\n")
    
    if not page_name:
        print(f"{RED}Error: Page name is required.{NC}")
        print(f"Usage: {sys.argv[0]} page <page_name>")
        sys.exit(1)
    
    # Run the create_page with the page name
    try:
        subprocess.run(["python3", "create_page.py", "page", page_name], check=True)
    except subprocess.CalledProcessError:
        print(f"{RED}Error: Failed to run page generator.{NC}")
        sys.exit(1)
    except FileNotFoundError:
        print(f"{RED}Error: create_page.py not found.{NC}")
        print("Make sure create_page.py exists in the current directory.")
        sys.exit(1)

def show_usage():
    """Show usage information"""
    print(f"{YELLOW}Usage: {sys.argv[0]} [command]{NC}")
    print("\nAvailable commands:")
    print("  apk          Build release APK (Full Process)")
    print("  aab          Build release AAB")
    print("  lang         Generate localization files")
    print("  db           Run build_runner")
    print("  setup        Perform full project setup")
    print("  cache-repair Repair pub cache")
    print("  cleanup      Clean project and get dependencies")
    print("  release-run  Build & install release APK on connected device")
    print("  pod          Update iOS pods")
    print("  page         Create page structure (usage: {sys.argv[0]} page <page_name>)")
    sys.exit(1)

def main():
    """Main function"""
    # Create required directories if they don't exist
    os.makedirs("build/app/outputs/flutter-apk", exist_ok=True)
    os.makedirs("build/app/outputs/bundle/release", exist_ok=True)
    
    if len(sys.argv) < 2:
        show_usage()
    
    command = sys.argv[1].lower()
    
    if command == "apk":
        build_apk()
    elif command == "aab":
        build_aab()
    elif command == "lang":
        generate_lang()
    elif command == "db":
        run_build_runner()
    elif command == "setup":
        full_setup()
    elif command == "cache-repair":
        repair_cache()
    elif command == "cleanup":
        cleanup_project()
    elif command == "release-run":
        release_run()
    elif command == "pod":
        update_pods()
    elif command == "page":
        if len(sys.argv) < 3:
            print(f"{RED}Error: Page name is required.{NC}")
            print(f"Usage: {sys.argv[0]} page <page_name>")
            sys.exit(1)
        create_page(sys.argv[2])
    else:
        show_usage()

if __name__ == "__main__":
    # Handle Ctrl+C gracefully
    def signal_handler(sig, frame):
        print("\nProcess interrupted. Exiting...")
        sys.exit(0)
    
    signal.signal(signal.SIGINT, signal_handler)
    main()
