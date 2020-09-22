
LIBRARY_PATH="/home/mak/Downloads/new_haiku/js-master/jaatsoft/generated/objects/linux/lib"
TEMP_DIR="temp"
REV="../generated/build/haiku-revision"
UPDATE_PKG_REQUIRES_TOOL="../generated/objects/linux/x86_64/release/tools/update_package_requires/update_package_requires"
HAIKU_PORTS_PATH="../generated/objects/haiku/x86_64/packaging/repositories/HaikuPorts"

SCRIPTS_PATH="../build/scripts"
RM_ATTRS="../generated/objects/linux/x86_64/release/tools/rm_attrs"
ADD_ATTRS="../generated/objects/linux/x86_64/release/tools/addattr/addattr"
COPY_ATTR="../generated/objects/linux/x86_64/release/tools/copyattr"
TOOLS_PATH="../generated/objects/linux/x86_64/release/tools"
TOOLCHAIN_BIN="/home/mak/Downloads/new_haiku/js-master/jaatsoft/generated/cross-tools-x86_64/bin"

COMMOM_DIR="../generated/objects/haiku/x86_64/common"
PKG_NAME="libkern.hpkg"

PKG_INFO_DIR="pkg_info"
PKG_INFO_NAME="libkern"

mkdir -p "$TEMP_DIR/hpkg_-$PKG_NAME"


revision=`cat $REV | sed 's/[+-]/_/g'`
version=r1~beta1_${revision}
sed -e s,%HAIKU_PACKAGING_ARCH%,x86_64,g -e s,%HAIKU_SECONDARY_PACKAGING_ARCH_SUFFIX%,,g \
-e s,%HAIKU_VERSION%,${version}-1, \
-e s,%HAIKU_VERSION_NO_REVISION%,${version}, $PKG_INFO_DIR/$PKG_INFO_NAME \
| gcc -E -w -DHAIKU_PACKAGING_ARCH=x86_64 -DHAIKU_REGULAR_BUILD -DHAIKU_BUILD_FEATURE_X86_64_X86_64_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_PRIMARY_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_REGULAR_IMAGE_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_OPENSSL_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_GCC_SYSLIBS_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_GCC_SYSLIBS_DEVEL_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_ICU_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_GIFLIB_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_GLU_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_MESA_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_FFMPEG_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_FLUIDLITE_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBVORBIS_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_FREETYPE_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_FONTCONFIG_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_GUTENPRINT_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_WEBKIT_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBPNG_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBICNS_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_JASPER_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_JPEG_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_ZLIB_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBEDIT_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBSOLV_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBQRENCODE_KDL_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_TIFF_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_OPENEXR_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_ILMBASE_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBDVDREAD_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBDVDNAV_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIBWEBP_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_LIVE555_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_NCURSES_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_EXPAT_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_ZSTD_ENABLED -DHAIKU_BUILD_FEATURE_X86_64_WEBPOSITIVE_ENABLED - > $TEMP_DIR/hpkg_-$PKG_NAME/$PKG_INFO_NAME-package-info


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" \
"$UPDATE_PKG_REQUIRES_TOOL" "$TEMP_DIR/hpkg_-$PKG_NAME/$PKG_INFO_NAME-package-info" "$HAIKU_PORTS_PATH"


mkdir -p "$TEMP_DIR/hpkg_-$PKG_NAME/scripts"


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars
touch $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "addattr=" >> "$script"

firstSeen=
for value in "$ADD_ATTRS" ; do
if [ -z "$firstSeen" ]; then
echo "addattr=\"$value\"" >> "$script"
firstSeen=1
else
echo "addattr=\"\$addattr $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "copyattr=" >> "$script"

firstSeen=
for value in "$COPY_ATTR" ; do
if [ -z "$firstSeen" ]; then
echo "copyattr=\"$value\"" >> "$script"
firstSeen=1
else
echo "copyattr=\"\$copyattr $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "mimeDB=" >> "$script"

