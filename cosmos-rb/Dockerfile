
FROM ballaerospace/cosmos

RUN ls -l
RUN cosmos demo /cos
RUN git clone https://github.com/spel-uchile/SUCHAI-Cosmos-Target
RUN ls -l /cosmos
RUN mv SUCHAI-Cosmos-Target/SUCHAI_TARGET /cosmos/config/targets/

WORKDIR /cosmos
RUN ls -l config/targets


CMD ruby Launcher