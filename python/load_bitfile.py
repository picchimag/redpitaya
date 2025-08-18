import paramiko
from scp import SCPClient
import os


def create_ssh_client(host, user="root", password="root"):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(host, username=user, password=password)
    return ssh

def load_bitfile(
    bitfile_local,
    remote_user="root",
    remote_ip="171.64.56.58",
    remote_password="root",
    remote_dir="/root",
    fpga_dev="/dev/xdevcfg"
):
    if not os.path.exists(bitfile_local):
        raise FileNotFoundError(f"Bitfile not found: {bitfile_local}")
        
    bitfile_name = os.path.basename(bitfile_local)
    remote_path = f"{remote_dir}/{bitfile_name}"

    print(f"Connecting to {remote_user}@{remote_ip}...")
    ssh = create_ssh_client(remote_ip, remote_user, remote_password)

    print(f"Copying {bitfile_name} to {remote_path}...")
    with SCPClient(ssh.get_transport()) as scp:
        scp.put(bitfile_local, remote_path)

    print(f"Programming FPGA using {fpga_dev}...")
    stdin, stdout, stderr = ssh.exec_command(f"cat {remote_path} > {fpga_dev}")
    error = stderr.read().decode()

    ssh.close()

    if error:
        print("Error loading bitfile:", error)
    else:
        print("Bitfile successfully loaded.")

# Example usage:
if __name__ == "__main__":
    # Adjust the path to your bitfile as needed
    bitfile_path = "C:/Users/magrini/Documents/programming/redpitaya/filter_v1_2/filter_template.runs/impl_1/system_wrapper.bit"
    bitfile_path = "C:/Users/magrini/Documents/programming/redpitaya/bitfiles/iir2nd_direct_gpio.bit"
    ip = "171.64.56.58"
    load_bitfile(bitfile_path, remote_ip = ip )
