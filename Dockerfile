FROM cirrusci/android-sdk:28

RUN sudo apt-get update \
    && sudo apt-get install -y --allow-unauthenticated --no-install-recommends lib32stdc++6 libstdc++6 libglu1-mesa locales \
    && sudo rm -rf /var/lib/apt/lists/*

# install ruby
RUN apt-get update \
    && apt-get install git \
    && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile \
    && echo 'eval "$(rbenv init -)"' >> ~/.bash_profile \
    && source ~/.bash_profile \
    && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
    && curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
rbenv -v
    && rbenv install 2.7.0 \
    && ruby --version \
    && sudo gem install fastlane -NV

# https://github.com/flutter/flutter/issues/18593#issuecomment-458375730
# Those tools are absolutely required for flutter to build APKs
RUN touch ~/.android/repositories.cfg \
    && sdkmanager "platforms;android-28" \
    && sdkmanager "tools" \
    && sdkmanager "platform-tools"

# RUN ruby --version && sudo gem install fastlane -NV

RUN sudo locale-gen en_US "en_US.UTF-8" \
    && sudo dpkg-reconfigure locales

ENV LANG en_US.UTF-8

ENV FLUTTER_HOME ${HOME}/sdks/flutter
ENV FLUTTER_VERSION 1.13.9

RUN git clone --branch v${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux

# doctor
RUN flutter doctor