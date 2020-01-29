include vendor/lluvia/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/lluvia/config/BoardConfigQcom.mk
else

ifneq ($(FORCE_QCOM_DISPLAY_HAL_VARIANT),)
include vendor/lluvia/config/BoardConfigQcomDisplayOverride.mk
endif

endif

include vendor/lluvia/config/BoardConfigSoong.mk
