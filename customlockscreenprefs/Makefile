include theos/makefiles/common.mk

BUNDLE_NAME = CustomLockScreenPrefs
CustomLockScreenPrefs_FILES = CustomLockScreenPrefs.mm
CustomLockScreenPrefs_INSTALL_PATH = /Library/PreferenceBundles
CustomLockScreenPrefs_FRAMEWORKS = UIKit
CustomLockScreenPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CustomLockScreenPrefs.plist$(ECHO_END)
