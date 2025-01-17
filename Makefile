# Driver for Realtek PCI-Express card reader
#
# Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.  
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.
#
# Author:
#   wwang (wei_wang@realsil.com.cn)
#   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
#
# Makefile for the PCI-Express Card Reader drivers.
#

TARGET_MODULE := rts_bpp

EXTRA_CFLAGS := -Idrivers/scsi 

obj-m += $(TARGET_MODULE).o

$(TARGET_MODULE)-objs := rtsx.o rtsx_chip.o rtsx_transport.o rtsx_scsi.o rtsx_card.o \
			 general.o sd.o xd.o ms.o

KVERSION := $(shell uname -r)
KDIR := /lib/modules/$(KVERSION)/build
PWD := $(shell pwd)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -rf Module.markers module.order module.sysvers 
debug:
	cp -f ./define.debug ./define.h
	$(MAKE) -C $(MOD_DIR)/build/ SUBDIRS=$(CURDIR) modules
install:
	cp $(TARGET_MODULE).ko $(KDIR)/drivers/scsi -f
clean:
	rm -f *.o *.ko
	rm -f $(TARGET_MODULE).mod.c


