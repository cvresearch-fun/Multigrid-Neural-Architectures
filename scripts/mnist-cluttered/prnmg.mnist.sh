th main.lua \
-data $HOME_PREFIX/data/mnist-cluttered \
-dataset mnist-spt \
-nDonkeys 4 \
-nEpochs 200 \
-epochSize 800 \
-batchSize 32 \
-iterSize 2 \
-colorspace bgr \
-netType mnist-cluttered/prnmg.mnist \
-nEpochsSave 60 \
-nGPU 4 \
-train -test