firstSeen=
for value in "generated/objects/common/data/mime_db/mime_db" ; do
if [ -z "$firstSeen" ]; then
echo "mimeDB=\"$value\"" >> "$script"
firstSeen=1
else
echo "mimeDB=\"\$mimeDB $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "mimeset=" >> "$script"

firstSeen=
for value in "$TOOLS_PATH/mimeset" ; do
if [ -z "$firstSeen" ]; then
echo "mimeset=\"$value\"" >> "$script"
firstSeen=1
else
echo "mimeset=\"\$mimeset $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "package=" >> "$script"

firstSeen=
for value in "$TOOLS_PATH/package/package" ; do
if [ -z "$firstSeen" ]; then
echo "package=\"$value\"" >> "$script"
firstSeen=1
else
echo "package=\"\$package $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "rc=" >> "$script"

firstSeen=
for value in "$TOOLS_PATH/rc/rc" ; do
if [ -z "$firstSeen" ]; then
echo "rc=\"$value\"" >> "$script"
firstSeen=1
else
echo "rc=\"\$rc $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "resattr=" >> "$script"

firstSeen=
for value in "$TOOLS_PATH/resattr/resattr" ; do
if [ -z "$firstSeen" ]; then
echo "resattr=\"$value\"" >> "$script"
firstSeen=1
else
echo "resattr=\"\$resattr $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "unzip=" >> "$script"

firstSeen=
for value in "$TOOLS_PATH/unzip/unzip" ; do
if [ -z "$firstSeen" ]; then
echo "unzip=\"$value\"" >> "$script"
firstSeen=1
else
echo "unzip=\"\$unzip $value\"" \
>> "$script"
fi
done


script="$TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars"
echo "rmAttrs=" >> "$script"

firstSeen=
for value in "$RM_ATTRS" ; do
if [ -z "$firstSeen" ]; then
echo "rmAttrs=\"$value\"" >> "$script"
firstSeen=1
else
echo "rmAttrs=\"\$rmAttrs $value\"" \
>> "$script"
fi
done


echo sourceDir=\".\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars; echo outputDir=\"generated\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars; echo tmpDir=\"$TEMP_DIR/hpkg_-$PKG_NAME\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars; echo addBuildCompatibilityLibDir=\"export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH"\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars; echo compressionLevel=\"9\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars; echo updateOnly=\"\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars; echo cc=\"$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc\" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars;


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-make-dirs
touch $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-make-dirs


#echo \$mkdir -p "\"\${tPrefix}develop/lib\"" "\"\${tPrefix}lib\"" "\"\${tPrefix}develop/headers/config\"" "\"\${tPrefix}develop/headers/glibc\"" "\"\${tPrefix}develop/headers/alm\"" "\"\${tPrefix}develop/headers/GL\"" "\"\${tPrefix}develop/headers/os\"" "\"\${tPrefix}develop/headers/posix\"" "\"\${tPrefix}develop/headers/private\"" "\"\${tPrefix}develop/headers/private/libs/compat/freebsd_network\"" "\"\${tPrefix}develop/headers/private/libs/compat/freebsd_wlan\"" "\"\${tPrefix}develop/headers/bsd\"" "\"\${tPrefix}develop/headers/gnu\"" "\"\${tPrefix}data/deskbar/menu/Applications\"" "\"\${tPrefix}bin\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-make-dirs

echo \$mkdir -p "\"\${tPrefix}develop/lib\"" "\"\${tPrefix}lib\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-make-dirs

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH"
cat "../src/data/directory_attrs/system-develop.rdef" | $TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -E -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote . -iquote ../generated/objects/common -iquote ../generated/objects/linux/x86_64/common -iquote $COMMON_DIR - \
| egrep -v '^#' | $TOOLS_PATH/rc/rc -I . -I generated/objects/common -I generated/objects/linux/x86_64/common -I $COMMON_DIR --auto-names -o "$COMMON_DIR/system-develop.rsrc" -


export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH"
if [ \\"true\\" = "true" ]; then
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f $COMMON_DIR/haiku.package-make-dirs-attributes-develop
fi
$TOOLS_PATH/resattr/resattr -O -o "$COMMON_DIR/haiku.package-make-dirs-attributes-develop" "$COMMON_DIR/system-develop.rsrc"


