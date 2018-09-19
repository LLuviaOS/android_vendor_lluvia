ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/lluvia/config/BoardConfigQcom.mk
endif

include vendor/aosp/config/BoardConfigSoong.mk
