################################################################################
#                               Configuration                                  #
################################################################################

# Target board (see boards/)
# BOARD =

# Target chip (see boards/$(BOARD)/)
# CHIP =

# Target platform. Specify platform-specific GCC flags with TARGETOPTS variable
TARGET = arm-none-eabi

# Optimization level
OPTIMIZATION = -Os

# Builtin trace level
# ------------------------
# TRACE_LEVEL_DEBUG      5
# TRACE_LEVEL_INFO       4
# TRACE_LEVEL_WARNING    3
# TRACE_LEVEL_ERROR      2
# TRACE_LEVEL_FATAL      1
# TRACE_LEVEL_NO_TRACE   0
TRACE_LEVEL = 0

# Optional features
# FEATURES = bmp rand retarget stdio string wav
FEATURES =

# Source code location
SRC = src

# Output directories
OBJ = obj
BIN = out

# Output file name
OUTPUT = $(BIN)/libat91.a

################################################################################
#                                 Toolchain                                    #
################################################################################

# Compilation tools
CC = $(TARGET)-gcc
AR = $(TARGET)-ar
SIZE = $(TARGET)-size

# C compiler flags
CFLAGS += -Wall -g -mlong-calls -ffunction-sections
CFLAGS += $(TARGETOPTS) $(OPTIMIZATION) -D$(CHIP) -DTRACE_LEVEL=$(TRACE_LEVEL)

# Asm compiler flags
ASFLAGS += -Wall -g $(TARGETOPTS) $(OPTIMIZATION) -D$(CHIP) -D__ASSEMBLY__

################################################################################
#                             Source tree layout                               #
################################################################################

# Subdirectories
BOARDS   = $(SRC)/boards
COMP     = $(SRC)/components
DRV      = $(SRC)/drivers
MEM      = $(SRC)/memories
PERIPH   = $(SRC)/peripherals
USB      = $(SRC)/usb
UTIL     = $(SRC)/utility

# Headers
INCLUDES += -I$(BOARDS)/$(BOARD)
INCLUDES += -I$(COMP)
INCLUDES += -I$(DRV)
INCLUDES += -I$(MEM)
INCLUDES += -I$(PERIPH)
INCLUDES += -I$(SRC)