echo \$copyAttrs "\"\${sPrefix}$COMMON_DIR/haiku.package-make-dirs-attributes-develop\"" \
"\"\${tPrefix}develop\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-make-dirs


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files
touch $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


#if [ -n "" ]; then
#echo "name=\` \"generated/objects/haiku/x86_64/release/system/kernel/kernel.so\" 2> /dev/null \` || exit 1" \
#>> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files
#fi

echo \$cp "\"\${sPrefix}../generated/objects/haiku/x86_64/release/js_libs/libkern/.\"" \
"\"\${tPrefix}develop/lib/\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wmissing-prototypes -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wmissing-prototypes -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -c "src/system/libroot/empty.c" -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot -iquote generated/objects/common/system/libroot -iquote generated/objects/linux/x86_64/common/system/libroot -iquote $COMMON_DIR/system/libroot -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot -iquote generated/objects/common/system/libroot -iquote generated/objects/linux/x86_64/common/system/libroot -iquote $COMMON_DIR/system/libroot -I headers/private/libroot -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I headers/private/libroot -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/system/libroot/empty.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wmissing-prototypes -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wmissing-prototypes -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -c "src/system/libroot/empty.c" -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot -iquote generated/objects/common/system/libroot -iquote generated/objects/linux/x86_64/common/system/libroot -iquote $COMMON_DIR/system/libroot -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot -iquote generated/objects/common/system/libroot -iquote generated/objects/linux/x86_64/common/system/libroot -iquote $COMMON_DIR/system/libroot -I headers/private/libroot -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I headers/private/libroot -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/system/libroot/empty.o"


#LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f generated/objects/haiku/x86_64/release/system/libroot/libm.a
#$TOOLCHAIN_BIN/x86_64-unknown-haiku-ar cru generated/objects/haiku/x86_64/release/system/libroot/libm.a generated/objects/haiku/x86_64/release/system/libroot/empty.o


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-ranlib generated/objects/haiku/x86_64/release/system/libroot/libm.a


#LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f generated/objects/haiku/x86_64/release/system/libroot/libpthread.a
#$TOOLCHAIN_BIN/x86_64-unknown-haiku-ar cru generated/objects/haiku/x86_64/release/system/libroot/libpthread.a generated/objects/haiku/x86_64/release/system/libroot/empty.o


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-ranlib generated/objects/haiku/x86_64/release/system/libroot/libpthread.a


#mkdir -p "generated/objects/haiku/x86_64/release/libs/posix_error_mapper"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/misc.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/misc.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_attr.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_attr.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_condattr.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_condattr.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_cond.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_cond.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_misc.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_misc.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_mutexattr.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_mutexattr.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_mutex.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_mutex.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_rwlockattr.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_rwlockattr.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_rwlock.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_rwlock.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_specific.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_specific.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_spinlock.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_spinlock.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/pthread_thread.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_thread.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/signal.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/signal.o"


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/libs/posix_error_mapper/time.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/libs/posix_error_mapper -iquote generated/objects/common/libs/posix_error_mapper -iquote generated/objects/linux/x86_64/common/libs/posix_error_mapper -iquote $COMMON_DIR/libs/posix_error_mapper -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/libs/posix_error_mapper/time.o"


#LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f generated/objects/haiku/x86_64/release/libs/posix_error_mapper/libposix_error_mapper.a
#$TOOLCHAIN_BIN/x86_64-unknown-haiku-ar cru generated/objects/haiku/x86_64/release/libs/posix_error_mapper/libposix_error_mapper.a generated/objects/haiku/x86_64/release/libs/posix_error_mapper/misc.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_attr.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_condattr.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_cond.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_misc.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_mutexattr.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_mutex.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_rwlockattr.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_rwlock.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_specific.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_spinlock.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/pthread_thread.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/signal.o generated/objects/haiku/x86_64/release/libs/posix_error_mapper/time.o


