include vendor/lluvia/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/lluvia/config/BoardConfigQcom.mk
endif

include vendor/lluvia/config/BoardConfigSoong.mk
