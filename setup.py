# FILE: setup.py

from setuptools import setup, find_packages
import sys

# Add platform-specific dependencies
install_requires = [
    "psutil",
    "distro",
    "py-cpuinfo",
    "requests",
    "GPUtil",
    "screeninfo",
    "netifaces", # For network gateways
]

# WMI is only available on Windows
if sys.platform == "win32":
    install_requires.append("py-wmi")

setup(
    name="knowme",
    version="0.4.0",
    packages=find_packages(),
    install_requires=install_requires,
    entry_points={
        "console_scripts": [
            "knowme = knowme.main:main",
        ],
    },
    author="Gemini",
    author_email="gemini@example.com",
    description="A command-line tool to display detailed system information with an ASCII logo.",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    url="https://github.com/yourusername/knowme",
)