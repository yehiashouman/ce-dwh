#!/bin/bash
KALTURA_BIN=@BIN_DIR@
KALTURA_BIN_DIRS=$KALTURA_BIN
KALTURA_BIN_FFMPEG=$KALTURA_BIN_DIRS/ffmpeg-0.6-dir/lib
LD_LIBRARY_PATH=$KALTURA_BIN_FFMPEG $KALTURA_BIN_FFMPEG/segmenter $@