# Source directories
VPATH    += $(BOARDS)/$(BOARD)
VPATH    += $(BOARDS)/$(BOARD)/$(CHIP)
VPATH    += $(COMP)/ads7843
VPATH    += $(COMP)/codec-ad1981b
VPATH    += $(COMP)/codec-ak4641
VPATH    += $(COMP)/dac-at73c213
VPATH    += $(COMP)/ethernet/dm9161
VPATH    += $(COMP)/iso7816
VPATH    += $(COMP)/kbmatrix
VPATH    += $(COMP)/kbmatrix/s7lekkbm
VPATH    += $(COMP)/omnivision
VPATH    += $(COMP)/omnivision/ov9655
VPATH    += $(COMP)/sensors/ms5540b
VPATH    += $(COMP)/slcd/s7leklcd
VPATH    += $(COMP)/slcd/s7lstklcd
VPATH    += $(DRV)/async
VPATH    += $(DRV)/dmad
VPATH    += $(DRV)/lcd
VPATH    += $(DRV)/tsd
VPATH    += $(DRV)/twi
VPATH    += $(MEM)
VPATH    += $(MEM)/flash
VPATH    += $(MEM)/nandflash
VPATH    += $(MEM)/norflash
VPATH    += $(MEM)/sdmmc
VPATH    += $(MEM)/spi-flash
VPATH    += $(PERIPH)/ac97c
VPATH    += $(PERIPH)/adc
VPATH    += $(PERIPH)/aes
VPATH    += $(PERIPH)/aic
VPATH    += $(PERIPH)/can
VPATH    += $(PERIPH)/cp15
VPATH    += $(PERIPH)/dbgu
VPATH    += $(PERIPH)/dma
VPATH    += $(PERIPH)/eefc
VPATH    += $(PERIPH)/efc
VPATH    += $(PERIPH)/emac
VPATH    += $(PERIPH)/isi
VPATH    += $(PERIPH)/lcd
VPATH    += $(PERIPH)/mci
VPATH    += $(PERIPH)/pio
VPATH    += $(PERIPH)/pit
VPATH    += $(PERIPH)/pmc
VPATH    += $(PERIPH)/pwmc
VPATH    += $(PERIPH)/rstc
VPATH    += $(PERIPH)/rtc
VPATH    += $(PERIPH)/rtt
VPATH    += $(PERIPH)/shdwc
VPATH    += $(PERIPH)/slcdc
VPATH    += $(PERIPH)/slck
VPATH    += $(PERIPH)/spi
VPATH    += $(PERIPH)/ssc
VPATH    += $(PERIPH)/supc
VPATH    += $(PERIPH)/tc
VPATH    += $(PERIPH)/tdes
VPATH    += $(PERIPH)/tsadcc
VPATH    += $(PERIPH)/twi
VPATH    += $(PERIPH)/usart
VPATH    += $(USB)/common
VPATH    += $(USB)/common/audio
VPATH    += $(USB)/common/cdc
VPATH    += $(USB)/common/core
VPATH    += $(USB)/common/hid
VPATH    += $(USB)/common/massstorage
VPATH    += $(USB)/device
VPATH    += $(USB)/device/audio-speaker
VPATH    += $(USB)/device/ccid
VPATH    += $(USB)/device/cdc-serial
VPATH    += $(USB)/device/cdc-serial/drv
VPATH    += $(USB)/device/composite
VPATH    += $(USB)/device/composite/drv
VPATH    += $(USB)/device/core
VPATH    += $(USB)/device/hid-keyboard
VPATH    += $(USB)/device/hid-mouse
VPATH    += $(USB)/device/hid-transfer
VPATH    += $(USB)/device/massstorage
VPATH    += $(USB)/host
VPATH    += $(UTIL)

CFLAGS   += $(INCLUDES)
ASFLAGS  += $(INCLUDES)

################################################################################
#                                 C objects                                    #
################################################################################

# boards/$(BOARD)
C_OBJECTS += board_lowlevel.o
C_OBJECTS += board_memories.o

# components/sensors/ms5540b
C_OBJECTS += ms5540b.o

# components/codec-ak4641
C_OBJECTS += ak4641.o

# components/omnivision
C_OBJECTS += omnivision.o

# components/omnivision/ov9655
C_OBJECTS += ov9655.o

# components/ethernet/dm9161
C_OBJECTS += dm9161.o

# components/ads7843
C_OBJECTS += ads7843.o

# components/kbmatrix
C_OBJECTS += kbmatrix.o

# components/kbmatrix/s7lekkbm
C_OBJECTS += s7lekkbm.o

# components/iso7816
C_OBJECTS += iso7816_4.o

# components/slcd/s7lstklcd
# components/slcd/s7leklcd
ifeq ($(BOARD),$(filter $(BOARD),at91sam7l-ek at91sam7l-stk at91sam7l-vb))
ifeq ($(CHIP),$(filter $(CHIP),at91sam7l64 at91sam7l128))
C_OBJECTS += font1.o
C_OBJECTS += s7lstklcd.o
C_OBJECTS += s7leklcd.o
endif
endif

# components/dac-at73c213
ifeq ($(BOARD),$(filter $(BOARD),at91cap9-stk at91sam7se-ek at91sam9260-ek))
C_OBJECTS += at73c213.o
endif

# drivers/tsd
ifeq ($(BOARD),$(filter $(BOARD),at91sam9m10-ek at91sam9rl-ek at91cap9-dk at91sam9263-ek at91cap9-stk at91sam9261-ek))
C_OBJECTS += tsd_ads7843.o
C_OBJECTS += tsd_com.o
C_OBJECTS += tsd_tsadc.o
endif

# drivers/async
C_OBJECTS += async.o

