# Palworld Profile Copier

## Overview
This package contains two files, `copy_profile.bat` and `copy_profile.ps1`, specifically designed for the game Palworld. Their primary purpose is to copy and backup local save game data associated with one Palworld game server to another. This automation ensures seamless transfer and backup of player data between different server IDs.

## Files Description

### copy_profile.bat
- **Type:** Batch script
- **Function:** Serves as a launcher for the `copy_profile.ps1` PowerShell script. It bypasses standard execution policies to allow the PowerShell script to run without restrictions. It accepts two command-line arguments representing the source and target server IDs for Palworld game saves and passes them to the PowerShell script.

### copy_profile.ps1
- **Type:** PowerShell script
- **Function:**
  - Accepts two parameters: `source` (source server ID) and `target` (target server ID).
  - Validates the presence of these parameters.
  - Determines the local application data path and constructs a path to Palworld's `SaveGames` directory.
  - Ensures the existence of a backup folder within the `SaveGames` directory; creates one if absent.
  - Iterates over subdirectories in the `SaveGames` directory, performing the following operations:
    - Checks existence and creates backups in zip format for both the source and target directories, storing them in the backup folder.
    - Deletes the target directory after backup, if it exists.
    - Copies the source directory to the target location.

## Server IDs
- Server IDs are typically long alphanumeric strings, composed of both letters and numbers. 
- An example format of a server ID might look like this: `AB12CD34EF567890GHIJK1L2M3N4567O`.

## Usage
1. **Prerequisites:** Ensure you have the appropriate permissions to execute batch and PowerShell scripts on your system.
2. **Execution:**
   - Run `copy_profile.bat` with two arguments: the source server ID and the target server ID for Palworld.
   - Example: `copy_profile.bat SourceServerID TargetServerID`

## Notes
- These scripts are tailored for Palworld's directory structure, specifically targeting the `SaveGames` directory under the local application data path. 
- Backups are timestamped, allowing for easy tracking and restoration if necessary.
- A completion message is displayed once the operation is successfully completed.
