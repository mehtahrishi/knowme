# FILE: knowme/main.py

from . import ascii
from . import system_info
from .utils import colorize

def main():
    """
    Main function to fetch info and print it in a two-column layout.
    """
    logo_str = ascii.get_os_logo()
    info_dict = system_info.get_all_system_info()

    # Split logo and info into lines for processing
    logo_lines = logo_str.strip().split('\n')
    info_lines = []

    # Format the information dictionary into "Key: Value" strings
    for key, value in info_dict.items():
        # The 'Condition' value is already colorized in system_info.py
        if key == "Condition":
            colored_value = str(value)
        else:
            colored_value = colorize(str(value))
        
        # Handle multi-line values (like Disk and Network info)
        if '\n' in str(value):
            parts = str(value).split('\n')
            # Colorize the first part differently if it's not pre-colored
            first_part_colored = colorize(parts[0]) if key != "Condition" else parts[0]
            info_lines.append(f"{key}: {first_part_colored}")

            for part in parts[1:]:
                # Indent and colorize subsequent lines
                info_lines.append(f"   {colorize(part.strip())}")
        else:
            info_lines.append(f"{key}: {colored_value}")

    # Determine the maximum width of the logo to align the info column
    max_logo_width = max(len(line) for line in logo_lines) if logo_lines else 0
    gutter_width = 4  # Spaces between logo and info

    # Combine logo and info lines side-by-side
    num_display_lines = max(len(logo_lines), len(info_lines))

    for i in range(num_display_lines):
        # Get the plain logo line for length calculation
        plain_logo_line = logo_lines[i] if i < len(logo_lines) else ""
        
        # Colorize the logo part
        colored_logo_part = colorize(plain_logo_line)

        # Get the info part
        info_part = info_lines[i] if i < len(info_lines) else ""

        # Calculate padding based on the *visible* length of the logo line
        padding = " " * (max_logo_width - len(plain_logo_line) + gutter_width)

        print(f"{colored_logo_part}{padding}{info_part}")

if __name__ == "__main__":
    main()