LLUVIA_TARGET_PACKAGE := $(PRODUCT_OUT)/LLuviaOS-$(LLUVIA_VERSION).zip

.PHONY: otapackage trueno bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
trueno: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(LLUVIA_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(LLUVIA_TARGET_PACKAGE) | cut -d ' ' -f1 > $(LLUVIA_TARGET_PACKAGE).md5sum
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}LLuviaOS ${txtrst}";
	@echo -e ${CL_CYN}"                                                              "${CL_RST}
	@echo -e ${CL_CYN}"██╗     ██╗     ██╗   ██╗██╗   ██╗██╗ █████╗  ██████╗ ███████╗"${CL_RST}
	@echo -e ${CL_CYN}"██║     ██║     ██║   ██║██║   ██║██║██╔══██╗██╔═══██╗██╔════╝"${CL_RST}
	@echo -e ${CL_CYN}"██║     ██║     ██║   ██║██║   ██║██║███████║██║   ██║███████╗"${CL_RST}
	@echo -e ${CL_CYN}"██║     ██║     ██║   ██║╚██╗ ██╔╝██║██╔══██║██║   ██║╚════██║"${CL_RST}
	@echo -e ${CL_CYN}"███████╗███████╗╚██████╔╝ ╚████╔╝ ██║██║  ██║╚██████╔╝███████║"${CL_RST}
	@echo -e ${CL_CYN}"╚══════╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝"${CL_RST}
	@echo -e ${CL_RED}"                                                              "${CL_RST}
	@echo -e ${CL_RED}"        There had been a Storm! Enjoy the Nature!             "${CL_RST}
	@echo -e "zip: "$(LLUVIA_TARGET_PACKAGE)
	@echo -e "md5: `cat $(LLUVIA_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(LLUVIA_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: trueno
