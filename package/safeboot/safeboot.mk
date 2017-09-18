################################################################################
#
# safeboot
#
################################################################################

SAFEBOOT_VERSION = master
SAFEBOOT_SITE = http://github.com/swissarmybud/safeboot
SAFEBOOT_SITE_METHOD = git
SAFEBOOT_INSTALL_TARGET = YES
SAFEBOOT_DEPENDENCIES = uboot

define SWUPDATED_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/etc/safeboot
	mkdir $(TARGET_DIR)/etc/safeboot
	cp $(BUILD_DIR)/safeboot-$(SAFEBOOT_VERSION)/*/* $(TARGET_DIR)/etc/swupdated/
endef

$(eval $(generic-package))