#$TOOLCHAIN_BIN/x86_64-unknown-haiku-ranlib generated/objects/haiku/x86_64/release/libs/posix_error_mapper/libposix_error_mapper.a


#echo \$cp "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/glue/arch/x86_64/crti.o\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/glue/arch/x86_64/crtn.o\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/glue/init_term_dyn.o\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/glue/start_dyn.o\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/glue/haiku_version_glue.o\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/kits/interface/libcolumnlistview.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/kits/locale/liblocalestub.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/libroot/libm.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/libroot/libpthread.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/libs/print/libprint/libprint.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/kits/print/libprintutils.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/kits/shared/libshared.a\"" "\"\${sPrefix}generated/objects/haiku/x86_64/release/libs/posix_error_mapper/libposix_error_mapper.a\"" "\"\${tPrefix}develop/lib\"" \
#>> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files

<<COMMENT1
echo \$ln -sfn "\"/system/lib/libroot.so\"" "\"\${tPrefix}develop/lib/libroot.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libalm.so\"" "\"\${tPrefix}develop/lib/libalm.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libbe.so\"" "\"\${tPrefix}develop/lib/libbe.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libbsd.so\"" "\"\${tPrefix}develop/lib/libbsd.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libbnetapi.so\"" "\"\${tPrefix}develop/lib/libbnetapi.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libbluetooth.so\"" "\"\${tPrefix}develop/lib/libbluetooth.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libdebug.so\"" "\"\${tPrefix}develop/lib/libdebug.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libdebugger.so\"" "\"\${tPrefix}develop/lib/libdebugger.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libdevice.so\"" "\"\${tPrefix}develop/lib/libdevice.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libgame.so\"" "\"\${tPrefix}develop/lib/libgame.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libglut.so\"" "\"\${tPrefix}develop/lib/libglut.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libgnu.so\"" "\"\${tPrefix}develop/lib/libgnu.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libmail.so\"" "\"\${tPrefix}develop/lib/libmail.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libmedia.so\"" "\"\${tPrefix}develop/lib/libmedia.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libmidi.so\"" "\"\${tPrefix}develop/lib/libmidi.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libmidi2.so\"" "\"\${tPrefix}develop/lib/libmidi2.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libnetwork.so\"" "\"\${tPrefix}develop/lib/libnetwork.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libpackage.so\"" "\"\${tPrefix}develop/lib/libpackage.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libscreensaver.so\"" "\"\${tPrefix}develop/lib/libscreensaver.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libtextencoding.so\"" "\"\${tPrefix}develop/lib/libtextencoding.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libtracker.so\"" "\"\${tPrefix}develop/lib/libtracker.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libtranslation.so\"" "\"\${tPrefix}develop/lib/libtranslation.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"/system/lib/libroot_debug.so\"" "\"\${tPrefix}develop/lib/libroot_debug.so\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


mkdir -p "generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug"


$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/system/libroot/posix/malloc_debug/heap.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot/posix/malloc_debug -iquote generated/objects/common/system/libroot/posix/malloc_debug -iquote generated/objects/linux/x86_64/common/system/libroot/posix/malloc_debug -iquote $COMMON_DIR/system/libroot/posix/malloc_debug -I headers/private/libroot -I headers/private/shared -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/heap.o"


$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/system/libroot/posix/malloc_debug/guarded_heap.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot/posix/malloc_debug -iquote generated/objects/common/system/libroot/posix/malloc_debug -iquote generated/objects/linux/x86_64/common/system/libroot/posix/malloc_debug -iquote $COMMON_DIR/system/libroot/posix/malloc_debug -I headers/private/libroot -I headers/private/shared -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/guarded_heap.o"


