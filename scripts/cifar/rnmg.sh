th main.lua \
-data $HOME_PREFIX/data/Cifar100-whitened \
-dataset cifar100-whitened \
-nDonkeys 4 \
-nEpochs 200 \
-epochSize 300 \
-batchSize 64 \
-iterSize 2 \
-imageSize 36 \
-imageCrop 32 \
-colorspace bgr \
-netType cifar/rnmg \
-nLayer 3 \
-nGPU 3 \
-nEpochsSave 60 \
-train -test
