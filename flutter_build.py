#!/usr/bin/env python3
import os
import sys
import time
import signal
import platform
import subprocess
import glob
import re  # Added for git tag functionality
from functools import wraps

# Colors for output
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'
MAGENTA = '\033[0;35m'  
CHECKMARK = '\033[32m✓\033[0m' 
CROSS = '\033[31m𐄂\033[0m'

def timer_decorator(func):
    """
    Decorator to automatically add timer functionality to any function
    """
    @wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        
        # Execute the original function
        result = func(*args, **kwargs)
        
        end_time = time.time()
        total_seconds = end_time - start_time
        minutes, seconds = divmod(total_seconds, 60)
        
        print(f"\n{BLUE}======================================================{NC}")
        print(f"{BLUE}Total time taken: {int(minutes)} minute(s) and {seconds:.2f} seconds.{NC}")
        print(f"{BLUE}======================================================{NC}")
        
        return result
    return wrapper

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
    stdout, stderr = process.communicate()
    # Display success or failure icon based on the process exit status
    if process.returncode == 0:
        print(f"\b{CHECKMARK} ", flush=True)
        # Nicher ei stdout statement ta comment out korle r command er out put dekha jabe na.
        # if stdout:
        #     print(f"\n{GREEN}Output:\n{stdout.decode()}{NC}")
        return True
    else:
        print(f"\b{CROSS} ", flush=True)
        # Nicher ei stdout statement ta comment out korle r command er out put dekha jabe na.
        if stdout:
            print(f"\n{GREEN}Output:\n{stdout.decode()}{NC}")
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
    """
    Runs a flutter/dart command with a loading spinner.
    Parameters:
        cmd_list: List of command arguments
        description: Description to show with spinner
    """
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

@timer_decorator
def build_apk():
    """Build APK (Full Process)"""
    print(f"{YELLOW}Building APK (Full Process)...{NC}\n")

    # Clean the project
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    
    # Get dependencies
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")
    
    # Generate build files
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Generating build files...                            ")
    
    # Build the APK
    run_flutter_command([
        "flutter", "build", "apk", "--release", "--obfuscate", "--target-platform", "android-arm64", "--split-debug-info=./"
    ], "Building APK...                                      ")
    print(f"\n{GREEN}✓ APK built successfully!{NC}")
    
    # Display APK size
    display_apk_size()
    
    # Open the directory containing the APK
    open_directory("build/app/outputs/flutter-apk/")

@timer_decorator
def build_apk_split_per_abi():
    """Build APK with --split-per-abi"""
    print(f"{YELLOW}Building APK (split-per-abi)...{NC}\n")
    # Clean the project
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    # Get dependencies
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")
    # Generate build files
    run_flutter_command(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], "Generating build files...                            ")
    # Build APK with split-per-abi
    run_flutter_command([
        "flutter", "build", "apk", "--release", "--split-per-abi", "--obfuscate", "--split-debug-info=./"
    ], "Building APK (split-per-abi)...                      ")
    print(f"\n{GREEN}✓ APK (split-per-abi) built successfully!{NC}")
    # Display APK size
    display_apk_size()
    # Open the directory containing the APK
    open_directory("build/app/outputs/flutter-apk/")

@timer_decorator
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
    # Open the directory containing the AAB
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

@timer_decorator
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

@timer_decorator
def cleanup_project():
    """Clean up project"""
    print(f"{YELLOW}Cleaning up project...{NC}\n")
    run_flutter_command(["flutter", "clean"], "Cleaning project...                                   ")
    # Get dependencies
    run_flutter_command(["flutter", "pub", "get"], "Getting dependencies...                              ")

    #fix code Issues
    run_flutter_command(["dart", "fix", "--apply"], "Fixing code issues...                                   ")

    # Format code
    run_flutter_command(["dart", "format", "."], "Following dart guidelines...                                   ")

    #Upgrade with major version
    run_flutter_command(["flutter", "pub", "upgrade", "--major-versions"], "Upgrading major versions...                            ")
    print(f"\n{GREEN}✓ Project cleaned successfully!{NC}")

