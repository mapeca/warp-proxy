FROM debian:bookworm

# Install required packages
# Required by warp
# - sudo curl gpg lsb-release dbus
# - iptables (redirect packets from 0.0.0.0 to 127.0.0.1) because warp only binds to 127.0.0.1
RUN apt update && apt install -y sudo curl gpg lsb-release dbus iptables

# Setup repos
RUN curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

# Install warp
RUN sudo apt-get update && sudo apt-get install cloudflare-warp -y

# Accept tos
RUN mkdir -p $HOME/.local/share/warp && echo "yes" > $HOME/.local/share/warp/accepted-tos.txt

# Copy entrypoint and prepare to run
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Indicate default port
EXPOSE 40000

ENTRYPOINT ["/entrypoint.sh"]