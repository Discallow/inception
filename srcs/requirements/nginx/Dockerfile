# using penultimate stable version according to https://www.debian.org/releases/
FROM debian:bookworm

# Update package lists for apt-get
RUN apt-get -y update && \
# Install Nginx web server and OpenSSL for creating certificates
apt-get install -y nginx openssl && \
# Generate a self-signed TLS certificate and private key:
# -newkey rsa:4096     -> create a new RSA key of 4096 bits
# -sha256              -> use SHA-256 for hashing
# -x509                -> create a self-signed X.509 certificate
# -days 365            -> certificate validity of 365 days
# -nodes               -> do not encrypt the private key with a passphrase
# -out                 -> output path for the certificate file
# -keyout              -> output path for the private key file
# -subj                -> set certificate fields (non-interactively)
# C -> Country; ST -> State; L -> Locality; O -> Organization;
# OU -> Organizational unit; CN -> Common Name
openssl req -newkey rsa:4096 -sha256 -x509 -days 365 \
  -nodes -out /etc/ssl/certs/server.crt \
  -keyout /etc/ssl/private/server.key \
  -subj "/C=PT/ST=LIS/L=Lisbon/O=42/OU=Inception/CN=dioalexa.42.fr"


COPY ./conf/nginx.conf /etc/nginx/conf.d
COPY ./rickroll-roll.gif /var/www/html/rickroll-roll.gif

#This is only for documentation, since this is defined in Docker Compose, not in Dockerfile
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

