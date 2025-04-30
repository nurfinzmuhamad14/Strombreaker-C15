
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
DEFCONFIG="RMX2195_defconfig"
clear
echo -e " "
echo -e "${txtbld}Config:${txtrst} $DEFCONFIG"
echo -e "${txtbld}ARCH:${txtrst} arm64"
echo -e "${txtbld}Username:${txtrst} $KBUILD_BUILD_USER"
echo -e "$(make kernelversion)-release"

if [[ $1 == "-mr" || $1 == "--mrproper" ]]; then
if [  -d "./out/" ]; then
echo -e " "
        rm -rf  ./out/
fi
echo -e "Cleared"
sleep 2
fi
echo -e "$blue    \nMake DefConfig\n $nocol"
mkdir -p out
make O=out ARCH=arm64 $DEFCONFIG

sleep 2
# Build start
echo -e "$blue    \nStarting kernel compilation...\n $nocol"
make -j$(nproc --all) O=out ARCH=arm64 CC="ccache clang" LD=ld.lld AS=llvm-as AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- CLANG_TRIPLE=aarch64-linux-gnu- Image.gz
