th main.lua \
-data $HOME_PREFIX/data/mnist-cluttered \
-dataset mnist-seg \
-nDonkeys 4 \
-nEpochs 200 \
-epochSize 150 \
-batchSize 64 \
-colorspace bgr \
-netType unmg \
-nEpochsSave 60 \
-train -test
