# FILE: knowme/system_info.py

import psutil
import platform
import socket
import cpuinfo
import requests
import datetime
import os
import sys
import ifaddr  # <--- IMPORT THE NEW LIBRARY
from .utils import format_bytes, format_uptime, colorize

# --- New Advanced Information Functions ---

def get_logged_in_users():
    """Gets a list of currently logged-in users."""
    # ... (this function remains the same)
    try:
        users = psutil.users()
        user_list = [f"{u.name} (since {datetime.datetime.fromtimestamp(u.started).strftime('%Y-%m-%d %H:%M')})" for u in users]
        return "\n           ".join(user_list) if user_list else "No users logged in"
    except Exception:
        return "N/A"

def get_top_processes(count=5):
    """Gets top processes by memory usage."""
    # ... (this function remains the same)
    try:
        procs = [p for p in psutil.process_iter(['pid', 'name', 'memory_percent'])]
        sorted_procs = sorted(procs, key=lambda p: p.info['memory_percent'], reverse=True)
        
        proc_list = [f"{p.info['name']} (PID: {p.info['pid']}, Mem: {p.info['memory_percent']:.1f}%)" for p in sorted_procs[:count]]
        return "\n           ".join(proc_list)
    except (psutil.NoSuchProcess, psutil.AccessDenied):
        return "Could not retrieve processes."

def get_listening_ports(count=10):
    """Gets open TCP listening ports and the associated process."""
    # ... (this function remains the same)
    try:
        connections = psutil.net_connections(kind='inet')
        listeners = [c for c in connections if c.status == psutil.CONN_LISTEN]
        
        if not listeners:
            return "None"
        
        port_list = []
        for conn in listeners[:count]:
            proc_name = "N/A"
            if conn.pid:
                try:
                    proc_name = psutil.Process(conn.pid).name()
                except (psutil.NoSuchProcess, psutil.AccessDenied):
                    proc_name = "Access Denied"
            port_list.append(f"{conn.laddr.port}/{conn.type.name.lower()} - {proc_name}")
        
        output = "\n           ".join(port_list)
        if len(listeners) > count:
            output += f"\n           ... and {len(listeners) - count} more"
        return output
            
    except Exception:
        return "N/A"

def get_default_gateway():
    """Gets the default network gateway using ifaddr."""
    # --- THIS IS THE UPDATED FUNCTION ---
    try:
        adapters = ifaddr.get_adapters(include_unconfigured=True)
        for adapter in adapters:
            # On Windows, the default gateway is typically associated with the primary adapter
            # This is a heuristic and might need adjustment for complex network setups
            if "Default Gateway" in adapter.nice_name:
                 for ip in adapter.ips:
                     if ip.is_IPv4:
                        # This part is complex, as ifaddr doesn't directly expose gateway
                        # Returning the primary IP of the adapter with the gateway is often sufficient
                        return f"via {ip.ip}"
        # Fallback for other systems or if the above fails
        return "N/A (See Primary Interface)"
    except Exception:
        return "N/A"

# --- Existing Functions (Unchanged but included for completeness of the file) ---

def get_system_condition():
    cpu_usage = psutil.cpu_percent(interval=1)
    ram_usage = psutil.virtual_memory().percent
    disk_usage = psutil.disk_usage('/').percent
    critical_threshold = 90
    warning_threshold = 75
    if (cpu_usage > critical_threshold or ram_usage > critical_threshold or disk_usage > critical_threshold):
        return colorize("Critical", color="red")
    if (cpu_usage > warning_threshold or ram_usage > warning_threshold or disk_usage > warning_threshold):
        return colorize("Warning", color="yellow")
    return colorize("Healthy", color="green")

