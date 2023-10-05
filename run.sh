#!/bin/bash
cd `dirname $0`
if [[ ! -d /home/runner/debian12-chroot ]]; then
    # 构建 chroot 环境
    sudo apt install debootstrap qemu-user-static -y
    if [[ -f /tmp/arm64 ]]; then
        sudo debootstrap --arch=arm64 bookworm /home/runner/debian12-chroot
    else 
        if [[ -f /tmp/mips64el ]]; then
            sudo debootstrap --arch=mips64el bookworm /home/runner/debian12-chroot    
        else
            if [[ -f /tmp/riscv64 ]]; then
                sudo debootstrap --arch=riscv64 sid /home/runner/debian12-chroot    
            else
                if [[ -f /tmp/loong64 ]]; then
                    sudo debootstrap --no-check-gpg --arch=riscv64 sid /home/runner/debian12-chroot http://deb.debian.org/debian-ports
                else
                    sudo debootstrap bookworm /home/runner/debian12-chroot   
                fi
            fi
        fi
    fi
    sudo ./pardus-chroot /home/runner/debian12-chroot
fi
sudo chroot /home/runner/debian12-chroot "$@"