# drivers/dmad
ifeq ($(BOARD),$(filter $(BOARD),at91sam9rl-ek at91cap9-dk at91cap9-stk))
C_OBJECTS += dmad.o
endif

# drivers/twi
C_OBJECTS += twid.o

# drivers/lcd
ifeq ($(BOARD),$(filter $(BOARD),at91sam9m10-ek at91sam9rl-ek at91cap9-dk at91sam9263-ek at91cap9-stk at91sam9261-ek))
C_OBJECTS += draw.o
C_OBJECTS += font.o
C_OBJECTS += lcdd.o
endif

# memories
C_OBJECTS += MEDDdram.o
C_OBJECTS += MEDFlash.o
C_OBJECTS += MEDNandFlash.o
C_OBJECTS += MEDSdcard.o
C_OBJECTS += MEDSdram.o
C_OBJECTS += Media.o

# memories/norflash
C_OBJECTS += NorFlashAmd.o
C_OBJECTS += NorFlashApi.o
C_OBJECTS += NorFlashCFI.o
C_OBJECTS += NorFlashCommon.o
C_OBJECTS += NorFlashIntel.o

# memories/nandflash
C_OBJECTS += EccNandFlash.o
C_OBJECTS += ManagedNandFlash.o
C_OBJECTS += MappedNandFlash.o
C_OBJECTS += NandFlashModel.o
C_OBJECTS += NandFlashModelList.o
C_OBJECTS += NandSpareScheme.o
C_OBJECTS += RawNandFlash.o
C_OBJECTS += SkipBlockNandFlash.o
C_OBJECTS += TranslatedNandFlash.o

# memories/spi-flash
C_OBJECTS += at26.o
C_OBJECTS += at26d.o
C_OBJECTS += at45.o
C_OBJECTS += at45d.o
C_OBJECTS += spid.o

# memories/flash
C_OBJECTS += flashd_eefc.o
C_OBJECTS += flashd_efc.o

# memories/sdmmc
# NOTE: Had to disable this driver for now, because of missing CRC implementation
# C_OBJECTS += sdmmc_mci.o
# C_OBJECTS += sdmmc_spi.o
# C_OBJECTS += sdspi.o

# peripherals/ac97c
ifeq ($(BOARD),$(filter $(BOARD),at91sam9m10-ek at91sam9rl-ek at91cap9-dk at91sam9263-ek at91cap9-stk))
C_OBJECTS += ac97c.o
endif

# peripherals/adc
C_OBJECTS += adc.o

# peripherals/aes
ifeq ($(BOARD),$(filter $(BOARD),at91sam7xc-ek at91sam9m10-ek at91cap9-dk at91cap9-stk))
C_OBJECTS += aes.o
endif

# peripherals/aic
C_OBJECTS += aic.o

# peripherals/can
ifeq ($(BOARD),$(filter $(BOARD),at91sam7xc-ek at91sam7a3-ek at91cap9-dk at91sam9263-ek at91sam7x-ek))
C_OBJECTS += can.o
endif

# peripherals/cp15
C_OBJECTS += cp15.o

# peripherals/dbgu
C_OBJECTS += dbgu.o

# peripherals/dma
ifeq ($(BOARD),$(filter $(BOARD),at91sam9m10-ek at91sam9rl-ek at91cap9-dk at91cap9-stk))
C_OBJECTS += dma.o
endif

# peripherals/eefc
C_OBJECTS += eefc.o

# peripherals/efc
C_OBJECTS += efc.o

# peripherals/emac
C_OBJECTS += emac.o

# peripherals/isi
C_OBJECTS += isi.o
C_OBJECTS += isi2.o

# peripherals/lcd
C_OBJECTS += lcd.o

# peripherals/mci
C_OBJECTS += mci.o

# peripherals/pio
C_OBJECTS += pio.o
C_OBJECTS += pio_it.o

# peripherals/pit
C_OBJECTS += pit.o

# peripherals/pmc
C_OBJECTS += pmc.o