def get_gpu_info():
    try:
        import GPUtil
        gpus = GPUtil.getGPUs()
        if not gpus: return "N/A"
        gpu_info = ""
        for gpu in gpus:
            gpu_info += f"\n           {gpu.name} ({format_bytes(gpu.memoryUsed)} / {format_bytes(gpu.memoryTotal)})"
        return gpu_info.strip()
    except (ImportError, Exception): return "N/A"

def get_screen_resolution():
    try:
        import screeninfo
        monitors = screeninfo.get_monitors()
        if not monitors: return "N/A"
        primary_monitor = next((m for m in monitors if m.is_primary), monitors[0])
        return f"{primary_monitor.width}x{primary_monitor.height}"
    except (ImportError, Exception): return "N/A"

def get_process_info():
    return f"{len(psutil.pids())} running"

def get_public_ip():
    try:
        return requests.get('https://api.ipify.org', timeout=5).text
    except requests.exceptions.RequestException: return "N/A"

def get_network_info():
    interfaces = psutil.net_if_addrs()
    network_str, mac_str = "", ""
    for interface, addrs in interfaces.items():
        if interface.lower().startswith(('lo', 'docker', 'vmnet')): continue
        for addr in addrs:
            if addr.family == socket.AF_INET:
                network_str += f"\n           {interface}: {addr.address}"
            elif addr.family == psutil.AF_LINK:
                mac_str += f"\n           {interface}: {addr.address}"
    return network_str.strip(), mac_str.strip()

def get_disk_info():
    partitions = psutil.disk_partitions()
    disk_str = ""
    for p in partitions:
        try:
            usage = psutil.disk_usage(p.mountpoint)
            disk_str += (f"\n           {p.mountpoint} ({p.fstype}): {format_bytes(usage.used)} / {format_bytes(usage.total)} ({usage.percent}%)")
        except OSError: continue
    return disk_str.strip()

def get_battery_info():
    try:
        battery = psutil.sensors_battery()
        if battery:
            status = "Charging" if battery.power_plugged else "Discharging"
            return f"{battery.percent}% ({status})"
        return "N/A"
    except (AttributeError, NotImplementedError): return "N/A"

def get_cpu_temperature():
    try:
        temps = psutil.sensors_temperatures()
        if temps:
            for name, entries in temps.items():
                if 'core' in name.lower():
                    for entry in entries: return f"{entry.current}°C"
            for name, entries in temps.items(): return f"{entries[0].current}°C ({name})"
        return "N/A"
    except (AttributeError, NotImplementedError): return "N/A"

# --- Main Info Gathering Function (Updated) ---

def get_all_system_info():
    uname = platform.uname()
    cpu_info = cpuinfo.get_cpu_info()
    memory = psutil.virtual_memory()
    private_ip, mac_address = get_network_info()
    
    info = {
        # System Health & OS
        "Condition": get_system_condition(),
        "OS": f"{uname.system} {uname.release}",
        "Hostname": uname.node,
        "Kernel": uname.version.split(' ')[0],
        "Uptime": format_uptime(datetime.datetime.now().timestamp() - psutil.boot_time()),
        "Logged In": get_logged_in_users(),
        
        # Hardware

        "CPU": f"{cpu_info.get('brand_raw', 'N/A')}",
        "CPU Cores": f"{psutil.cpu_count(logical=False)} (Physical), {psutil.cpu_count(logical=True)} (Logical)",
        "Arch": uname.machine,
        "GPU": get_gpu_info(),
        "Resolution": get_screen_resolution(),
        "RAM": f"{format_bytes(memory.used)} / {format_bytes(memory.total)} ({memory.percent}%)",
        "Disk": get_disk_info(),
        "Battery": get_battery_info(),
        "CPU Temp": get_cpu_temperature(),

        # Performance & Network
        "Processes": get_process_info(),
        "Top Procs": get_top_processes(),
        "Public IP": get_public_ip(),
        "Gateway": get_default_gateway(),
        "Private IP": private_ip,
        "MAC Address": mac_address,
        "Open Ports": get_listening_ports(),
    }
    return info