$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -c "src/system/libroot/posix/malloc_debug/malloc_debug_api.cpp" -O2 -Wall -Wno-multichar -Wpointer-arith -Wsign-compare -Wno-ctor-dtor-privacy -Woverloaded-virtual -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -nostdinc -DARCH_x86_64 -DBOOT_ARCHIVE_IMAGE_OFFSET=320 -D__HAIKU_PRIMARY_PACKAGING_ARCH=\"x86_64\" -DHAIKU_DISTRO_COMPATIBILITY_DEFAULT -DHAIKU_TARGET_PLATFORM_HAIKU -DHAIKU_REGULAR_BUILD -iquote build/user_config_headers -iquote build/config_headers -iquote src/system/libroot/posix/malloc_debug -iquote generated/objects/common/system/libroot/posix/malloc_debug -iquote generated/objects/linux/x86_64/common/system/libroot/posix/malloc_debug -iquote $COMMON_DIR/system/libroot/posix/malloc_debug -I headers/private/libroot -I headers/private/shared -I headers/private/runtime_loader -I headers/private/. -I headers/private/system -I headers/private/system/arch/x86_64 -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++ -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/x86_64-unknown-haiku -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/backward -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/c++/ext -I headers/glibc -I headers/posix -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include -I generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/headers/gcc/include-fixed -I headers -I headers/os -I headers/os/add-ons -I headers/os/add-ons/file_system -I headers/os/add-ons/graphics -I headers/os/add-ons/input_server -I headers/os/add-ons/registrar -I headers/os/add-ons/screen_saver -I headers/os/add-ons/tracker -I headers/os/app -I headers/os/device -I headers/os/drivers -I headers/os/game -I headers/os/interface -I headers/os/kernel -I headers/os/locale -I headers/os/media -I headers/os/mail -I headers/os/midi -I headers/os/midi2 -I headers/os/net -I headers/os/storage -I headers/os/support -I headers/os/translation -I headers/private/. -o "generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/malloc_debug_api.o"


$TOOLCHAIN_BIN/x86_64-unknown-haiku-ld  -r generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/heap.o generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/guarded_heap.o generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/malloc_debug_api.o -o generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/posix_malloc_debug.o


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f "generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so"
$TOOLCHAIN_BIN/x86_64-unknown-haiku-gcc -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-builtin-fork -fno-builtin-vfork -Xlinker --no-undefined -shared -Xlinker -soname="libroot.so" -nostdlib -Xlinker --no-undefined -o "generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so"  "generated/objects/haiku/x86_64/release/system/glue/arch/x86_64/crti.o" "/home/mak/Downloads/haiku2/haiku/generated/haiku/generated/cross-tools-x86_64/lib/gcc/x86_64-unknown-haiku/8.3.0/crtbeginS.o" "generated/objects/haiku/x86_64/release/system/glue/init_term_dyn.o" "generated/objects/haiku/x86_64/release/system/libroot/libroot_init.o" \
"generated/objects/haiku/x86_64/release/system/libroot/os/os_main.o" "generated/objects/haiku/x86_64/release/system/libroot/os/arch/x86_64/os_arch_x86_64.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/arch/x86_64/posix_arch_x86_64.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/crypt/posix_crypt.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/locale/posix_locale.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/posix_main.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/pthread/posix_pthread.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/signal/posix_signal.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/stdio/posix_stdio.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/musl/posix_musl.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/arch/x86_64/posix_gnu_arch_x86_64.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/ctype/posix_gnu_ctype.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/extensions/posix_gnu_ext.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/iconv/posix_gnu_iconv.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/libio/posix_gnu_libio.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/locale/posix_gnu_locale.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/math/posix_gnu_math.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/misc/posix_gnu_misc.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/regex/posix_gnu_regex.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/stdio-common/posix_gnu_stdio.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/stdlib/posix_gnu_stdlib.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/glibc/wcsmbs/posix_gnu_wcsmbs.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/stdlib/posix_stdlib.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/string/posix_string.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/string/arch/x86_64/posix_string_arch_x86_64.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/sys/posix_sys.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/time/posix_time.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/unistd/posix_unistd.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/wchar/posix_wchar.o" "generated/objects/haiku/x86_64/release/system/libroot/posix/malloc_debug/posix_malloc_debug.o" "generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/lib/libsupc++.a" "generated/build_packages/gcc_syslibs-8.3.0_2019_05_24-7-x86_64/lib/libgcc_s.so.1" "generated/build_packages/gcc_syslibs_devel-8.3.0_2019_05_24-7-x86_64/develop/lib/libgcc.a"  "/home/mak/Downloads/haiku2/haiku/generated/haiku/generated/cross-tools-x86_64/lib/gcc/x86_64-unknown-haiku/8.3.0/crtendS.o" "generated/objects/haiku/x86_64/release/system/glue/arch/x86_64/crtn.o" \
-Wl,--version-script,src/system/libroot/libroot_versions


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" \
$TOOLS_PATH/settype -t application/x-vnd.Be-elfexecutable "generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so"


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" \
$TOOLS_PATH/mimeset -f --mimedb "generated/objects/common/data/mime_db/mime_db" "generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so"


LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" \
$TOOLS_PATH/setversion "generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so" -system 1 0 0 a 1 -short "Developer Build"


chmod "755" "generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so"


export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH"

$COPY_ATTR --data generated/objects/haiku/x86_64/release/system/libroot/libroot_debug.so generated/objects/haiku/x86_64/release/system/libroot/revisioned/libroot_debug.so || exit 1



revision=0
if [ -n "$REV" ]; then
revision="`cat $REV`"
fi
$TOOLS_PATH/set_haiku_revision generated/objects/haiku/x86_64/release/system/libroot/revisioned/libroot_debug.so "$revision"


echo \$cp "\"\${sPrefix}generated/objects/haiku/x86_64/release/system/libroot/revisioned/libroot_debug.so\"" "\"\${tPrefix}lib\"" \
>> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/config/.\"" \
"\"\${tPrefix}develop/headers/config\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/glibc/.\"" \
"\"\${tPrefix}develop/headers/glibc\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/libs/alm/.\"" \
"\"\${tPrefix}develop/headers/alm\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/libs/glut/GL/.\"" \
"\"\${tPrefix}develop/headers/GL\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/os/.\"" \
"\"\${tPrefix}develop/headers/os\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/posix/.\"" \
"\"\${tPrefix}develop/headers/posix\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/private/.\"" \
"\"\${tPrefix}develop/headers/private\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *.c -x *.cpp -x *.awk -x Jamfile -x miidevs -x usbdevs "\"\${sPrefix}src/libs/compat/freebsd_network/.\"" \
"\"\${tPrefix}develop/headers/private/libs/compat/freebsd_network\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *.c -x Jamfile "\"\${sPrefix}src/libs/compat/freebsd_wlan/.\"" \
"\"\${tPrefix}develop/headers/private/libs/compat/freebsd_wlan\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"os\"" "\"\${tPrefix}develop/headers/be\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/compatibility/bsd/.\"" \
"\"\${tPrefix}develop/headers/bsd\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp -r -x *~ "\"\${sPrefix}headers/compatibility/gnu/.\"" \
"\"\${tPrefix}develop/headers/gnu\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$ln -sfn "\"../../../../apps/Debugger\"" "\"\${tPrefix}data/deskbar/menu/Applications/Debugger\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files


echo \$cp "\"\${sPrefix}src/bin/leak_analyser.sh\"" "\"\${tPrefix}bin\"" \
>> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files
COMMENT1
#comment end here

echo \$cp -r -x *~ "\"\${sPrefix}../generated/objects/haiku/x86_64/release/js_libs/libkern/.\"" \
"\"\${tPrefix}lib/\"" >> $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIBRARY_PATH" $SCRIPTS_PATH/rm_attrs $RM_ATTRS -f $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-extract-files
touch $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-extract-files


$SCRIPTS_PATH/build_haiku_package "output/$PKG_NAME" "$TEMP_DIR/hpkg_-$PKG_NAME/$PKG_INFO_NAME-package-info" $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-init-vars $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-make-dirs $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-copy-files $TEMP_DIR/hpkg_-$PKG_NAME/scripts/haiku.package-extract-files

#$PKG_NAME: Removing and re-creating package contents dir ...
#$PKG_NAME: Collecting package contents ...
#$PKG_NAME: mimeset'ing package contents ...
#$PKG_NAME: Creating the package ...
echo "done"
