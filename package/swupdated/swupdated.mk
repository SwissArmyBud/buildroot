################################################################################
#
# swupdated
#
################################################################################

SWUPDATED_VERSION = master
SWUPDATED_SITE = http://github.com/swissarmybud/swupdated
SWUPDATED_SITE_METHOD = git
SWUPDATED_INSTALL_TARGET = YES
SWUPDATED_DEPENDENCIES = swupdate

define SWUPDATED_COPY_DAEMON_TO_TARGET
	cp $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/daemon/*.rules $(TARGET_DIR)/etc/udev/rules.d/
	cp $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/daemon/socketclient.sh $(TARGET_DIR)/etc/udev/client.sh
	cat $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/daemon/socketserver.js | sed -e 's|//.*||g' | awk 'NF' > $(TARGET_DIR)/etc/udev/server.js
endef
SWUPDATED_POST_INSTALL_TARGET_HOOKS += SWUPDATED_COPY_DAEMON_TO_TARGET

define SWUPDATED_COPY_TOOLS_TO_TARGET
	rm -rf $(TARGET_DIR)/etc/swupdated
	mkdir $(TARGET_DIR)/etc/swupdated
	cp $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/tools/* $(TARGET_DIR)/etc/swupdated/
endef
SWUPDATED_POST_INSTALL_TARGET_HOOKS += SWUPDATED_COPY_TOOLS_TO_TARGET

$(eval $(generic-package))
