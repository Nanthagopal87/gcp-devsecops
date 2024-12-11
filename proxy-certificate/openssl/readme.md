You can view the contents of a proxy certificate (or any certificate) using tools like `openssl`, `keytool`, or graphical tools like web browsers. Here’s how to do it with `openssl`:

### Using `openssl`
1. **If you have the certificate as a file (`.crt`, `.pem`, or similar):**
   - Run the following command:
     ```bash
     openssl x509 -in <certificate-file> -text -noout
     ```
     Example:
     ```bash
     openssl x509 -in proxy-cert.crt -text -noout
     ```

   - This command displays the human-readable details of the certificate, such as:
     - Subject
     - Issuer
     - Validity period
     - Public key
     - Extensions, including any proxy-specific details.

2. **If the certificate is embedded in a `.p12` or `.pfx` file:**
   - First, extract the certificate:
     ```bash
     openssl pkcs12 -in <pfx-file> -clcerts -nokeys -out extracted-cert.pem
     ```
   - Then view it:
     ```bash
     openssl x509 -in extracted-cert.pem -text -noout
     ```

3. **If you want to decode a certificate from Base64 format (like PEM format):**
   - Save the certificate content to a file (if not already).
   - Use the same `openssl x509` command as above.

---

### Using `keytool`
If the certificate is part of a Java keystore:
1. List the aliases in the keystore:
   ```bash
   keytool -list -keystore <keystore-file>
   ```
2. View the certificate details:
   ```bash
   keytool -exportcert -alias <alias-name> -keystore <keystore-file> -rfc
   ```

---

### Using Web Browsers
If the certificate is part of an HTTPS connection, you can view it in a browser:
1. Open the site using HTTPS.
2. Click the padlock icon in the address bar.
3. View certificate details (steps vary by browser).

Let me know if you’re looking for something specific in the proxy certificate or need help troubleshooting!