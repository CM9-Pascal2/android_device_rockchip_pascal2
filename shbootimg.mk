LOCAL_PATH := $(call my-dir) 

$(PRODUCT_OUT)/utilities/busybox
	$(call pretty,"Bootstrap: $@")
	cp -r device/rockchip/pascal2/bootstrap $(PRODUCT_OUT)
	cp -r device/rockchip/pascal2/bootstrap.sh $(PRODUCT_OUT)
	./$(PRODUCT_OUT)/bootstrap.sh

./$(PRODUCT_OUT)/bootstrap/rkcrc -k $(PRODUCT_OUT)/recovery.gz $(PRODUCT_OUT)/recovery.img
./$(PRODUCT_OUT)/bootstrap/rkcrc -k $(PRODUCT_OUT)/boot.gz $(PRODUCT_OUT)/boot.img
