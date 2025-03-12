
SECONDS=0 # builtin bash timer

#Set Color
blue='\033[0;34m'
grn='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
txtbld=$(tput bold)
txtrst=$(tput sgr0)  
export KBUILD_BUILD_USER=UdyneOS
export KBUILD_BUILD_HOST=Droidx
GAS="$(pwd)/../gas" 
TC_DIR="$(pwd)/../clang" 
export PATH="$TC_DIR/bin:$PATH" 
export PATH="$TC_DIR/:$PATH" 
export PATH="$GAS/bin:$PATH" 
export PATH="$GAS/:$PATH"
DEFCONFIG="RMX2195_defconfig"
clear
echo -e " "
echo -e "${txtbld}Config:${txtrst} $DEFCONFIG"
echo -e "${txtbld}ARCH:${txtrst} arm64"
echo -e "${txtbld}Username:${txtrst} $KBUILD_BUILD_USER"
echo -e "$(make kernelversion)-test"

if [[ $1 == "-mr" || $1 == "--mrproper" ]]; then
if [  -d "./out/" ]; then
echo -e " "
        rm -rf  ./out/
        make O=out clean
        make O=out mrproper
fi
echo -e "Cleared"
sleep 2
fi


if [[ $1 == "-up" || $1 == "--update" ]]; then
if [  -d "./out/" ]; then
echo -e " "
        sudo apt-get update 
        sudo apt-get install -y cpio ccache build-essential bc curl git zip ftp gcc-aarch64-linux-gnu gcc-arm-linux-gnueabi libssl-dev lftp zstd wget libfl-dev python3 libarchive-tools device-tree-compiler zsh 
fi
echo -e "dependencies installed"
sleep 2
fi

if [[ $1 == "-cl" || $1 == "--clang" ]]; then
if [  -d "./out/" ]; then
echo -e " "
        git clone https://github.com/1ndev-ui/android_prebuilts_clang_host_linux-x86_clang-6443078 -b 11.0.1 ../clang --depth=1 
        git clone https://android.googlesource.com/platform/prebuilts/gas/linux-x86 -b master ../gas --depth=1 
fi
echo -e "Clone clang"
sleep 2
fi


echo -e "$blue    \nMake DefConfig\n $nocol"
mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

sleep 2
# Build start
echo -e "$blue    \nStarting kernel compilation...\n $nocol"
make -j$(nproc --all) O=out ARCH=arm64 CC="ccache clang" CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- CLANG_TRIPLE=aarch64-linux-gnu-
