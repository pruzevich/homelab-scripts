import os
import glob

def find_rar_files(parent_folder):
    # Dictionary to hold folder names with .rar files
    folders_with_rar = {}

    # Walk through all the directories and subdirectories in the parent folder
    for root, dirs, files in os.walk(parent_folder):
        # Use glob to find .rar files in the current directory
        rar_files = glob.glob(os.path.join(root, '*.r00'))
        
        # If there are .rar files in this folder, add the folder and the files to the dictionary
        if rar_files:
            # Key: Folder path relative to the parent folder, Value: List of .rar files
            folders_with_rar[os.path.relpath(root, parent_folder)] = rar_files

    return folders_with_rar

# Usage example
parent_folder_path = 'Z:\movies'  # Replace this with the path to your parent folder
rar_folders = find_rar_files(parent_folder_path)

if rar_folders:
    print("Folders containing .rar files:")
    for folder, files in rar_folders.items():
        print(f"Folder: {folder}, RAR Files: {len(files)}")
else:
    print("No .rar files found in any subfolders.")
