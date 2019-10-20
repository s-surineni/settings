export NODE_HOME=~/software/nnpm/node-v10.15.1-linux-x64
PATH=${NODE_HOME}/bin:${PATH}

# This is how they did in react
export ANDROID_HOME=$HOME/software/aandroid/AndroidSDK
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


# export JAVA_HOME=~/software/jjava/jdk1.8.0_201
# PATH=${JAVA_HOME}/bin:${PATH}
# export PATH
# for virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=$(which python3)
