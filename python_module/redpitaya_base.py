# rp_min.py  — minimal Red Pitaya helper

import os, time, paramiko

class redpitaya_base:
    def __init__(self, host, bitfile, user='root', pwd='root'):
        self.host   = host
        self.bitfile = os.path.abspath(bitfile)
        self.user   = user
        self.pwd    = pwd
        self.ssh    = None

    # --- connection ---
    def connect(self):
        self.ssh = paramiko.SSHClient()
        self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        self.ssh.connect(self.host, username=self.user, password=self.pwd)

    def disconnect(self):
        if self.ssh:
            self.ssh.close()
            self.ssh = None

    # --- bitfile programming ---
    def load_bitfile(self, remote='/root/bit.bin'):
        sftp = self.ssh.open_sftp()
        sftp.put(self.bitfile, remote)
        sftp.close()
        self._sh(f"cat {remote} > /dev/xdevcfg")
        time.sleep(0.1)

    # --- low-level monitor helpers ---
    def read_word(self, addr):
        """Read 32-bit word at absolute address (int or hex-string)."""
        a = self._to_int(addr)
        out = self._sh(f"/opt/redpitaya/bin/monitor {hex(a)}")
        return int(out.strip(), 16)

    def write_word(self, addr, value):
        """Write 32-bit word at absolute address (int or hex-string)."""
        a = self._to_int(addr)
        v = self._to_int(value)
        self._sh(f"/opt/redpitaya/bin/monitor {hex(a)} {hex(v)}")

    # --- field-level convenience (base+offset+bit slice) ---
    def read_reg(self, base, offset, msb=31, lsb=0, signed=False):
        """
        Read a bitfield from base+offset.
        base/offset can be int or hex-string like '0x40000000'.
        """
        addr = self._to_int(base) + self._to_int(offset)
        word = self.read_word(addr)
        width = msb - lsb + 1
        field = (word >> lsb) & ((1 << width) - 1)
        if signed and (field & (1 << (width - 1))):
            field -= (1 << width)
        return field

    def write_reg(self, base, offset, msb=31, lsb=0, value=0):
        """
        Write a bitfield into base+offset (read-modify-write).
        """
        addr = self._to_int(base) + self._to_int(offset)
        word = self.read_word(addr)
        width = msb - lsb + 1
        # insert field
        mask = ((1 << width) - 1) << lsb
        neww = (word & ~mask) | (((int(value) & ((1 << width) - 1)) << lsb) & mask)
        self.write_word(addr, neww)

    # --- internals ---
    def _sh(self, cmd):
        stdin, stdout, stderr = self.ssh.exec_command(cmd)
        out = stdout.read().decode()
        stdout.channel.close()
        return out

    @staticmethod
    def _to_int(x):
        if isinstance(x, int): return x
        s = str(x).lower().strip()
        return int(s, 16) if s.startswith('0x') else int(s)
    

if __name__ == "__main__":

    rp = redpitaya_base("171.64.56.58", "../bitfiles/pid_simple_axi_2ch.bit")
    rp.connect()
    rp.load_bitfile()

    print(rp.read_reg(0x40000000, 4, 31, 0, True))
    rp.write_reg(0x40000000, 4, 31, 0, 123456)
