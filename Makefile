include theos/makefiles/common.mk

TWEAK_NAME = CustomLockScreen
CustomLockScreen_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += customlockscreenprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