@timer_decorator
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
    """
    Installs the built APK on a connected Android device using adb.
    Tries to install arm64-v8a APK first if available.
    Handles signature mismatch by uninstalling existing app first.
    """
    apk_files = glob.glob("build/app/outputs/flutter-apk/*.apk")
    if not apk_files:
        print(f"{RED}No APK found to install!{NC}")
        return False
    
    # Try to install arm64-v8a APK first, otherwise use the first apk
    target_apk = None
    for apk_path in apk_files:
        if "arm64-v8a" in apk_path:
            target_apk = apk_path
            break
    if not target_apk:
        target_apk = apk_files[0]
    
    print(f"{YELLOW}Installing {target_apk}...{NC}")
    
    # First try normal install
    success = run_flutter_command(["adb", "install", "-r", target_apk], "Installing on device...                              ")
    
    if not success:
        print(f"{YELLOW}Installation failed, trying to uninstall existing app first...{NC}")
        # Try to uninstall existing app first
        run_flutter_command(["adb", "uninstall", "com.royalcourtbd.dhaka_bus"], "Uninstalling existing app...                        ")
        # Then try to install again
        success = run_flutter_command(["adb", "install", target_apk], "Reinstalling on device...                           ")
    
    return success

@timer_decorator
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

# ============================================================================
# GIT TAG FUNCTIONS
# ============================================================================

def get_version_from_pubspec():
    """Get the version from pubspec.yaml using regex"""
    if os.path.isfile("pubspec.yaml"):
        with open("pubspec.yaml", 'r') as file:
            try:
                content = file.read()
                # Use regex to find the version field in pubspec.yaml
                version_match = re.search(r'^version:\s*(.+)$', content, re.MULTILINE)
                if version_match:
                    version = version_match.group(1).strip()
                    # Remove quotes if present and split by + to get only version number
                    version = version.strip('"\'').split('+')[0]
                    return version
                else:
                    print(f"{RED}Error: Could not find 'version' field in pubspec.yaml.{NC}")
                    return None
            except Exception as e:
                print(f"{RED}Error: Could not read pubspec.yaml: {e}{NC}")
                return None
    else:
        print(f"{RED}Error: pubspec.yaml not found in the current directory.{NC}")
        print(f"Please run this command from the root of a Flutter project.")
        return None

def create_and_push_tag():
    """Create git tag from pubspec version and push to remote"""
    print(f"{YELLOW}Creating and pushing git tag...{NC}\n")
    
    # Get version from pubspec.yaml
    version = get_version_from_pubspec()
    if not version:
        return False
    
    tag_name = f"v{version}"
    
    print(f"{BLUE}Version found: {version}{NC}")
    print(f"{BLUE}Tag name: {tag_name}{NC}\n")
    
    # Check if tag already exists
    try:
        result = subprocess.run(["git", "tag", "-l", tag_name], 
                              capture_output=True, text=True)
        if result.stdout.strip():
            print(f"{YELLOW}Warning: Tag {tag_name} already exists locally.{NC}")
            user_input = input(f"Do you want to delete and recreate it? (y/N): ")
            if user_input.lower() != 'y':
                print(f"{YELLOW}Operation cancelled.{NC}")
                return False
            # Delete existing tag
            subprocess.run(["git", "tag", "-d", tag_name])
            print(f"{GREEN}Deleted existing local tag: {tag_name}{NC}")
    except Exception as e:
        print(f"{RED}Error checking existing tags: {e}{NC}")
        return False
    
    # Create git tag
    success = run_flutter_command(["git", "tag", tag_name], f"Creating tag {tag_name}...                             ")
    if not success:
        print(f"{RED}Failed to create git tag.{NC}")
        return False
    
    # Push tag to remote
    success = run_flutter_command(["git", "push", "-u", "origin", tag_name], f"Pushing tag to remote...                            ")
    if not success:
        print(f"{RED}Failed to push tag to remote.{NC}")
        return False
    
    print(f"\n{GREEN}✓ Git tag {tag_name} created and pushed successfully!{NC}")
    return True

def uninstall_app():
    """Uninstall the app from connected device"""
    print(f"{YELLOW}Uninstalling app from device...{NC}\n")
    success = run_flutter_command(["adb", "uninstall", "com.royalcourtbd.dhaka_bus"], "Uninstalling app...                                 ")
    if success:
        print(f"\n{GREEN}✓ App uninstalled successfully!{NC}")
    else:
        print(f"\n{RED}✗ Failed to uninstall app!{NC}")
    return success

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
    print("  apk-split    Build APK with --split-per-abi")
    print("  aab          Build release AAB")
    print("  lang         Generate localization files")
    print("  db           Run build_runner")
    print("  setup        Perform full project setup")
    print("  cache-repair Repair pub cache")
    print("  cleanup      Clean project and get dependencies")
    print("  release-run  Build & install release APK on connected device")
    print("  uninstall    Uninstall app from connected device")
    print("  pod          Update iOS pods")
    print("  tag          Create and push git tag from pubspec version")
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
    elif command == "apk-split":
        build_apk_split_per_abi()
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
    elif command == "uninstall":
        uninstall_app()
    elif command == "pod":
        update_pods()
    elif command == "tag":
        create_and_push_tag()
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