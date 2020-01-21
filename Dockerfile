FROM cirrusci/android-sdk:28

RUN sudo apt-get update \
    && sudo apt-get install -y --allow-unauthenticated --no-install-recommends lib32stdc++6 libstdc++6 libglu1-mesa locales git \
    && sudo rm -rf /var/lib/apt/lists/*

## Require to install ruby
# RUN apt-get update && \
#     apt-get install -y \
#     git \
#     build-essential \
#     libssl-dev \
#     libreadline-dev \
#     zlib1g-dev

# Install rbenv
RUN sudo git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    sudo echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    sudo echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
    && exec $SHELL \
    && sudo git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
    && ls -l ~/.rbenv \
    && ls -l ~/.rbenv/bin \
    && sudo ~/.rbenv/bin/rbenv install 2.7.0 \
    && sudo ~/.rbenv/bin/rbenv global 2.7.0 \
    && sudo ruby --version \
    && sudo gem install fastlane -NV

# ENV PATH ~/.rbenv/shims:~/.rbenv/bin:$PATH

# Install ruby-build & ruby

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