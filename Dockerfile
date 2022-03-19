FROM debian:bullseye

RUN apt-get update &&\
    apt-get install -yq python3 python3-pip &&\
    apt-get clean

RUN  mkdir /var/lib/discordmt

COPY server.py          /var/lib/discordmt/
COPY requirements.txt   /var/lib/discordmt/
COPY relay.conf         /var/lib/discordmt/
COPY discord.sh         /var/lib/discordmt/

RUN adduser --system --uid 1000 --group --home /var/lib/discordmt discordmt &&\
    chown -R discordmt:discordmt /var/lib/discordmt

USER discordmt
WORKDIR /var/lib/discordmt/
ENV PATH="$PATH:/var/lib/discordmt/.local/bin"
RUN pip install --user -r requirements.txt
CMD /var/lib/discordmt/discord.sh