# peripherals/pwmc
ifeq ($(BOARD),$(filter $(BOARD),at91sam7l-stk at91sam7l-ek at91sam7xc-ek at91sam7se-ek at91sam9m10-ek at91sam7a3-ek at91sam9rl-ek at91cap9-dk at91sam9263-ek at91cap9-stk at91sam7x-ek at91sam7s-ek at91sam7l-vb))
C_OBJECTS += pwmc.o
endif

# peripherals/rtc
ifeq ($(BOARD),$(filter $(BOARD),at91sam7l-stk at91sam7l-ek at91sam9m10-ek at91sam9rl-ek at91sam7l-vb))
C_OBJECTS += rtc.o
endif

# peripherals/rtt
C_OBJECTS += rtt.o

# peripherals/rstc
C_OBJECTS += rstc.o

# peripherals/shdwc
C_OBJECTS += shdwc.o

# peripherals/slcdc
ifeq ($(BOARD),$(filter $(BOARD),at91sam7l-stk at91sam7l-ek at91sam7l-vb))
C_OBJECTS += slcdc.o
endif

# peripherals/slck
C_OBJECTS += slck.o

# peripherals/spi
C_OBJECTS += spi.o

# peripherals/ssc
C_OBJECTS += ssc.o

# peripherals/supc
ifeq ($(BOARD),$(filter $(BOARD),at91sam7l-stk at91sam7l-ek at91sam7l-vb))
C_OBJECTS += supc.o
endif

# peripherals/tc
C_OBJECTS += tc.o

# peripherals/tdes
ifeq ($(BOARD),$(filter $(BOARD),at91sam7xc-ek at91sam9m10-ek at91cap9-dk at91cap9-stk))
C_OBJECTS += tdes.o
endif

# peripherals/tsadcc
C_OBJECTS += tsadcc.o

# peripherals/twi
C_OBJECTS += twi.o

# peripherals/usart
C_OBJECTS += usart.o

# usb/common/core
C_OBJECTS += USBConfigurationDescriptor.o
C_OBJECTS += USBEndpointDescriptor.o
C_OBJECTS += USBFeatureRequest.o
C_OBJECTS += USBGenericDescriptor.o
C_OBJECTS += USBGenericRequest.o
C_OBJECTS += USBGetDescriptorRequest.o
C_OBJECTS += USBInterfaceRequest.o
C_OBJECTS += USBSetAddressRequest.o
C_OBJECTS += USBSetConfigurationRequest.o

# usb/common/audio
C_OBJECTS += AUDFeatureUnitRequest.o
C_OBJECTS += AUDGenericRequest.o

# usb/common/cdc
C_OBJECTS += CDCLineCoding.o
C_OBJECTS += CDCSetControlLineStateRequest.o

# usb/common/hid
C_OBJECTS += HIDIdleRequest.o
C_OBJECTS += HIDKeypad.o
C_OBJECTS += HIDReportRequest.o

# usb/device/hid-transfer
C_OBJECTS += HIDDTransferDriver.o
C_OBJECTS += HIDDTransferDriverDesc.o

# usb/device/core
C_OBJECTS += USBDCallbacks_Initialized.o
C_OBJECTS += USBDCallbacks_RequestReceived.o
C_OBJECTS += USBDCallbacks_Reset.o
C_OBJECTS += USBDCallbacks_Resumed.o
C_OBJECTS += USBDCallbacks_Suspended.o
C_OBJECTS += USBDDriver.o
C_OBJECTS += USBDDriverCb_CfgChanged.o
C_OBJECTS += USBDDriverCb_IfSettingChanged.o
C_OBJECTS += USBD_OTGHS.o
C_OBJECTS += USBD_UDP.o
C_OBJECTS += USBD_UDPHS.o

# usb/device/audio-speaker
C_OBJECTS += AUDDSpeakerChannel.o
C_OBJECTS += AUDDSpeakerDriver.o
C_OBJECTS += AUDDSpeakerDriverDescriptors.o

# usb/device/ccid
C_OBJECTS += cciddriver.o

