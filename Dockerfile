FROM alpine

ENV BOT_TOKEN ""
ENV BOT_USERID ""

RUN apk --update add --no-cache --virtual .build-deps \
        python3 gcc musl-dev git make g++ nodejs \
        npm openssh; \
    git clone https://github.com/botgram/botgram.git; \
    cd botgram; \
    npm install --save request; \
    npm install; \
    mkdir modules; \
    cd modules; \
    git clone https://github.com/botgram/shell-bot.git; \
    cd shell-bot; \
    npm install; \
    echo -e " \
    {\n \
    "authToken": \"$BOT_TOKEN\",\n \
    "owner": $BOT_USERID\n \
    } \
    " >> config.json;
WORKDIR /botgram/modules/shell-bot/
CMD npm start