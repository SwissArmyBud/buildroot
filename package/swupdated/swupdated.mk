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

define SWUPDATED_COPY_RULES_TO_TARGET
	cp $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/*.rules $(TARGET_DIR)/etc/udev/rules.d/
endef
SWUPDATED_POST_INSTALL_TARGET_HOOKS += SWUPDATED_COPY_RULES_TO_TARGET

define SWUPDATED_COPY_SCRIPT_TO_TARGET
	cp $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/socketclient.sh $(TARGET_DIR)/etc/udev/client.sh
endef
SWUPDATED_POST_INSTALL_TARGET_HOOKS += SWUPDATED_COPY_SCRIPT_TO_TARGET

define SWUPDATED_COPY_SERVER_TO_TARGET
	cat $(BUILD_DIR)/swupdated-$(SWUPDATED_VERSION)/socketserver.js | sed -e 's|//.*||g' | awk 'NF' > $(TARGET_DIR)/etc/udev/server.js
	echo "  - FINISHED!"
endef
SWUPDATED_POST_INSTALL_TARGET_HOOKS += SWUPDATED_COPY_SERVER_TO_TARGET

define SWUPDATED_INSTALL_TARGET_CMDS
	echo "  - INSTALLING: Node.js SWupdate Daemon for sysV & udev"
endef

$(eval $(generic-package))
