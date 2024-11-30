#!/usr/bin/env bash
IP=ip_of_server
DNS=docker.server

# Generate the CA (Certificate Authority)
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -subj "/CN=Docker-CA" -out ca.pem

# Generate the server key and certificate signing request (CSR)
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=$DNS" -new -key server-key.pem -out server.csr
echo "subjectAltName = IP:$IP,DNS:$DNS" > extfile.cnf
echo "extendedKeyUsage = serverAuth" >> extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial \
  -out server-cert.pem -extfile extfile.cnf

# Generate the client key and certificate signing request (CSR)
openssl genrsa -out client-key.pem 4096
openssl req -subj "/CN=client" -new -key client-key.pem -out client.csr
echo "extendedKeyUsage = clientAuth" > extfile-client.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial \
  -out client-cert.pem -extfile extfile-client.cnf

# Cleanup unnecessary files
rm -f server.csr client.csr extfile.cnf extfile-client.cnf
