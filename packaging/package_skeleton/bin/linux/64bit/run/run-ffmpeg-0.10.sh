#!/bin/bash
_MODULE_DIR_=@BIN_DIR@/ffmpeg-0.10-dir
PATH=$_MODULE_DIR_
LD_LIBRARY_PATH=$_MODULE_DIR_ ffmpeg $@

