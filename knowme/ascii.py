import platform
import distro
from . import logos

def get_os_logo():
    """
    Detects the current OS and returns the corresponding ASCII logo.
    """
    system = platform.system()

    if system == "Linux":
        distro_name = distro.id().lower()
        if "ubuntu" in distro_name:
            return logos.UBUNTU_LOGO
        elif "arch" in distro_name:
            return logos.ARCH_LOGO
        elif "debian" in distro_name:
            return logos.DEBIAN_LOGO
        elif "fedora" in distro_name:
            return logos.FEDORA_LOGO
        else:
            return logos.DEFAULT_LOGO
            
    elif system == "Windows":
        return logos.WINDOWS_LOGO
        
    elif system == "Darwin":
        return logos.MACOS_LOGO
        
    else:
        return logos.DEFAULT_LOGO