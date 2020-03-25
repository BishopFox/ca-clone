#!/bin/bash

# This script generates a Digicert-CA lookalike cert that matches most of the same values of the real, selfsigned Digicert RSA certificate for use in cases where a client doesn't properly validate the server certificate presented. Use this in Burp (or wherever) to sign certificates for SSL/TLS.

CONFIG="
[req]
distinguished_name=dn
[ dn ]
[ ext ]
keyUsage=critical,cRLSign,keyCertSign,digitalSignature
basicConstraints=critical,CA:TRUE
subjectKeyIdentifier=03:DE:50:35:56:D1:4C:BB:66:F0:A3:E2:1B:1B:C3:97:B2:3D:D1:55
authorityKeyIdentifier=keyid,issuer
"

echo "[INFO] Generating new RSA key..."
openssl genrsa -out cloned_root_ca_digicert.key 2048

echo "[INFO] Generating self signed certificate..."
openssl req -config <(echo "$CONFIG") -x509 -new -nodes -key cloned_root_ca_digicert.key -sha1 -days 7062 -out cloned_root_ca_digicert.crt -set_serial 0x083be056904246b1a1756ac95991c74a -subj "/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert Global Root CA" -extensions ext

echo "[INFO] Showing certificate information..."
# The following command shows information about the certificate
openssl x509 -in cloned_root_ca_digicert.crt -noout -text

echo "[INFO] Converting certificate to PKCS12..."
# The following will convert the certiciate into a PKCS12 file for use in Burp.
openssl pkcs12 -export -passout pass:password -inkey cloned_root_ca_digicert.key -in cloned_root_ca_digicert.crt -out cloned_root_ca_digicert_combo.p12

echo ""
echo "[INFO] Successfully cloned certificates into 'cloned_root_ca_digicert_combo.p12'"

# DigiCert Reference Certificate
# -----BEGIN CERTIFICATE-----
# MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBh
# MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
# d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBD
# QTAeFw0wNjExMTAwMDAwMDBaFw0zMTExMTAwMDAwMDBaMGExCzAJBgNVBAYTAlVT
# MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
# b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IENBMIIBIjANBgkqhkiG
# 9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4jvhEXLeqKTTo1eqUKKPC3eQyaKl7hLOllsB
# CSDMAZOnTjC3U/dDxGkAV53ijSLdhwZAAIEJzs4bg7/fzTtxRuLWZscFs3YnFo97
# nh6Vfe63SKMI2tavegw5BmV/Sl0fvBf4q77uKNd0f3p4mVmFaG5cIzJLv07A6Fpt
# 43C/dxC//AH2hdmoRBBYMql1GNXRor5H4idq9Joz+EkIYIvUX7Q6hL+hqkpMfT7P
# T19sdl6gSzeRntwi5m3OFBqOasv+zbMUZBfHWymeMr/y7vrTC0LUq7dBMtoM1O/4
# gdW7jVg/tRvoSSiicNoxBN33shbyTApOB6jtSj1etX+jkMOvJwIDAQABo2MwYTAO
# BgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUA95QNVbR
# TLtm8KPiGxvDl7I90VUwHwYDVR0jBBgwFoAUA95QNVbRTLtm8KPiGxvDl7I90VUw
# DQYJKoZIhvcNAQEFBQADggEBAMucN6pIExIK+t1EnE9SsPTfrgT1eXkIoyQY/Esr
# hMAtudXH/vTBH1jLuG2cenTnmCmrEbXjcKChzUyImZOMkXDiqw8cvpOp/2PV5Adg
# 06O/nVsJ8dWO41P0jmP6P6fbtGbfYmbW0W5BjfIttep3Sp+dWOIrWcBAI+0tKIJF
# PnlUkiaY4IBIqDfv8NZ5YBberOgOzW6sRBc4L0na4UU+Krk2U886UAb3LujEV0ls
# YSEY1QSteDwsOoBrp+uvFRTp2InBuThs4pFsiv9kuXclVzDAGySj4dzp30d8tbQk
# CAUw7C29C79Fv1C5qfPrmAESrciIxpg0X40KPMbp1ZWVbd4=
# -----END CERTIFICATE-----