# usb/device/cdc-serial
C_OBJECTS += CDCDSerialDriver.o
C_OBJECTS += CDCDSerialDriverDescriptors.o

# usb/device/hid-keyboard
C_OBJECTS += HIDDKeyboardCallbacks_LedsChanged.o
C_OBJECTS += HIDDKeyboardDriver.o
C_OBJECTS += HIDDKeyboardDriverDescriptors.o
C_OBJECTS += HIDDKeyboardInputReport.o
C_OBJECTS += HIDDKeyboardOutputReport.o

# usb/device/hid-mouse
C_OBJECTS += HIDDMouseDriver.o
C_OBJECTS += HIDDMouseDriverDescriptors.o
C_OBJECTS += HIDDMouseInputReport.o

# usb/device/massstorage
C_OBJECTS += MSDDStateMachine.o
C_OBJECTS += MSDDriver.o
C_OBJECTS += MSDDriverDescriptors.o
C_OBJECTS += MSDLun.o
C_OBJECTS += SBCMethods.o

# usb/device/composite
ifneq ($(usb_CDCAUDIO)$(usb_CDCCDC)$(usb_CDCHID)$(usb_CDCMSD)$(usb_HIDAUDIO)$(usb_HIDMSD),)
C_OBJECTS += AUDDFunctionDriver.o
C_OBJECTS += CDCDFunctionDriver.o
C_OBJECTS += COMPOSITEDDriver.o
C_OBJECTS += COMPOSITEDDriverDescriptors.o
C_OBJECTS += HIDDFunctionDriver.o
C_OBJECTS += MSDDFunctionDriver.o
endif

# utility
ifneq ($(filter bmp,$(FEATURES)),)
C_OBJECTS += bmp.o
endif
C_OBJECTS += clock.o
C_OBJECTS += hamming.o
ifdef IAP_FUNC_ADDR
C_OBJECTS += iap.o
endif
C_OBJECTS += led.o
C_OBJECTS += math.o
ifneq ($(filter rand,$(FEATURES)),)
C_OBJECTS += rand.o
endif
ifneq ($(filter retarget,$(FEATURES)),)
C_OBJECTS += retarget.o
endif
ifneq ($(filter stdio,$(FEATURES)),)
C_OBJECTS += stdio.o
endif
ifneq ($(filter string,$(FEATURES)),)
C_OBJECTS += string.o
endif
C_OBJECTS += trace.o
C_OBJECTS += util.o
C_OBJECTS += video.o
ifneq ($(filter wav,$(FEATURES)),)
C_OBJECTS += wav.o
endif

################################################################################
#                                Asm objects                                   #
################################################################################

ASM_OBJECTS += board_cstartup.o
ASM_OBJECTS += cp15_asm.o

################################################################################
#                                   Rules                                      #
################################################################################

all: $(OBJ) $(BIN) $(OUTPUT)

$(OBJ) $(BIN):
	mkdir $@

C_OBJECTS := $(addprefix $(OBJ)/, $(C_OBJECTS))
ASM_OBJECTS := $(addprefix $(OBJ)/, $(ASM_OBJECTS))

$(OUTPUT): _VARS $(ASM_OBJECTS) $(C_OBJECTS)
	$(AR) -rcs $(OUTPUT) $(ASM_OBJECTS) $(C_OBJECTS)
	$(SIZE) $(ASM_OBJECTS) $(C_OBJECTS)

$(C_OBJECTS): $(OBJ)/%.o: %.c Makefile _VARS $(OBJ) $(BIN)
	$(CC) $(CFLAGS) -c -o $@ $<

$(ASM_OBJECTS): $(OBJ)/%.o: %.S Makefile _VARS $(OBJ) $(BIN)
	$(CC) $(ASFLAGS) -c -o $@ $<

_VARS:
ifndef BOARD
	$(error BOARD is not set)
endif
ifndef CHIP
	$(error CHIP is not set)
endif

clean:
	rm -f $(OBJ)/*.o $(OUTPUT)
