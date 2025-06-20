FROM quay.io/lyfe00011/md:beta

# Install jq (JSON processor)
RUN apt-get update && apt-get install -y jq

# Clone the LyFE repo
RUN git clone https://github.com/lyfe00011/levanter.git /root/LyFE/

WORKDIR /root/LyFE/

# Inject baileys-pro and joanimi/baileys dependencies before install
RUN jq '.dependencies["@fizzxydev/baileys-pro"] = "^8.7.2" | .dependencies["@joanimi/baileys"] = "latest"' package.json > temp.json && mv temp.json package.json

# Install dependencies
RUN yarn install

# Start the app
CMD ["npm", "start"]
