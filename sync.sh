# Remove
rm -rf hardware/st/nfc
rm -rf packages/apps/Dialer
rm -rf packages/apps/Contacts
rm -rf packages/apps/Messaging
# rm -rf packages/apps/ExactCalculator
rm -rf packages/resources/devicesettings

# Device
git clone -b 13 https://github.com/parixxshit/device_xiaomi_spes.git device/xiaomi/spes
git clone -b 13 https://github.com/parixxshit/device_xiaomi_sm6225-common.git device/xiaomi/sm6225-common
git clone -b thirteen https://github.com/PixelExperience-Devices/device_xiaomi_sm6225-common-miuicamera.git device/xiaomi/sm6225-common-miuicamera

git clone -b thirteen https://github.com/PixelExperience-Devices/kernel_xiaomi_sm6225.git kernel/xiaomi/sm6225
git clone -b thirteen https://github.com/PixelExperience-Devices/device_xiaomi_spes-kernel.git device/xiaomi/spes-kernel

git clone -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_sm6225-common.git vendor/xiaomi/sm6225-common
git clone -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_xiaomi_sm6225-common-miuicamera.git vendor/xiaomi/sm6225-common-miuicamera

# Packages
git clone -b tokui https://github.com/P-404/android_packages_apps_Dialer.git packages/apps/Dialer
git clone -b tokui https://github.com/P-404/android_packages_apps_Contacts.git packages/apps/Contacts
git clone -b tokui https://github.com/P-404/android_packages_apps_Messaging.git packages/apps/Messaging
# git clone -b tokui https://github.com/P-404/android_packages_apps_ExactCalculator.git packages/apps/ExactCalculator
git clone -b thirteen https://github.com/PixelExperience/packages_resources_devicesettings.git packages/resources/devicesettings

# Hardware
git clone -b thirteen https://github.com/PixelExperience/hardware_st_nfc.git hardware/st/nfc
git clone -b thirteen https://github.com/PixelExperience/hardware_xiaomi.git hardware/xiaomi

git clone -b thirteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_gps.git hardware/qcom-caf/bengal/gps
git clone -b thirteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_media.git hardware/qcom-caf/bengal/media
git clone -b thirteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_audio.git hardware/qcom-caf/bengal/audio
git clone -b thirteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_display.git hardware/qcom-caf/bengal/display

# Device (QCOM)
git clone -b thirteen https://github.com/PixelExperience-Devices/device_qcom_common.git device/qcom/common # Adapt FCM for DerpFest
git clone -b thirteen https://github.com/PixelExperience-Devices/device_qcom_qssi.git device/qcom/qssi
git clone -b thirteen https://github.com/PixelExperience-Devices/device_qcom_wlan.git device/qcom/wlan
git clone -b thirteen https://github.com/PixelExperience-Devices/device_qcom_common-sepolicy.git device/qcom/common-sepolicy # Adapt sepolicy for DerpFest
git clone -b thirteen https://github.com/PixelExperience-Devices/device_qcom_vendor-common.git device/qcom/vendor-common

# Vendor (QCOM)
git clone -b thirteen https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_qcom_common.git vendor/qcom/common
git clone -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_core-utils.git vendor/qcom/opensource/core-utils
git clone -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_commonsys_dpm.git vendor/qcom/opensource/commonsys/dpm
git clone -b thirteen https://github.com/PixelExperience/vendor_qcom_opensource_commonsys-intf_bluetooth.git vendor/qcom/opensource/commonsys-intf/bluetooth

# Patch frameworks/base
pushd frameworks/base
git fetch https://github.com/parixxshit/frameworks_base.git
git cherry-pick 8b318b0 50ab912 # Guard BoostFramework with overlay
popd

# Patch vendor/qcom/common
pushd device/qcom/common
git fetch https://github.com/parixxshit/device_qcom_common.git
git cherry-pick feb9d85 # Adapt FCM for DerpFest
popd

# Patch device/qcom/common-sepolicy
pushd device/qcom/common-sepolicy
git fetch https://github.com/parixxshit/device_qcom_common-sepolicy.git
git cherry-pick 1a7aa02 # Adapt sepolicy for DerpFest
popd

# Patch packages/resources/devicesettings
# pushd packages/resources/devicesettings
# git fetch https://github.com/Deepak5310/android_packages_resources_devicesettings.git
# git cherry-pick ac8b243^..2a3307e # Add custom strings
# popd

# Patch vendor/qcom/opensource/interfaces
# pushd qcom/opensource/interfaces
# git fetch https://github.com/PixelExperience/vendor_qcom_opensource_interfaces.git
# git cherry-pick 0a1e849 # Introduce the QTI FM HAL
# popd

# Patch packages/apps/Updater
pushd packages/apps/Updater
git fetch https://github.com/parixxshit/packages_apps_Updater.git
git cherry-pick 7554a70 # Update server and changelog url
popd

# Patch vendor/derp
pushd vendor/derp
git fetch https://github.com/parixxshit/vendor_derp.git -t 13-custom
git cherry-pick 95d7761^..cf1f878 # Last 5
# Add: https://github.com/AOSPA/android_vendor_aospa/commit/79d30123868e4943b563598b0a20d3a1aaf33732
# Here: https://github.com/DerpFest-AOSP/vendor_derp/blob/13/config/common.mk "Blur"
popd

# Patch vendor/qcom/opensource/fm-commonsys
pushd vendor/qcom/opensource/fm-commonsys
git fetch https://github.com/PixelExperience/vendor_qcom_opensource_fm-commonsys.git
git cherry-pick 74f4211 # Define soong namespace
popd

# Build
. build/envsetup.sh
lunch derp_spes-user && mka derp
