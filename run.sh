#!/bin/bash
cd `dirname $0`
if [[ ! -d /home/runner/debian12-chroot ]]; then
    # 构建 chroot 环境
    sudo apt install debootstrap qemu-user-static -y
    if [[ -f /tmp/arm64 ]]; then
        debootstrap --arch=arm64 bookworm /home/runner/debian12-chroot
    else
        debootstrap bookworm /home/runner/debian12-chroot    
    fi
    sudo ./pardus-chroot /home/runner/debian12-chroot
fi
sudo chroot /home/runner/debian12-chroot "$@"